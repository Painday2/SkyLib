function PlayerTased:clbk_exit_to_fatal()
	self._fatal_delayed_clbk = nil

	if SkyLib.Network:_is_solo() then
		managers.player:set_player_state("bleed_out")

		if alive(managers.player:player_unit()) then
			managers.player:player_unit():character_damage():on_downed()
			managers.player:player_unit():character_damage():set_health(0)
			managers.player:player_unit():character_damage():_chk_cheat_death()

			if managers.player:has_special_equipment("perk_quickrevive") then
				DelayedCalls:Add("ovk_sucks", 6.5, function()
					if alive(managers.player:player_unit()) then
						managers.player:player_unit():character_damage():revive(true)
					end
				end)
			end
		end
	else
		managers.player:set_player_state("incapacitated")
	end
end