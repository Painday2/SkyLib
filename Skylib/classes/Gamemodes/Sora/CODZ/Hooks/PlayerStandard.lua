--TODO: create a way to use this, maybe update the checksecret element for this.
--[[SkyHook:Post(PlayerStandard, "update", function(self, t, dt)
	if not self._god then
		SkyLib:wait(3, function()
			if Network:is_server() then
				if managers.wdu:check_ee_state() then
					managers.player:add_special({
						name = "perk_god",
						amount = 1
					})
				end
			else
				if managers.wdu:check_ee_state() then
					LuaNetworking:SendToPeers("SecretsCompleted", "1")
				end
			end
		end)

		self._god = true
	end
end)]]--

--Set the weapon name in bottom right
SkyHook:Post(PlayerStandard, "_start_action_equip_weapon", function(self, t)
	local weapon = self._ext_inventory:equipped_unit():base()._name_id
	local weapon_name_id = managers.localization:text(tweak_data.weapon[weapon].name_id)

	if weapon == "nothing2_primary" then
		weapon_name_id = ""
	end

	managers.hud._hud_codz.weapon_name_bottom_right:set_text(tostring(weapon_name_id))
end)

-- Following fix below is made by Pawcio / >:3

--[[function PlayerStandard:_start_action_reload_enter(t)
    if self._equipped_unit:base():can_reload() then
        local weapon = self._equipped_unit:base()
        local tweak_data = weapon:weapon_tweak_data()
        managers.player:send_message_now(Message.OnPlayerReload, nil, self._equipped_unit)
        self:_interupt_action_steelsight(t)
        if not self.RUN_AND_RELOAD then
            self:_interupt_action_running(t)
        end
        if self._equipped_unit:base():reload_enter_expire_t() then
            local speed_multiplier = self._equipped_unit:base():reload_speed_multiplier()
            self._ext_camera:play_redirect(Idstring("reload_enter_" .. weapon:weapon_tweak_data().animations.reload_name_id), speed_multiplier)
            self._state_data.reload_enter_expire_t = t + self._equipped_unit:base():reload_enter_expire_t() / speed_multiplier
            self._equipped_unit:base():tweak_data_anim_play("reload_enter", speed_multiplier)
            return
        end
        self:_start_action_reload(t)
    end
end]]

function PlayerStandard:_start_action_intimidate(t, secondary)
	if not self._intimidate_t or tweak_data.player.movement_state.interaction_delay < t - self._intimidate_t then
		local skip_alert = managers.groupai:state():whisper_mode()
		local voice_type, plural, prime_target = self:_get_unit_intimidation_action(not secondary, not secondary, true, false, true, nil, nil, nil, secondary)

		if prime_target and prime_target.unit and prime_target.unit.base and (prime_target.unit:base().unintimidateable or prime_target.unit:anim_data() and prime_target.unit:anim_data().unintimidateable) then
			return
		end

		local interact_type, sound_name = nil
		local sound_suffix = plural and "plu" or "sin"

		if voice_type == "stop" then
			interact_type = "cmd_stop"
			sound_name = "f02x_" .. sound_suffix
		elseif voice_type == "mark_cop" or voice_type == "mark_cop_quiet" then
			interact_type = "cmd_point"

			if voice_type == "mark_cop_quiet" then
				sound_name = tweak_data.character[prime_target.unit:base()._tweak_table].silent_priority_shout .. "_any"
			else
				sound_name = tweak_data.character[prime_target.unit:base()._tweak_table].priority_shout .. "x_any"
			end

			if managers.player:has_category_upgrade("player", "special_enemy_highlight") then
				prime_target.unit:contour():add(managers.player:get_contour_for_marked_enemy(), true, managers.player:upgrade_value("player", "mark_enemy_time_multiplier", 1))
				managers.network:session():send_to_peers_synched("spot_enemy", prime_target.unit)
			end
		elseif voice_type == "down" then
			interact_type = "cmd_down"
			sound_name = "f02x_" .. sound_suffix
			self._shout_down_t = t
		elseif voice_type == "down_stay" then
			interact_type = "cmd_down"

			if self._shout_down_t and t < self._shout_down_t + 2 then
				sound_name = "f03b_any"
			else
				sound_name = "f03a_" .. sound_suffix
			end
		elseif voice_type == "come" then
			interact_type = "cmd_come"
			local static_data = managers.criminals:character_static_data_by_unit(prime_target.unit)

			if static_data then
				local character_code = static_data.ssuffix
				sound_name = "f21" .. character_code .. "_sin"
			else
				sound_name = "f38_any"
			end
		elseif voice_type == "revive" then
			interact_type = "cmd_get_up"
			local static_data = managers.criminals:character_static_data_by_unit(prime_target.unit)

			if not static_data then
				return
			end

			local character_code = static_data.ssuffix
			sound_name = "f36x_any"

			if math.random() < self._ext_movement:rally_skill_data().revive_chance then
				prime_target.unit:interaction():interact(self._unit)
			end

			self._ext_movement:rally_skill_data().morale_boost_delay_t = managers.player:player_timer():time() + (self._ext_movement:rally_skill_data().morale_boost_cooldown_t or 3.5)
		elseif voice_type == "boost" then
			interact_type = "cmd_gogo"
			local static_data = managers.criminals:character_static_data_by_unit(prime_target.unit)

			if not static_data then
				return
			end

			local character_code = static_data.ssuffix
			sound_name = "g18"
			self._ext_movement:rally_skill_data().morale_boost_delay_t = managers.player:player_timer():time() + (self._ext_movement:rally_skill_data().morale_boost_cooldown_t or 3.5)
		elseif voice_type == "escort" then
			interact_type = "cmd_point"
			sound_name = "f41_" .. sound_suffix
		elseif voice_type == "escort_keep" or voice_type == "escort_go" then
			interact_type = "cmd_point"
			sound_name = "f40_any"
		elseif voice_type == "bridge_codeword" then
			sound_name = "bri_14"
			interact_type = "cmd_point"
		elseif voice_type == "bridge_chair" then
			sound_name = "bri_29"
			interact_type = "cmd_point"
		elseif voice_type == "undercover_interrogate" then
			sound_name = "f46x_any"
			interact_type = "cmd_point"
		elseif voice_type == "undercover_escort" then
			sound_name = "f41_any"
			interact_type = "cmd_point"
		elseif voice_type == "mark_camera" then
			sound_name = "f39_any"
			interact_type = "cmd_point"

			prime_target.unit:contour():add("mark_unit", true, managers.player:upgrade_value("player", "mark_enemy_time_multiplier", 1))
		elseif voice_type == "mark_turret" then
			sound_name = "f44x_any"
			interact_type = "cmd_point"
			local type = prime_target.unit:base().get_type and prime_target.unit:base():get_type()

			prime_target.unit:contour():add(managers.player:get_contour_for_marked_enemy(type), true, managers.player:upgrade_value("player", "mark_enemy_time_multiplier", 1))
		elseif voice_type == "ai_stay" then
			sound_name = "f48x_any"
			interact_type = "cmd_stop"
		end

		self:_do_action_intimidate(t, interact_type, sound_name, skip_alert)
	end
end

function PlayerStandard:_get_max_walk_speed(t, force_run)
	local speed_tweak = self._tweak_data.movement.speed
	local has_staminup = managers.player:has_special_equipment("perk_staminup")
	local movement_speed = has_staminup and speed_tweak.STANDARD_MAX * 1.25 or speed_tweak.STANDARD_MAX
	local speed_state = "walk"

	if self._state_data.in_steelsight and not managers.player:has_category_upgrade("player", "steelsight_normal_movement_speed") and not _G.IS_VR then
		movement_speed = has_staminup and speed_tweak.STEELSIGHT_MAX * 1.25 or speed_tweak.STEELSIGHT_MAX
		speed_state = "steelsight"
	elseif self:on_ladder() then
		movement_speed = has_staminup and speed_tweak.CLIMBING_MAX * 1.25 or speed_tweak.CLIMBING_MAX
		speed_state = "climb"
	elseif self._state_data.ducking then
		movement_speed = has_staminup and speed_tweak.CROUCHING_MAX * 1.25 or speed_tweak.CROUCHING_MAX
		speed_state = "crouch"
	elseif self._state_data.in_air then
		movement_speed = has_staminup and speed_tweak.INAIR_MAX * 1.25 or speed_tweak.INAIR_MAX
		speed_state = nil
	elseif self._running or force_run then
		movement_speed = has_staminup and speed_tweak.RUNNING_MAX * 1.25 or speed_tweak.RUNNING_MAX
		speed_state = "run"
	end

	movement_speed = managers.modifiers:modify_value("PlayerStandard:GetMaxWalkSpeed", movement_speed, self._state_data, speed_tweak)
	local morale_boost_bonus = self._ext_movement:morale_boost()
	local multiplier = managers.player:movement_speed_multiplier(speed_state, speed_state and morale_boost_bonus and morale_boost_bonus.move_speed_bonus, nil, self._ext_damage:health_ratio())
	multiplier = multiplier * (self._tweak_data.movement.multiplier[speed_state] or 1)
	local apply_weapon_penalty = true

	if self:_is_meleeing() then
		local melee_entry = managers.blackmarket:equipped_melee_weapon()
		apply_weapon_penalty = not tweak_data.blackmarket.melee_weapons[melee_entry].stats.remove_weapon_movement_penalty
	end

	if alive(self._equipped_unit) and apply_weapon_penalty then
		multiplier = multiplier * self._equipped_unit:base():movement_penalty()
	end

	if managers.player:has_activate_temporary_upgrade("temporary", "increased_movement_speed") then
		multiplier = multiplier * managers.player:temporary_upgrade_value("temporary", "increased_movement_speed", 1)
	end

	local final_speed = movement_speed * multiplier
	self._cached_final_speed = self._cached_final_speed or 0

	if final_speed ~= self._cached_final_speed then
		self._cached_final_speed = final_speed

		self._ext_network:send("action_change_speed", final_speed)
	end

	return final_speed
end