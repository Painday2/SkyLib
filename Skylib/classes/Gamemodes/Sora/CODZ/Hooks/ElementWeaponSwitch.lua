core:import("CoreMissionScriptElement")
ElementWeaponSwitch = ElementWeaponSwitch or class(CoreMissionScriptElement.MissionScriptElement)

function ElementWeaponSwitch:init(...)
	ElementWeaponSwitch.super.init(self, ...)
end

function ElementWeaponSwitch:client_on_executed(...)
    self:on_executed(...)
end

function ElementWeaponSwitch:on_executed(instigator)
    if not self._values.enabled then
		self._mission_script:debug_output("Element '" .. self._editor_name .. "' not enabled. Skip.", Color(1, 1, 0, 0))
		return
    end
    
    -- Grenade spot ? Call it directly and refill nades. Terminate it afterwards.

    if self._values.is_grenade_spot then
        if instigator == managers.player:player_unit() then
            managers.player:add_grenade_amount(10, true)
        end

        ElementWeaponSwitch.super.on_executed(self, instigator)
        return
    end

    -- Base Factory ID before assuming the current slot
    local cosmetics
    local cosmetics_string = self._values.skin_id or "nil" .. "-1-0"
    local cosmetics_data = string.split(cosmetics_string, "-")
    local weapon_skin_id = cosmetics_data[1] or "nil"
    local quality_index_s = cosmetics_data[2] or "1"
    local bonus_id_s = cosmetics_data[3] or "0"
    if weapon_skin_id ~= "nil" then
        local quality = tweak_data.economy:get_entry_from_index("qualities", tonumber(quality_index_s))
        local bonus = bonus_id_s == "1" and true or false
        cosmetics = "pap-1-0"

        if instigator == managers.player:player_unit() then
            cosmetics = {
                id = weapon_skin_id,
                quality = quality,
                bonus = bonus
            }
        end
    end

    -- Random factory weapon if the interaction is on a mystery box
    if self._values.is_mystery_box then
        SkyLib.CODZ.WeaponHelper:_get_random_weapon()
    end

    -- Script used to get the start weapons
    if self._values.force_secondary then
        SkyLib.CODZ.WeaponHelper:_perform_weapon_switch(self._values.weapon_id, true, false)
    end

    if self._values.force_primary then
        SkyLib.CODZ.WeaponHelper:_perform_weapon_switch(self._values.weapon_id, false, true)
    end

    -- Get the upgraded weapon ID if the pack-a-punch box is used.
    if self._values.is_pap_engine then
        SkyLib.CODZ.WeaponHelper:_perform_weapon_switch(false, false, false, true, cosmetics)
    end

    ElementWeaponSwitch.super.on_executed(self, instigator)
end

function ElementWeaponSwitch:_get_punched_weapon_by_factory(factory)
	local tbl = managers.wdu:_convert_factory_to_upgrade()

	local punch_tbl = {}

	for k, v in pairs(tbl) do
		table.insert(punch_tbl, v)
	end

	for _, v in ipairs(punch_tbl) do -- Refill ammo on punched weapon.
		if v == factory then
			return v
		end
	end

	for k, v in pairs(tbl) do
		if k == factory then
			return v
		end
	end

	return "wpn_fps_ass_m4"
end

function ElementWeaponSwitch:on_script_activated()
    self._mission_script:add_save_state_cb(self._id)
end

function ElementWeaponSwitch:save(data)
    data.save_me = true
    data.enabled = self._values.enabled
end

function ElementWeaponSwitch:load(data)
    self:set_enabled(data.enabled)
end