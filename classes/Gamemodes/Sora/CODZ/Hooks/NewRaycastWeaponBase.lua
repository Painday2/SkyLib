local mvec3_set = mvector3.set
local mvec3_add = mvector3.add
local mvec3_dot = mvector3.dot
local mvec3_sub = mvector3.subtract
local mvec3_mul = mvector3.multiply
local mvec3_norm = mvector3.normalize
local mvec3_dir = mvector3.direction
local mvec3_set_l = mvector3.set_length
local mvec3_len = mvector3.length
local math_clamp = math.clamp
local math_lerp = math.lerp
local tmp_vec1 = Vector3()
local tmp_vec2 = Vector3()
local ids_single = Idstring("single")
local ids_auto = Idstring("auto")

function NewRaycastWeaponBase:reload_speed_multiplier()
	if self._current_reload_speed_multiplier then
		return self._current_reload_speed_multiplier
	end

	local multiplier = 1

	for _, category in ipairs(self:weapon_tweak_data().categories) do
		multiplier = multiplier + 1 - managers.player:upgrade_value(category, "reload_speed_multiplier", 1)
	end

	multiplier = multiplier + 1 - managers.player:upgrade_value("weapon", "passive_reload_speed_multiplier", 1)
	multiplier = multiplier + 1 - managers.player:upgrade_value(self._name_id, "reload_speed_multiplier", 1)

	if self._setup and alive(self._setup.user_unit) and self._setup.user_unit:movement() then
		local morale_boost_bonus = self._setup.user_unit:movement():morale_boost()

		if morale_boost_bonus then
			multiplier = multiplier + 1 - morale_boost_bonus.reload_speed_bonus
		end

		if self._setup.user_unit:movement():next_reload_speed_multiplier() then
			multiplier = multiplier + 1 - self._setup.user_unit:movement():next_reload_speed_multiplier()
		end
	end

	if managers.player:has_activate_temporary_upgrade("temporary", "reload_weapon_faster") then
		multiplier = multiplier + 1 - managers.player:temporary_upgrade_value("temporary", "reload_weapon_faster", 1)
	end

	if managers.player:has_activate_temporary_upgrade("temporary", "single_shot_fast_reload") then
		multiplier = multiplier + 1 - managers.player:temporary_upgrade_value("temporary", "single_shot_fast_reload", 1)
	end

	multiplier = multiplier + 1 - managers.player:get_property("shock_and_awe_reload_multiplier", 1)
	multiplier = multiplier + 1 - managers.player:get_temporary_property("bloodthirst_reload_speed", 1)
	multiplier = multiplier + 1 - managers.player:upgrade_value("team", "crew_faster_reload", 1)
	multiplier = self:_convert_add_to_mul(multiplier)
	multiplier = multiplier * self:reload_speed_stat()
	multiplier = multiplier * (managers.player:has_special_equipment("perk_speedcola") and 2 or 1)

	return multiplier
end

function NewRaycastWeaponBase:_update_rof_on_perk()
	local user_unit = self._setup and self._setup.user_unit
	local current_state = alive(user_unit) and user_unit:movement() and user_unit:movement()._current_state

	if managers.player:has_special_equipment("perk_doubletap") then
		self._fire_rate_multiplier = managers.blackmarket:fire_rate_multiplier(self._name_id, self:weapon_tweak_data().categories, self._silencer, nil, current_state, self._blueprint) * 1.25
	else
		self._fire_rate_multiplier = managers.blackmarket:fire_rate_multiplier(self._name_id, self:weapon_tweak_data().categories, self._silencer, nil, current_state, self._blueprint)
	end
end

SkyHook:Post(NewRaycastWeaponBase, "init", function(self)
	local allowed_weapons = {
		"wunderwaffe_primary",
		"wunderwaffe_secondary",
		"wunderwaffe_dg3_primary",
		"wunderwaffe_dg3_secondary"
	}

	for k, v in pairs(allowed_weapons) do
		if self._name_id == v then

			self.TRAIL_EFFECT = Idstring("units/pd2_mod_zombies/effects/particles/weapons/shovel")

			if v == "wunderwaffe_dg3_primary" or v == "wunderwaffe_dg3_secondary" then
				self.TRAIL_EFFECT = Idstring("units/pd2_mod_zombies/effects/particles/weapons/super_shovel")
			end

			self._trail_effect_table = {
				effect = self.TRAIL_EFFECT,
				position = Vector3(),
				normal = Vector3()
			}
	   end
	end
end)

SkyHook:Post(NewRaycastWeaponBase, "fire", function(self, from_pos, direction)
	local allowed_weapons = {
		"wunderwaffe_primary",
		"wunderwaffe_secondary",
		"wunderwaffe_dg3_primary",
		"wunderwaffe_dg3_secondary"
	}

	for k, v in pairs(allowed_weapons) do
		if self._name_id == v then
			self._obj_fire:m_position(self._trail_effect_table.position)
			mvector3.set(self._trail_effect_table.normal, direction)
			World:effect_manager():spawn(self._trail_effect_table)
		end
	end
end)

function NewRaycastWeaponBase:damage_multiplier()
	local multiplier
	local user_unit = self._setup and self._setup.user_unit
	local current_state = alive(user_unit) and user_unit:movement() and user_unit:movement()._current_state

	if managers.player:has_special_equipment("perk_doubletap") then
		multiplier = managers.blackmarket:damage_multiplier(self._name_id, self:weapon_tweak_data().categories, self._silencer, nil, current_state, self._blueprint) * 1.25
	else
		multiplier = managers.blackmarket:damage_multiplier(self._name_id, self:weapon_tweak_data().categories, self._silencer, nil, current_state, self._blueprint)
	end

	return multiplier
end

function NewRaycastWeaponBase:soft_replenish()
	local ammo_max_multiplier = managers.player:upgrade_value("player", "extra_ammo_multiplier", 1)

	for _, category in ipairs(self:weapon_tweak_data().categories) do
		ammo_max_multiplier = ammo_max_multiplier * managers.player:upgrade_value(category, "extra_ammo_multiplier", 1)
	end

	ammo_max_multiplier = ammo_max_multiplier + ammo_max_multiplier * (self._total_ammo_mod or 0)

	if managers.player:has_category_upgrade("player", "add_armor_stat_skill_ammo_mul") then
		ammo_max_multiplier = ammo_max_multiplier * managers.player:body_armor_value("skill_ammo_mul", nil, 1)
	end

	local ammo_max_per_clip = self:calculate_ammo_max_per_clip()
	local ammo_max = math.round((tweak_data.weapon[self._name_id].AMMO_MAX + managers.player:upgrade_value(self._name_id, "clip_amount_increase") * ammo_max_per_clip) * ammo_max_multiplier)
	ammo_max_per_clip = math.min(ammo_max_per_clip, ammo_max)

	self:set_ammo_max_per_clip(ammo_max_per_clip)
	self:set_ammo_max(ammo_max)
	if ammo_max == ammo_max_per_clip then 
		self:set_ammo_total(ammo_max)
	else
		self:set_ammo_total(ammo_max - (ammo_max_per_clip - self:get_ammo_remaining_in_clip()))
	end

	if self._assembly_complete then
		for _, gadget in ipairs(self:get_all_override_weapon_gadgets()) do
			if gadget and gadget.replenish then
				gadget:replenish()
			end
		end
	end

	self:update_damage()
end

function NewRaycastWeaponBase:recoil_multiplier()
	local is_moving = false
	local user_unit = self._setup and self._setup.user_unit

	if user_unit then
		is_moving = alive(user_unit) and user_unit:movement() and user_unit:movement()._current_state and user_unit:movement()._current_state._moving
	end

	local mul = 1

	if managers.player:has_special_equipment("perk_deadshot") then
		mul = 0.45
	end

	return managers.blackmarket:recoil_multiplier(self._name_id, self:weapon_tweak_data().categories, self._silencer, self._blueprint, is_moving) * mul
end