function BaseInteractionExt:selected(player, locator, hand_id)
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
	local cost = self._tweak_data.points_cost or 0

	--Is a Zombie Mode Interaction?
	if self._tweak_data.zm_interaction then
		if self._unit:unit_data() and self._unit:unit_data().cost then
			cost = self._unit:unit_data().cost
		end
		--cost = self._unit:unit_data().cost
		text = "Hold " .. managers.localization:btn_macro("interact") .. " to buy"

		--[[if self._tweak_data.wallbuy then
			if self._tweak_data.grenade_spot then
				text = "Hold " .. managers.localization:btn_macro("interact") .. " to refill your throwables"
			end

			local weapon_id = self._unit:base()._weapon_id or "amcar"
			local item = self._tweak_data.weapon or managers.localization:text(tostring(tweak_data.weapon[weapon_id].name_id))
			local own_weapon = false

			if not self._tweak_data.grenade_spot then
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
				if not self._tweak_data.grenade_spot then text = text .. " the " .. item end
				text = text .. " [Cost : " .. cost .. "]"
			else
				local points_needed = cost - current_money
				
				if not self._tweak_data.grenade_spot then 
					text = "You need " .. points_needed .. " more points to buy the " .. item 
				else
					text = "You need " .. points_needed .. " more points to refill your throwables" 
				end

				if own_weapon then
					if not self._tweak_data.grenade_spot then text = "You need " .. points_needed .. " more points to refill the ammo of the " .. item end
				end
			end
		end]]
		--Left in for compatibility, not planned to be added to any bases
		if self._tweak_data.dyn_price_by_wave then
			local base_price = self._tweak_data.dyn_price_base or 1000
			local increase_by_wave = self._tweak_data.dyn_price_increase or 1000
			local current_wave = SkyLib.CODZ:_get_current_wave()
			local item_name = self._tweak_data.dyn_price_item_name
			text = self._tweak_data.text_id

			local transformed_price = base_price + (increase_by_wave * current_wave)

			if current_money >= transformed_price then
				text = "Hold " .. managers.localization:btn_macro("interact") .. " to call the " .. item_name .. " [Cost : " .. transformed_price .. "]"
			else
				local points_needed = transformed_price - current_money
				text = "You need " .. points_needed .. " more points to buy the " .. item_name 
			end
		end

		--[[Is a ZM Perk Interaction?
		if self._tweak_data.perk then
			local item = self._tweak_data.perk

			if self._tweak_data.special_equipment and not managers.player:has_special_equipment(self._tweak_data.special_equipment) then
				local has_special_equipment = false
		
				if self._tweak_data.possible_special_equipment then
					for i, special_equipment in ipairs(self._tweak_data.possible_special_equipment) do
						if managers.player:has_special_equipment(special_equipment) then
							has_special_equipment = true
		
							break
						end
					end
				end
		
				if not has_special_equipment then
					text = managers.localization:text(self._tweak_data.equipment_text_id, string_macros)
					icon = self.no_equipment_icon or self._tweak_data.no_equipment_icon or icon
				end

				managers.hud:show_interact({
					text = text,
					icon = icon
				})

				return true
			end

			if current_money >= cost then
				text = text .. " " .. item
				text = text .. " [Cost : " .. cost .. "]"
			else
				local points_needed = cost - current_money
				text = "You need " .. points_needed .. " more points to buy " .. item
			end
		end]]

		--Is a ZM Obstacle Interaction?
		--Has a base, left in for interaction element.
		if self._tweak_data.path then
			text = "Hold " .. managers.localization:btn_macro("interact") .. " to open "
			local path_type = "the path"
			
			if self._tweak_data.custom_path then
				path_type = self._tweak_data.custom_path
			end

			if current_money >= cost then
				text = text .. path_type
				text = text .. " [Cost : " .. cost .. "]"
			else
				local points_needed = cost - current_money
				text = "You need " .. points_needed .. " more points to open " .. path_type
			end
		end

		--Is a ZM Elevator Interaction?
		--Currently unused, if needed will port to a base
		if self._tweak_data.zm_elevator then
			text = "Hold " .. managers.localization:btn_macro("interact") .. " to call "
			local path_type = "the elevator"
			
			if self._tweak_data.custom_path then
				path_type = self._tweak_data.custom_path
			end

			if current_money >= cost then
				text = text .. path_type
				text = text .. " [Cost : " .. cost .. "]"
			else
				local points_needed = cost - current_money
				text = "You need " .. points_needed .. " more points to call " .. path_type
			end
		end

		--Is a ZM Trap Interaction?
		--Currently unused, if needed will port to a base
		if self._tweak_data.zm_trap then
			text = "Hold " .. managers.localization:btn_macro("interact") .. " to activate "
			local path_type = "the trap"
			
			if self._tweak_data.custom_zm_trap then
				path_type = self._tweak_data.custom_zm_trap
			end

			if current_money >= cost then
				text = text .. path_type
				text = text .. " [Cost : " .. cost .. "]"
			else
				local points_needed = cost - current_money
				text = "You need " .. points_needed .. " more points to activate " .. path_type
			end
		end

		--Is a ZM Hack Interaction?
		--Could use a base, probably more useful as a tweakdata, will port if needed
		if self._tweak_data.hack then
			text = "Hold " .. managers.localization:btn_macro("interact") .. " to start "
			local hack_type = "the hack"
			
			if self._tweak_data.custom_hack then
				hack_type = self._tweak_data.custom_hack
			end

			if current_money >= cost then
				text = text .. hack_type
				text = text .. " [Cost : " .. cost .. "]"
			else
				local points_needed = cost - current_money
				text = "You need " .. points_needed .. " more points to start the hack "
			end
		end
		
		--Is a ZM Key Interaction?
		--Currently unused, if needed will port to a base
		if self._tweak_data.key then
			text = "Hold " .. managers.localization:btn_macro("interact") .. " to start "
			local key_type = "the car"
			
			if self._tweak_data.key then
				hkey_type = self._tweak_data.custom_key
			end

			if current_money >= cost then
				text = text .. key_type
				text = text .. " [Cost : " .. cost .. "]"
			else
				local points_needed = cost - current_money
				text = "You need " .. points_needed .. " more points to start the car "
			end
		end
		
		--Is a ZM Pack-A-Punch Interaction?
		--Has a base, Left in for interaction element.
		if self._tweak_data.pack_a_punch then
			text = "Hold " .. managers.localization:btn_macro("interact") .. " to upgrade your weapon"

			if current_money >= cost then
				text = text .. " [Cost : " .. cost .. "]"
			else
				local points_needed = cost - current_money
				text = "You need " .. points_needed .. " more points to upgrade your weapon"
			end
		end

		--[[Is a ZM Mystery Box Interaction?
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
		end]]
		
		--[[Is a ZM Box Weapon Grab Interaction?
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
		end]]

		--Is a ZM Trade Points Interaction?
		if self._tweak_data.point_giveaway_spot then
			local player_name_aimed_at = SkyLib.CODZ._players[self._tweak_data.spot_nb].player_name
			cost = 1000

			if player_name_aimed_at ~= "" then
				text = "Press " .. managers.localization:btn_macro("interact") .. " to give 1000 points to " .. tostring(player_name_aimed_at)

				if current_money < cost then
					local points_needed = cost - current_money
					text = "You need " .. points_needed .. " more points to give the minimum amount"
				end
			end

			local my_p_id = SkyLib.Network:_my_peer_id()

			if self._tweak_data.spot_nb == my_p_id or not SkyLib.CODZ:_player_connected(self._tweak_data.spot_nb) then
				cost = 0
				text = ""
			end
		end
	else
		local text_id = self._tweak_data.text_id or alive(self._unit) and self._unit:base().interaction_text_id and self._unit:base():interaction_text_id()
		text = managers.localization:text(text_id, string_macros)
		local icon = self._tweak_data.icon

		if self._tweak_data.special_equipment and not managers.player:has_special_equipment(self._tweak_data.special_equipment) then
			local has_special_equipment = false
	
			if self._tweak_data.possible_special_equipment then
				for i, special_equipment in ipairs(self._tweak_data.possible_special_equipment) do
					if managers.player:has_special_equipment(special_equipment) then
						has_special_equipment = true
	
						break
					end
				end
			end
	
			if not has_special_equipment then
				text = managers.localization:text(self._tweak_data.equipment_text_id, string_macros)
				icon = self.no_equipment_icon or self._tweak_data.no_equipment_icon or icon
			end
		end
	
		if self._tweak_data.contour_preset or self._tweak_data.contour_preset_selected then
			if not self._selected_contour_id and self._tweak_data.contour_preset_selected and self._tweak_data.contour_preset ~= self._tweak_data.contour_preset_selected then
				self._selected_contour_id = self._unit:contour():add(self._tweak_data.contour_preset_selected)
			end
		else
			self:set_contour("selected_color")
		end
	end

	managers.hud:show_interact({
		text = text,
		icon = icon
	})

	return true
end

function BaseInteractionExt:quick_swap()
	if not SkyLib.CODZ._level.active_events.firesale then
		self:set_active(false)

		SkyLib:wait(0.1, function()
			self:set_active(true)
		end)

		SkyLib.CODZ._level.active_events.firesale_box_swap = true
	end
end
--i could copy this to the seperate bases, but seems more efficent to not, not lazy promise.
function BaseInteractionExt:can_interact(player)
	if self._host_only and not Network:is_server() then
		return false
	end

	if self._disabled then
		return false
    end

    local count_perks = managers.player:_count_nb_perks()
	local max_perks = 4
	local current_money = SkyLib.CODZ:_get_own_money()

	--Left in for compatibility, not planned to be added to any bases
	if self._tweak_data.dyn_price_by_wave then
		local base_price = self._tweak_data.dyn_price_base or 1000
		local increase_by_wave = self._tweak_data.dyn_price_increase or 1000
		local current_wave = SkyLib.CODZ:_get_current_wave()
		local real_cost = base_price + (increase_by_wave * current_wave)

		if current_money < real_cost then
			return false
		end
	end

	if self._tweak_data.is_teleporter and not SkyLib.CODZ:_is_teleporter_available() then
		return false
	end

    if self._tweak_data.is_perk_interaction and count_perks >= max_perks then
        return false
	end

	if self._tweak_data.zm_interaction then
		local cost = self._tweak_data.points_cost or 0

		if self.tweak_data == "zm_mystery_box" and SkyLib.CODZ:_is_event_active("firesale") then
			cost = 10
		end
		--!no longer needed, leaving for now
		--[[
		if self._tweak_data.pack_a_punch then
			local current_state = managers.player:get_current_state()
			if current_state then
				local current_weapon = current_state:get_equipped_weapon()
				local weapon_id = current_weapon.name_id
				
				if string.find(weapon_id, "_upg_") or string.find(weapon_id, "_dg3_") then
					return false
				end
			end
		end]]

		if self._tweak_data.point_giveaway_spot then
			local amount = 1000

			if not SkyLib.CODZ:_player_connected(self._tweak_data.spot_nb) then
				return false
			end

			if self._tweak_data.spot_nb == SkyLib.Network:_my_peer_id() then
				return false
			end

			if current_money < amount then
				return false
			end
		end

		if self._tweak_data.wallbuy and not self._tweak_data.grenade_spot then
			local current_state = managers.player:get_current_state()
			if current_state then
				local current_weapon = current_state:get_equipped_weapon()
				local weapon_id = self._unit:base()._weapon_id or "amcar"

				if current_weapon.name_id == weapon_id then
					cost = math.round(cost / 2, 50)
				end
			end
		end

		if current_money < cost then
			return false
		end
	end

	if not self:_has_required_upgrade(alive(player) and player:movement() and player:movement().current_state_name and player:movement():current_state_name()) then
		return false
	end

	if not self:_has_required_deployable() then
		return false
	end

	if not self:_is_in_required_state(alive(player) and player:movement() and player:movement().current_state_name and player:movement():current_state_name()) then
		return false
	end

	if self._tweak_data.special_equipment_block and managers.player:has_special_equipment(self._tweak_data.special_equipment_block) then
		return false
	end

	if not self._tweak_data.special_equipment or self._tweak_data.dont_need_equipment then
		return true
	end

	return managers.player:has_special_equipment(self._tweak_data.special_equipment)
end

function BaseInteractionExt:_get_timer()
	local modified_timer = self:_get_modified_timer()

	if modified_timer then
		return modified_timer
	end

	local multiplier = 1

	if self.tweak_data ~= "corpse_alarm_pager" then
		multiplier = multiplier * managers.player:crew_ability_upgrade_value("crew_interact", 1)
	end

	if self._tweak_data.upgrade_timer_multiplier then
		multiplier = multiplier * managers.player:upgrade_value(self._tweak_data.upgrade_timer_multiplier.category, self._tweak_data.upgrade_timer_multiplier.upgrade, 1)
	end

	if self._tweak_data.upgrade_timer_multipliers then
		for _, upgrade_timer_multiplier in pairs(self._tweak_data.upgrade_timer_multipliers) do
			multiplier = multiplier * managers.player:upgrade_value(upgrade_timer_multiplier.category, upgrade_timer_multiplier.upgrade, 1)
		end
	end

	if managers.player:has_category_upgrade("player", "level_interaction_timer_multiplier") then
		local data = managers.player:upgrade_value("player", "level_interaction_timer_multiplier") or {}
		local player_level = managers.experience:current_level() or 0
		multiplier = multiplier * (1 - (data[1] or 0) * math.ceil(player_level / (data[2] or 1)))
	end

	if self.tweak_data == "revive" then
		if managers.player:has_special_equipment("perk_quickrevive") then
			multiplier = multiplier / 2
		end
	end

	return self:_timer_value() * multiplier * managers.player:toolset_value()
end

function BaseInteractionExt:interact(player)
	self._tweak_data_at_interact_start = nil

	if self._tweak_data.zm_interaction then
		--Left in for compatibility, not planned to be added to any bases
		if self._tweak_data.dyn_price_by_wave then
			local base_price = self._tweak_data.dyn_price_base or 1000
			local increase_by_wave = self._tweak_data.dyn_price_increase or 1000
			local current_wave = SkyLib.CODZ:_get_current_wave()
			local transformed_price = 0 - (base_price + (increase_by_wave * current_wave))

			local peer_id = 1

			if managers and managers.network then
				local peer = managers.network:session():peer_by_unit(player)
				peer_id = peer:id()
			end

			if peer_id == SkyLib.Network:_my_peer_id() then
				SkyLib.CODZ:_money_change(transformed_price, peer_id)
			end

			return
		end
		local cost = self._tweak_data.points_cost or 0
		--compatibility with interaction elements
		if self._unit:unit_data() and self._unit:unit_data().cost then
			cost = self._unit:unit_data().cost
		end

		local amount_to_deduct = 0 - cost or 0
		--more effort to make this it's own thing
		if self.tweak_data == "zm_mystery_box" and SkyLib.CODZ:_is_event_active("firesale") then
			amount_to_deduct = 0 - 10
		end

		if self._tweak_data.point_giveaway_spot then
			local amount = 1000

			LuaNetworking:SendToPeers( "ShareCashTo", tostring(self._tweak_data.spot_nb) )
			SkyLib.CODZ:_money_change(0 - amount, SkyLib.Network:_my_peer_id())
			self:_post_event(player, "sound_done")
			
			return
		end
		
		local peer_id = 1

		if managers and managers.network then
			local peer = managers.network:session():peer_by_unit(player)
			peer_id = peer:id()
		end

		if peer_id == SkyLib.Network:_my_peer_id() then
			SkyLib.CODZ:_money_change(amount_to_deduct, peer_id)
		end
	end

	self:_post_event(player, "sound_done")
end

function BaseInteractionExt:set_active(active, sync)
	if active and self:disabled() then
		return
	end

	if self._tweak_data.stay_active then
		active = true
	end

	if self._host_only and not Network:is_server() then
		active = false
	end

	if not active and self._active then
		managers.interaction:remove_unit(self._unit)

		if self._tweak_data.contour_preset or self._tweak_data.contour_preset_selected then
			if self._contour_id and self._unit:contour() then
				self._unit:contour():remove_by_id(self._contour_id)
			end

			self._contour_id = nil

			if self._selected_contour_id and self._unit:contour() then
				self._unit:contour():remove_by_id(self._selected_contour_id)
			end

			self._selected_contour_id = nil
		elseif not self._tweak_data.no_contour then
			managers.occlusion:add_occlusion(self._unit)
		end

		self._is_selected = nil
	elseif active and not self._active then
		managers.interaction:add_unit(self._unit)

		if self._tweak_data.contour_preset then
			if not self._contour_id then
				self._contour_id = self._unit:contour():add(self._tweak_data.contour_preset)
			end
		elseif not self._tweak_data.no_contour then
			managers.occlusion:remove_occlusion(self._unit)
		end
	end

	self._active = active

	if not self._tweak_data.contour_preset then
		local opacity_value = self:_set_active_contour_opacity()

		self:set_contour("standard_color", opacity_value)
	end

	if not self._host_only and sync and managers.network:session() then
		local u_id = self._unit:id()

		if u_id == -1 then
			local u_data = managers.enemy:get_corpse_unit_data_from_key(self._unit:key())

			if u_data then
				u_id = u_data.u_id
			else
				debug_pause_unit(self._unit, "[BaseInteractionExt:set_active] could not sync interaction state.", self._unit)

				return
			end
		end

		managers.network:session():send_to_peers_synched("interaction_set_active", self._unit, u_id, active, self.tweak_data, self._unit:contour() and self._unit:contour():is_flashing() or false)
	end
end

function UseInteractionExt:sync_interacted(peer, player, status, skip_alive_check)
	if not self._active then
		return
	end

	local player = peer:unit()

	if not skip_alive_check and not alive(player) then
		return
	end

	if player ~= managers.player:player_unit() then
		if self._achievement_stat then
			managers.achievment:award_progress(self._achievement_stat)
		elseif self._achievement_id then
			managers.achievment:award(self._achievement_id)
		elseif self._challenge_stat then
			managers.challenge:award_progress(self._challenge_stat)
		elseif self._trophy_stat then
			managers.custom_safehouse:award(self._trophy_stat)
		elseif self._challenge_award then
			managers.challenge:award(self._challenge_award)
		elseif self._sidejob_award then
			managers.generic_side_jobs:award(self._sidejob_award)
		elseif self.award_blackmarket then
			local args = string.split(self.award_blackmarket, " ")

			managers.blackmarket:add_to_inventory(unpack(args))
		end
	end

	self:remove_interact()
	self:set_active(false)

	if self._unit:damage() then
		self._unit:damage():run_sequence_simple("interact", {unit = player})
	end

	return player
end

Hooks:PostHook(ReviveInteractionExt, "interact", "zm_post_interact_revive", function(self, reviving_unit)
	local helped_id = managers.criminals:character_peer_id_by_unit(self._unit)
	local helper_id = managers.criminals:character_peer_id_by_unit(reviving_unit)

	if helped_id then
		local money_to_add = SkyLib.CODZ:points_round(SkyLib.CODZ._players[helped_id].codz_points * 0.15)
		SkyLib.CODZ:_money_change(math.floor(money_to_add), helper_id)
	end
end)