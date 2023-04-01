SkyHook:Post(GameSetup, "init_managers", function(self)
    if not SkyLib._initialized then
        SkyLib:init()
    end
end)