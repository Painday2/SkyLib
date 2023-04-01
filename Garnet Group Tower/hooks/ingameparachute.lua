function IngameParachuting:at_exit()
	local player = managers.player:player_unit()

	if player then
		player:base():set_enabled(false)
	end

	managers.hud:hide(PlayerBase.PLAYER_INFO_HUD)
	managers.hud:hide(PlayerBase.PLAYER_INFO_HUD_FULLSCREEN)
end