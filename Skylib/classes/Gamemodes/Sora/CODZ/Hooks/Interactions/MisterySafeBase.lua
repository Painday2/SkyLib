MisterySafeBase = MisterySafeBase or class(UnitBase)
MisterySafeBase.unit_list = {}
function MisterySafeBase:init(unit)
	UnitBase.init(self, unit, false)

    self._unit = unit
    self._weapon_spawned = false
    self._weapon_queue = 0
    --insert so we can access the units for sync reasons
    table.insert(MisterySafeBase.unit_list, unit)
end


function MisterySafeBase:interacted(player)
    if self._weapon_spawned and player and player:id() == self._weapon_owner:id() then
        SkyLib.CODZ.WeaponHelper:_perform_weapon_switch(self._weapon_id, player)
    end

    self:set_state(not self._weapon_spawned, player)
end

function MisterySafeBase:set_state(state, player)
    if self._weapon_unit then
        self:despawn_weapon()
    end

    if state and player then
        self._weapon_spawned = true
        self._weapon_owner = player
        self._unit:damage():run_sequence("anim_open_door")
        self._weapon_id = self.sync_weapon_id or self:_get_random_weapon() or "amcar"
        --prevent loops of syncing
        if not self.sync_weapon_id then
            self:sync_data(self._unit, player, self._weapon_id)
            self.sync_weapon_id = self._weapon_id
        end

        local factory_id = managers.weapon_factory:get_factory_id_by_weapon_id(self._weapon_id) or managers.weapon_factory:get_factory_id_by_weapon_id("amcar")
        local blueprint = managers.weapon_factory:get_default_blueprint_by_factory_id(factory_id)
        --log("Factory ID:" .. factory_id)
	    local unit_name = tweak_data.weapon.factory[factory_id].unit
	    if not managers.dyn_resource:is_resource_ready(Idstring("unit"), unit_name, managers.dyn_resource.DYN_RESOURCES_PACKAGE) then
	    	managers.dyn_resource:load(Idstring("unit"), Idstring(unit_name), DynamicResourceManager.DYN_RESOURCES_PACKAGE, false)
        end
	    self._weapon_unit = World:spawn_unit(Idstring(unit_name), self._unit:position(), Rotation())
        self._parts = managers.weapon_factory:assemble_from_blueprint(factory_id, self._weapon_unit, blueprint, true, true, callback(self, self, "_assemble_completed"))
        --if akimbo, spawn a second weapon
        if self._weapon_unit:base().AKIMBO and not self._second_unit then
            self._second_unit = World:spawn_unit(Idstring(unit_name), self._weapon_unit:position(), self._weapon_unit:rotation())
            self._second_parts = managers.weapon_factory:assemble_from_blueprint(factory_id, self._second_unit, blueprint, true, true, callback(self, self, "_assemble_completed"))
        end
    else
        self._weapon_spawned = false
        self._weapon_owner = nil
        self._weapon_id = nil
        self.sync_weapon_id = nil

        if player then
            self._unit:damage():run_sequence("anim_close_door")
            self:sync_data(self._unit)
        end
    end
end

function MisterySafeBase:_assemble_completed()
    self._unit:link(Idstring("sp_weapon"), self._weapon_unit, self._weapon_unit:orientation_object():name())
    --position second weapon
    if self._second_unit then
        local rotation = self._weapon_unit:rotation()
        self._weapon_unit:link(self._weapon_unit:orientation_object():name(), self._second_unit)
        self._second_unit:set_position(self._weapon_unit:position() + rotation:x() * -10 + rotation:z() * 7 + rotation:y() * 1)
        self._second_unit:set_rotation(self._weapon_unit:rotation() * Rotation(0, 8, 0))
    end
end

function MisterySafeBase:despawn_weapon()
	if alive(self._weapon_unit) then
		for part_id, data in pairs(self._parts) do
			if alive(data.unit) then
				World:delete_unit(data.unit)
			end
		end

		self._weapon_unit:base():set_slot(self._weapon_unit, 0)
        World:delete_unit(self._weapon_unit)
        self._weapon_unit = nil
	end
    if alive(self._second_unit) then
		for part_id, data in pairs(self._second_parts) do
			if alive(data.unit) then
				World:delete_unit(data.unit)
			end
		end

		self._second_unit:base():set_slot(self._second_unit, 0)
        World:delete_unit(self._second_unit)
        self._second_unit = nil
	end
end

function MisterySafeBase:_get_random_weapon()
	local table_available_weapons_mystery_box = SkyLib.CODZ._weapons.mystery_box

    local random_entry = table_available_weapons_mystery_box[math.random(#table_available_weapons_mystery_box)]
	return random_entry
end

--jank to prevent the box closing from previous openings
function MisterySafeBase:timer_start()
    if self._weapon_spawned then
        self._weapon_queue = self._weapon_queue + 1
        SkyLib:wait(8, function()
            if self._weapon_spawned and self._weapon_queue == 1 then
                self._unit:damage():run_sequence("anim_close_door")
                self._weapon_queue = 0
            else
                self._weapon_queue = self._weapon_queue - 1
            end
        end)
    end
end

--send box state data to other players
function MisterySafeBase:sync_data(unit, player, weapon_id)
    local pid = player and player:id() or nil
    local data = {unit:id(), pid, weapon_id}
    SkyLib.Network:_send("ZMBoxData", data)
end

--recieve box data (unit, player, weapon_id) from host and set the state for the other players
function MisterySafeBase:sync_spawn(data)
    if data then
        for _, unit in ipairs(MisterySafeBase.unit_list) do
            if unit:id() == tonumber(data["1"]) then
                local player = data["2"] or nil
                self.sync_weapon_id = data["3"] or nil
                if player then
                    unit:base():set_state(not self._weapon_spawned, player)
                else
                    unit:base():set_state(false)
                    unit:damage():run_sequence("anim_close_door")
                end
                break
            end
        end
    end
end

MisterySafeInteractionExt = MisterySafeInteractionExt or class(UseInteractionExt)
--prevent other players from stealing your box
function MisterySafeInteractionExt:can_select(player)
    if self._unit:base()._weapon_spawned and self._unit:base()._weapon_owner ~= player then
        return false
    end
	return MisterySafeInteractionExt.super.can_select(self, player)
end

function MisterySafeInteractionExt:selected(player, locator, hand_id)
	if not self:can_select(player) then
		return
	end

	self._hand_id = hand_id
	self._is_selected = true
	local string_macros = {}

	self:_add_string_macros(string_macros)

	local text = ""
	local icon = ""
    local current_money = SkyLib.CODZ:_get_own_money()
	local cost

	--Is a Zombie Mode Interaction?
	if self._tweak_data.zm_interaction then
		cost = self._unit:unit_data().cost or self._tweak_data.points_cost or 0
		text = "Hold " .. managers.localization:btn_macro("interact") .. " to buy"

        if self._tweak_data.mystery_box then
			text = text .. " a random weapon"

			if SkyLib.CODZ:_is_event_active("firesale") then
				cost = 10
				self:quick_swap()
			end

			if current_money >= cost then
				text = text .. " [Cost : " .. cost .. "]"
			else
				local points_needed = cost - current_money
				text = "You need " .. points_needed .. " more points to buy a random weapon"
			end
		end

        if self._tweak_data.box_weapon then
			local weapon_id = self._unit:base()._weapon_id or "amcar"
			local item = managers.localization:text(tostring(tweak_data.weapon[weapon_id].name_id))
			local own_weapon = false

			text = "Hold " .. managers.localization:btn_macro("interact") .. " to grab the " .. item

			local current_state = managers.player:get_current_state()
			if current_state then
				local current_weapon = current_state:get_equipped_weapon()

				if current_weapon.name_id == weapon_id then
					text = "Hold " .. managers.localization:btn_macro("interact") .. " to refill the ammo of the " .. item
					own_weapon = true
				end
			end
		end
    end

	managers.hud:show_interact({
		text = text,
		icon = icon
	})

	return true
end

function MisterySafeInteractionExt:interact(player)
    if not self:can_interact(player) then
        return
    end
	MisterySafeInteractionExt.super.interact(self, player)
	self._unit:base():interacted(player)
end