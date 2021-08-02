MisterySafeBase = MisterySafeBase or class(UnitBase)

function MisterySafeBase:init(unit)
	UnitBase.init(self, unit, false)

    self._unit = unit
    self._weapon_spawned = false
    self._weapon_queue = 0
end


function MisterySafeBase:interacted(player)
    if self._weapon_spawned and player and player ==  self._weapon_owner then
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
        self._unit:damage():run_sequence_simple("anim_open_door")

        self._weapon_id = self:_get_random_weapon()
        --log(self._weapon_id)
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
        if player then
            self._unit:damage():run_sequence_simple("anim_close_door")
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
            log("wait done")
            if self._weapon_spawned and self._weapon_queue == 1 then
                self._unit:damage():run_sequence_simple("anim_close_door")
                self._weapon_queue = 0
            else
                self._weapon_queue = self._weapon_queue - 1
            end
        end)
    end
end

MisterySafeInteractionExt = MisterySafeInteractionExt or class(UseInteractionExt)

function MisterySafeInteractionExt:can_select(player)
    if self._weapon_spawned and not self._weapon_owner == player then
        return false
    end
	return MisterySafeInteractionExt.super.can_select(self, player)
end

function MisterySafeInteractionExt:interact(player)
	MisterySafeInteractionExt.super.interact(self, player)
	self._unit:base():interacted(player)
end