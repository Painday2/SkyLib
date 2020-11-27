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
    local factory_id = self._values.weapon_id or "wpn_fps_ass_m4"

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
        local current_peer_weapon = instigator:inventory():equipped_unit():base()._factory_id
        local clbk_gpwbf = self:_get_punched_weapon_by_factory(current_peer_weapon)
        if clbk_gpwbf then
            factory_id = clbk_gpwbf
        end
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