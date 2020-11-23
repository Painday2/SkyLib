SkyHook:Post(PlayerManager, "init", function(self)
    self._updated_codz_panel = false
end)

SkyHook:Post(PlayerManager, "update", function(self, t, dt)
    if not self._updated_codz_panel then
        SkyLib.CODZ:_update_hud_element()
        self._updated_codz_panel = true
    end
end)