function PlayerDamage:_raw_max_health()
	local base_max_health = self._HEALTH_INIT + managers.player:health_skill_addend()
	local mul = managers.player:health_skill_multiplier()

    local juggernog_mul = managers.player:has_special_equipment("perk_juggernog") and 2 or 1

	return (base_max_health * mul) * juggernog_mul
end
--revives the player if solo and have quick revive
function PlayerDamage:_chk_cheat_death(is_tazed)
    if Application:digest_value(self._revives, false) > 1 and not self._check_berserker_done and managers.player:has_special_equipment("perk_quickrevive") then
        if SkyLib.Network:_is_solo() then
            local player_name = managers.network.account:username()
            local text_concat = "Reviving " .. player_name .. " ..."
            managers.hud:present_mid_text( { text = text_concat, title = "Quick Revive", time = 6 } )
            self._auto_revive_timer = 6.5

            DelayedCalls:Add( "ZmRemoveQuickReviveIn", 6.5, function()
                managers.player:remove_special("perk_quickrevive")
			end)

            return
        end
	end

	if not is_tazed and Application:digest_value(self._revives, false) > 1 and not self._check_berserker_done and managers.player:has_category_upgrade("player", "cheat_death_chance") then
		local r = math.rand(1)

		if r <= managers.player:upgrade_value("player", "cheat_death_chance", 0) then
			self._auto_revive_timer = 1
		end
	end
end

SkyHook:Pre(PlayerDamage, "on_downed", function(self)
	local perk_noloss = managers.player:has_special_equipment("perk_tombstone")
	--go through the list and remove them if tombstone isn't owned
	for i, v in ipairs(SkyLib.CODZ._perks) do
		if not perk_noloss and managers.player:has_special_equipment(v) then
			managers.player:remove_special(v)
		end
	end
	--tombstone prevents perk loss on down, so it will always be removed on down
	if perk_noloss then
        managers.player:remove_special("perk_tombstone")
    end
	--Quick revive has it's own function for solo downs, so if not solo then remove it
    if not SkyLib.Network:_is_solo() and managers.player:has_special_equipment("perk_quickrevive") then
        managers.player:remove_special("perk_quickrevive")
	end

	local points_to_remove = SkyLib.CODZ:points_round(0 - SkyLib.CODZ:_get_own_money() / 4)
	SkyLib.CODZ:_money_change(math.floor(points_to_remove), SkyLib.Network:_my_peer_id())
end)

function PlayerDamage:damage_fall(data)
	local damage_info = {result = {
		variant = "fall",
		type = "hurt"
	}}

	if self._god_mode or self._invulnerable or self._mission_damage_blockers.invulnerable then
		self:_call_listeners(damage_info)

		return
	elseif self:incapacitated() then
		return
	elseif self._unit:movement():current_state().immortal then
		return
	elseif self._mission_damage_blockers.damage_fall_disabled then
		return
	end

	local height_limit = 300
	local death_limit = 631

	if data.height < height_limit then
		return
	end

	local die = death_limit < data.height

	self._unit:sound():play("player_hit")
	managers.environment_controller:hit_feedback_down()
	managers.hud:on_hit_direction(Vector3(0, 0, 0), die and HUDHitDirection.DAMAGE_TYPES.HEALTH or HUDHitDirection.DAMAGE_TYPES.ARMOUR, 0)

	if self._bleed_out and self._unit:movement():current_state_name() ~= "jerry1" then
		return
	end

	local health_damage_multiplier = 0

	if die then
		self._check_berserker_done = false

		self:set_health(0)

		if self._unit:movement():current_state_name() == "jerry1" then
			self._revives = Application:digest_value(1, true)
        end

        if SkyLib.Network:_is_solo() and managers.player:has_special_equipment("perk_quickrevive") then
            self:_chk_cheat_death()
        end
	else
		health_damage_multiplier = managers.player:upgrade_value("player", "fall_damage_multiplier", 1) * managers.player:upgrade_value("player", "fall_health_damage_multiplier", 1)

		self:change_health(-(tweak_data.player.fall_health_damage * health_damage_multiplier))
	end

	if die or health_damage_multiplier > 0 then
		local alert_rad = tweak_data.player.fall_damage_alert_size or 500
		local new_alert = {
			"vo_cbt",
			self._unit:movement():m_head_pos(),
			alert_rad,
			self._unit:movement():SO_access(),
			self._unit
		}

		managers.groupai:state():propagate_alert(new_alert)
	end

	local max_armor = self:_max_armor()

	if die then
		self:set_armor(0)
	else
		self:change_armor(-max_armor * managers.player:upgrade_value("player", "fall_damage_multiplier", 1))
	end

	SoundDevice:set_rtpc("shield_status", 0)
	self:_send_set_armor()

	self._bleed_out_blocked_by_movement_state = nil

	managers.hud:set_player_health({
		current = self:get_real_health(),
		total = self:_max_health(),
		revives = Application:digest_value(self._revives, false)
	})
	self:_send_set_health()
	self:_set_health_effect()
	self:_damage_screen()
	self:_check_bleed_out(nil, true)
	self:_call_listeners(damage_info)

	return true
end