function RaycastWeaponBase:selection_index()
	return self.forced_selection_index or self:weapon_tweak_data().use_data.selection_index
end

function RaycastWeaponBase:start_shooting_allowed()
	if self:gadget_overrides_weapon_functions() then
		return self:gadget_function_override("start_shooting_allowed")
	end

	if not self._unit then
		return false
	end

	return self._next_fire_allowed <= self._unit:timer():time()
end

Hooks:PostHook(RaycastWeaponBase, "fire", "zm_pap_sound_click", function(self)
	if string.find(self._name_id, "_upg_") then
		self._sound_fire:post_event("zm_pew_global")
	end
end)

function RaycastWeaponBase:reload_speed_multiplier()
	local multiplier = 1

	for _, category in ipairs(self:weapon_tweak_data().categories) do
		multiplier = multiplier * managers.player:upgrade_value(category, "reload_speed_multiplier", 1)
	end

	multiplier = multiplier * managers.player:upgrade_value("weapon", "passive_reload_speed_multiplier", 1)
	multiplier = multiplier * managers.player:upgrade_value(self._name_id, "reload_speed_multiplier", 1)
	multiplier = multiplier * (managers.player:has_special_equipment("perk_speedcola") and 2 or 1)

	return multiplier
end

function RaycastWeaponBase:fire_rate_multiplier()
	local multiplier = 1
	multiplier = multiplier * (managers.player:has_special_equipment("perk_doubletap") and 1.25 or 1)

	return multiplier
end

function RaycastWeaponBase:damage_multiplier()
	local multiplier = 1

	for _, category in ipairs(self:weapon_tweak_data().categories) do
		multiplier = multiplier * managers.player:upgrade_value(category, "damage_multiplier", 1)
	end

	multiplier = multiplier * managers.player:upgrade_value(self._name_id, "damage_multiplier", 1)
	multiplier = multiplier * (managers.player:has_special_equipment("perk_doubletap") and 1.25 or 1)

	return multiplier
end

InstantExplosiveBulletBase.EFFECT_PARAMS.sound_muffle_effect = false