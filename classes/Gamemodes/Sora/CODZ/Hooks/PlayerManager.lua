SkyHook:Post(PlayerManager, "init", function(self)
	self._updated_codz_panel = false
	self.totalCopAlive = 0
end)

SkyHook:Post(PlayerManager, "update", function(self, t, dt)
	--updates the panel, i guess
	if not self._updated_codz_panel then
        SkyLib.CODZ:_update_hud_element()
        self._updated_codz_panel = true
    end

	if not self._show_point_list then
		DelayedCalls:Add( "ZmShowPointsDelay", 2, function()
			SkyLib.CODZ:_update_hud_element()
		end)

		self._show_point_list = true
	end

    local player = self:player_unit()
	--Replenish health and downs when juggernog is bought
    if self:has_special_equipment("perk_juggernog") then
		if not self._has_perk_juggernog then
			if player then
				player:character_damage():replenish()
				local new_health = tonumber(player:character_damage():_max_health()) * 2
				player:character_damage():change_health(new_health)
				self._has_perk_juggernog = true
			end
        end
    end
	--Replenish Armor when armor is bought
	if self:has_special_equipment("perk_armor") then
		if not self._has_perk_armor then
			if player then
				player:character_damage():replenish()
				local new_armor = tonumber(player:character_damage():_max_armor()) * 2
				player:character_damage():change_armor(new_armor)
				self._has_perk_armor = true
			end
        end
    end

	local GCS = PlayerManager.get_current_state
	--play sound when raygun is unlocked?
	if not self._raygun_unlocked then
		if GCS and type(GCS) == "function" then
			local current_state = self:get_current_state()
			if current_state then
				local current_weapon = current_state:get_equipped_weapon()
				if current_weapon then
					if current_weapon.name_id == "raygun_primary" or current_weapon.name_id == "raygun_secondary" then
						local lip = SoundDevice:create_source("lip")
						lip:post_event("zm_announcer_raygun")
						LuaNetworking:SendToPeers( "ZMRaygunUnlocked", "1" )
						self._raygun_unlocked = true
					end
				end
			end
		end
    end
	--Set the name of weapons? i think
	if GCS and type(GCS) == "function" then
		local current_state = self:get_current_state()
		if current_state then
			local current_weapon = current_state:get_equipped_weapon()

			if current_weapon then
				local weapon = current_weapon.name_id
				local weapon_name_id = managers.localization:text(tweak_data.weapon[weapon].name_id)
				
				if weapon == "nothing2_primary" then
					weapon_name_id = ""
				end

				managers.hud._hud_codz.weapon_name_bottom_right:set_text(tostring(weapon_name_id))

				current_weapon:_update_rof_on_perk()
			end
		end
	end

	self:_count_nb_perks()
end)
--Counts the amount of perks the player has
function PlayerManager:_count_nb_perks()
	local count_perks = 0
	for i, v in ipairs(SkyLib.CODZ._perks) do
		if self:has_special_equipment(v) then count_perks = count_perks + 1 end
	end

	return count_perks
end

function PlayerManager:_update_cops_alive(change)
    self.totalCopAlive = self.totalCopAlive + change
end

--force shovel melee
--TODO: implement zdann
SkyHook:Post(PlayerManager, "_internal_load", function(self)
	local player = self:player_unit()

	if not player then
		return
	end

	player:inventory():set_melee_weapon("zdann")
end)

function PlayerManager:add_grenade_amount(amount, sync)
	local peer_id = managers.network:session():local_peer():id()
	local grenade = self._global.synced_grenades[peer_id].grenade
	local tweak = tweak_data.blackmarket.projectiles[grenade]
	local max_amount = self:get_max_grenades_by_peer_id(peer_id)
	local icon = tweak.icon
	local previous_amount = self._global.synced_grenades[peer_id].amount

	if amount > 0 and tweak.base_cooldown then
		managers.hud:animate_grenade_flash(HUDManager.PLAYER_PANEL)
	end

	amount = math.min(Application:digest_value(previous_amount, false) + amount, max_amount)

	if amount < max_amount and tweak.base_cooldown then
		self:replenish_grenades(tweak.base_cooldown)
	elseif amount > max_amount then
		amount = max_amount
	end

	managers.hud:set_teammate_grenades_amount(HUDManager.PLAYER_PANEL, {
		icon = icon,
		amount = amount
	})
	self:update_grenades_amount_to_peers(grenade, amount, sync and peer_id)
end

--set armor regen to 125% if armor perk is bought
function PlayerManager:body_armor_regen_multiplier(moving, health_ratio)
	local multiplier = 1
	multiplier = multiplier * self:upgrade_value("player", "armor_regen_timer_multiplier_tier", 1)
	multiplier = multiplier * self:upgrade_value("player", "armor_regen_timer_multiplier", 1)
	multiplier = multiplier * self:upgrade_value("player", "armor_regen_timer_multiplier_passive", 1)
	multiplier = multiplier * self:team_upgrade_value("armor", "regen_time_multiplier", 1)
	multiplier = multiplier * self:team_upgrade_value("armor", "passive_regen_time_multiplier", 1)
	multiplier = multiplier * self:upgrade_value("player", "perk_armor_regen_timer_multiplier", 1)

	if not moving then
		multiplier = multiplier * managers.player:upgrade_value("player", "armor_regen_timer_stand_still_multiplier", 1)
	end

	if health_ratio then
		local damage_health_ratio = self:get_damage_health_ratio(health_ratio, "armor_regen")
		multiplier = multiplier * (1 - managers.player:upgrade_value("player", "armor_regen_damage_health_ratio_multiplier", 0) * damage_health_ratio)
	end

	local armor_mul = managers.player:has_special_equipment("perk_armor") and 1.25 or 1

	return multiplier * armor_mul
end

Hooks:Add("NetworkReceivedData", "NetworkReceivedData_Wunderwaffe_unlock", function(sender, id, data)
    if id == "ZMWunderwaffeUnlocked" then
        local lip = SoundDevice:create_source("lip")
        lip:post_event("zm_announcer_wunder")
        managers.player._wunderwaffe_unlocked = true
    end

    if id == "ZMRaygunUnlocked" then
        local lip = SoundDevice:create_source("lip")
        lip:post_event("zm_announcer_raygun")
        managers.player._roach_unlocked = true
    end
end)