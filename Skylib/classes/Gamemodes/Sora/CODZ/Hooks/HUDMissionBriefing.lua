SkyHook:Post(HUDMissionBriefing, "set_player_slot", function(self, nr, params)
    local current_name = params.name
    local peer_id = params.peer_id

    local data = {
        id = peer_id,
        name = current_name
    }

    SkyLib.CODZ:_create_new_player(data)
end)