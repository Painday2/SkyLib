SkyLibTweakData = SkyLibTweakData or class()

function SkyLibTweakData:init()
    self.gamemodes = {
        codzm = SkyLib.CODZ,
        survival = SkyLib.Survival
    }
end

function SkyLibTweakData:add_gamemode(mode)
    local idx = #self.gamemodes + 1
    table.insert(self.gamemodes, idx, mode)

    SkyLib:log("Added gamemode", mode)
end