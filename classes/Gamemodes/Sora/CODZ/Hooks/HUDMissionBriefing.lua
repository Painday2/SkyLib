SkyHook:Post(HUDMissionBriefing, "set_player_slot", function(self, nr, params)
    local current_name = params.name
    local peer_id = params.peer_id

    local data = {
        id = peer_id,
        name = current_name
    }

    SkyLib.CODZ:_create_new_player(data)
end)


--THIS CRASHES WHENEVER YOU PLACE A UNIT SEQUENCE AND I DON'T KNOW WHY.
--[[SkyHook:Post(HUDMissionBriefing, "init", function(self, hud, workspace)
    DelayedCalls:Add("zm_remove_current_song", 0.1, function()
        managers.music:post_event("stop_all_music")
    end)

    SkyLib.Sound:play({
        name = "pregame_music",
        file_name = "zm_gen_pregame.ogg",
        sound_type = "music",
        custom_package = "SkyLib-zm-assets",
        custom_dir = "units/pd2_mod_zombies/sounds/zm_generic",
        is_relative = false,
        is_loop = false,
        is_3d = false,
        use_velocity = false
    })
end)

function HUDMissionBriefing:set_slot_outfit(peer_id, criminal_name, outfit)
	local slot = self._ready_slot_panel:child("slot_" .. tostring(peer_id))

	if not slot or not alive(slot) then
		return
	end

	if managers.network:session() and not managers.network:session():peer(peer_id) then
		return
	end

	local detection_panel = slot:child("detection")

	detection_panel:child("detection_left"):set_visible(false)
	detection_panel:child("detection_right"):set_visible(false)
	detection_panel:set_visible(false)
	slot:child("detection_value"):set_visible(true)
    slot:child("detection_value"):set_text("MAX: " .. tostring(SkyLib.CODZ._players[peer_id].max_waves_survived))
    slot:child("detection_value"):set_color(Color(1, 0, 1))
end]]