ZMWallbuyBase = ZMWallbuyBase or class(UnitBase)
ZMWallbuyBase.unit_list = {}
ZMWallbuyBase.prop_list = {"units/pd2_mod_zombies/props/zm_wallbuy_dummy/zm_wallbuy_dummy"}
function ZMWallbuyBase:init(unit)
	UnitBase.init(self, unit, false)

    self._unit = unit
    self._weapon_spawned = false
    --insert so we can access the units for sync reasons
    table.insert(ZMWallbuyBase.unit_list, unit)

	--yes i stole the missionelement base. no i won't say sorry.
    --Add a element icon/text to display location and info
	if Global.editor_mode then
        local iconsize = EditorPart:Val("ElementsSize") or 32
        local root = self._unit:get_objects_by_type(Idstring("object3d"))[1]
        if root == nil then
            return
        end

        self._gui = World:newgui()
        local pos = root:position() - Vector3(iconsize / 2, iconsize / 2, 0)
        self._ws = self._gui:create_linked_workspace(iconsize / 2, iconsize / 2, root, pos, Vector3(iconsize, 0, 0), Vector3(0, iconsize, 0))
        self._ws:set_billboard(self._ws.BILLBOARD_BOTH)
        local colors = {
            Color("ffffff"),
            Color("0d449c"),
            Color("16b329"),
            Color("eec022"),
            Color("9519ca"),
            Color("d31f07"),
            Color("555555"),
            Color("ea34ca"),
            Color("179d9b"),
            Color("0c243e"),
            Color("2c2c2c"),
            Color("5fc16f"),
        }

        self._color = EditorPart:Val("RandomizedElementsColor") and colors[math.random(1, #colors)] or EditorPart:Val("ElementsColor")
        local texture, rect = "textures/editor_icons_df", {225, 1, 62, 62}
        local size = iconsize / 4
        local font_size = iconsize / 8
        self._icon = self._ws:panel():bitmap({
            texture = texture,
            texture_rect = rect,
            render_template = "OverlayVertexColorTextured",
            color = self._color,
            rotation = 360,
            y = font_size,
            x = font_size,
            w = size,
            h = size,
        }) 
        self._text = self._ws:panel():text({
            render_template = "OverlayVertexColorTextured",
            font = "fonts/font_large_mf",
            font_size = font_size,
            w = iconsize / 2,
            h = font_size,
            rotation = 360,
            align = "center",
            color = self._color,
            text = "SkyLib (Unit) - zm_wallbuy",
        })
        self._enabled = true
        self._visible = true
        self._text:set_bottom(self._icon:top() - font_size)
    end
end

--if you make a custom unit, post hook this and insert your unit.
--only used for editor atm, but may be required in the future.
function ZMWallbuyBase:fill_prop_list()
    --table.insert(ZMWallbuyBase.prop_list, "units/pd2_mod_zombies/props/zm_wallbuy_dummy/zm_wallbuy_dummy")
end

function ZMWallbuyBase:interacted(player)
    if player then
        --check if player is refilling ammo, if so refill it
        local weapon_id = self._unit:base()._weapon_id or "amcar"
        local current_state = managers.player:get_current_state()
        if current_state then
            local current_weapon = current_state:get_equipped_weapon()
            if weapon_id == current_weapon.name_id then
                current_weapon._unit:base():soft_replenish()
                managers.hud:set_ammo_amount( current_weapon.forced_selection_index, current_weapon._unit:base():ammo_info() )
            else
                SkyLib.CODZ.WeaponHelper:_perform_weapon_switch(self._weapon_id, player)
                self._unit:damage():run_sequence_simple("interact")
            end
        else
            SkyLib.CODZ.WeaponHelper:_perform_weapon_switch(self._weapon_id, player)
            self._unit:damage():run_sequence_simple("interact")
        end
    end
end

function ZMWallbuyBase:spawn_weapon()
    self._weapon_id = self._unit:unit_data().weapon_id or "amcar"
    --if nades, then spawn nade unit
    if Network:is_server() and self._weapon_id == "nades" then
        local unit_name = "units/pd2_dlc_drm/weapons/smoke_grenade_tear_gas/smoke_grenade_tear_gas"
        if not managers.dyn_resource:is_resource_ready(Idstring("unit"), unit_name, managers.dyn_resource.DYN_RESOURCES_PACKAGE) then
            managers.dyn_resource:load(Idstring("unit"), Idstring(unit_name), DynamicResourceManager.DYN_RESOURCES_PACKAGE, false)
        end
        --spawn and position unit
            self._nade_unit = World:spawn_unit(Idstring(unit_name), self._unit:position(), self._unit:rotation())
            self._unit:link(Idstring("sp_weapon"), self._nade_unit, self._nade_unit:orientation_object():name())
            self._nade_unit:set_rotation(self._nade_unit:rotation() * Rotation(40, 0, 90))
        return
    end

    local factory_id = managers.weapon_factory:get_factory_id_by_weapon_id(self._weapon_id) or managers.weapon_factory:get_factory_id_by_weapon_id("amcar")
    local blueprint = managers.weapon_factory:get_default_blueprint_by_factory_id(factory_id)
    local cosmetics =  {id = "nil", quality = 1, bonus = 0}
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
    self._weapon_spawned = true
end

function ZMWallbuyBase:despawn_weapon()
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
    if alive(self._nade_unit) then
		self._nade_unit:set_slot(self._nade_unit, 0)
        World:delete_unit(self._nade_unit)
        self._nade_unit = nil
	end
end

function ZMWallbuyBase:_assemble_completed()
    --have to manually set position/rotation for them to update correctly
	if self._weapon_unit then
		self._unit:link(Idstring("sp_weapon"), self._weapon_unit, self._weapon_unit:orientation_object():name())
		--position weapon to not be in the wall, works for most AR/SG/SNP, LMGs will probably clip no matter what
		self._weapon_unit:set_position(self._unit:position() + self._unit:rotation():x() * 4)
	else
		log("weapon unit no existy")
	end
    --position second weapon
    if self._second_unit then
        self._weapon_unit:set_position(self._unit:position() + self._unit:rotation():x() * 5)
        local rotation = self._weapon_unit:rotation()
        self._weapon_unit:link(self._weapon_unit:orientation_object():name(), self._second_unit)
        self._second_unit:set_position(self._weapon_unit:position() + rotation:x() * -5 + rotation:z() * 7 + rotation:y() * 1)
        self._second_unit:set_rotation(self._weapon_unit:rotation() * Rotation(0, 8, 0))
    end
end

--send unit id weapon id and cost for sync
function ZMWallbuyBase:sync_data(unit)
    local uid = unit:id()
    local wid = unit:unit_data().weapon_id or self._weapon_id
    local cost = unit:unit_data().cost or 5000
    local data = {uid, wid, cost}
    SkyLib.Network:_send("ZMWallBuyData", data)
end

--recieve wallbuy data (unit id, weapon id and cost) from host and spawn unit
function ZMWallbuyBase:sync_spawn(data)
    if data then
        for _, unit in ipairs(ZMWallbuyBase.unit_list) do
            if unit:id() == tonumber(data["1"]) then
                unit:unit_data().weapon_id = tostring(data["2"])
                unit:unit_data().cost = tonumber(data["3"])
                unit:base():spawn_weapon()
                table.remove(ZMWallbuyBase.unit_list, data["1"])
                break
            end
        end
    end
end

--Needed to load the unit data correctly, i guess?
SkyHook:Post(WorldDefinition, "assign_unit_data", function(self, unit, data)
    if data.weapon_id then
		unit:unit_data().weapon_id = data.weapon_id
        unit:unit_data().cost = data.cost
	end
end)

--Hook to send wallbuy data on spawn, due to unit networking not being setup til around then. 
SkyHook:Post(CriminalsManager, "add_character", function(self, _, peer_id)
    --ran per player, make sure it only runs once
    self.wallbuy_sync_setup = self.wallbuy_sync_setup or nil
    if Network:is_server() and not SkyLib.Network:_is_solo() and not self.wallbuy_sync_setup then
        for _, unit in ipairs(ZMWallbuyBase.unit_list) do
            unit:base():sync_data(unit)
            self.wallbuy_sync_setup = true
        end
    end
end)

ZMWallbuyInteractionExt = ZMWallbuyInteractionExt or class(UseInteractionExt)
function ZMWallbuyInteractionExt:interact(player)
	--ZMWallbuyInteractionExt.super.interact(self, player)
    self._tweak_data_at_interact_start = nil

	if self._tweak_data.zm_interaction then

		if not self._unit:unit_data().cost then
			self._unit:unit_data().cost = self._tweak_data.points_cost or 0
		end

		local amount_to_deduct = 0 - self._unit:unit_data().cost

		if self._tweak_data.wallbuy and not self._unit:base()._weapon_id == "nades" then
			local weapon_id = self._unit:base()._weapon_id or "amcar"
			local current_state = managers.player:get_current_state()
			if current_state then
				local current_weapon = current_state:get_equipped_weapon()

				if current_weapon.name_id == weapon_id then
					amount_to_deduct = math.round(amount_to_deduct / 2, 50)
				end
			end
		end

		local peer_id = 1

		if managers and managers.network then
			local peer = managers.network:session():peer_by_unit(player)
			peer_id = peer:id()
		end

		if peer_id == SkyLib.Network:_my_peer_id() then
			SkyLib.CODZ:_money_change(amount_to_deduct, peer_id)
		end

        if self._unit:base()._weapon_id == "nades" then
            if player == managers.player:player_unit() then
                managers.player:add_grenade_amount(10, true)
            end
            return
        end

        self._unit:base():interacted(player)
	end

	self:_post_event(player, "sound_done")
end

function ZMWallbuyInteractionExt:selected(player, locator, hand_id)
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
		cost = tonumber(self._unit:unit_data().cost) or self._tweak_data.points_cost or 0
		text = "Hold " .. managers.localization:btn_macro("interact") .. " to buy"

		if self._tweak_data.wallbuy then
            local weapon_id = self._unit:base()._weapon_id or "amcar"
            local nade_spot = weapon_id == "nades" and true or false
			if nade_spot then
				text = "Hold " .. managers.localization:btn_macro("interact") .. " to refill your throwables"
			end

			local item
			local own_weapon = false

			if not nade_spot then
                item = managers.localization:text(tostring(tweak_data.weapon[weapon_id].name_id))
				local current_state = managers.player:get_current_state()
				if current_state then
					local current_weapon = current_state:get_equipped_weapon()

					if current_weapon.name_id == weapon_id then
						text = "Hold " .. managers.localization:btn_macro("interact") .. " to refill the ammo of"
						cost = math.round(cost / 2, 50)
						own_weapon = true
					end
				end
			end

			if current_money >= cost then
				if not nade_spot then text = text .. " the " .. item end
				text = text .. " [Cost : " .. cost .. "]"
			else
				local points_needed = cost - current_money

				if not nade_spot then
					text = "You need " .. points_needed .. " more points to buy the " .. item
				else
					text = "You need " .. points_needed .. " more points to refill your throwables"
				end

				if own_weapon then
					if not nade_spot then text = "You need " .. points_needed .. " more points to refill the ammo of the " .. item end
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