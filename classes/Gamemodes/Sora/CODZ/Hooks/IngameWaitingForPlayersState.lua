SkyHook:Pre(IngameWaitingForPlayersState, "sync_start", function(self)
    SkyLib.Sound:_destroy_source("pregame_music")
end)