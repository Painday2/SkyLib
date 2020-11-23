SkyHook:Post(HUDMissionBriefing, "set_player_slot", function(self, nr, params)
    local current_name = params.name
    local peer_id = params.peer_id
    local steam_id = SkyLib.Network:_get_steam_id_by_peer(peer_id)

    log("[SGM] Added Player:", tostring(current_name), tostring(peer_id), tostring(steam_id))

    SkyLib.SGM:_create_new_player(peer_id, current_name, steam_id)
end)