SkyLib = SkyLib or class()
SkyLib.managers = {}

function SkyLib:init()
    self._dev = true
    self._gamemode = "payday2_default"
    self._initialized = true
    self._project_key = nil

    self._delayed_calls = {}

    self:log("SkyLib is here!")
end

function SkyLib:init_by_gamemode(mode, rules)
    self:log("Initializing Gamemode", mode)
    self._tweak_data = SkyLibTweakData:new()

    for gamemode, class in pairs(self._tweak_data.gamemodes) do
        if mode == gamemode then
            self._gamemode = class
            class:init(rules)
            break
        end
    end

    self:log("Cannot set up a unknown gamemode: " .. mode)
end

function SkyLib:set_mod_key(key)
    self._project_key = key
end

function SkyLib:wait(seconds, func)
    local id = "SkyLib_DelayedCall_" .. #self._delayed_calls
    table.insert(self._delayed_calls, id)
    
    DelayedCalls:Add(id, seconds, func)
end

function SkyLib:log(t)
    --[[
        https://modworkshop.net/mydownloads.php?action=view_down&did=24192
        REQUIRED to see logs without crashing
    ]]

    if not self._dev then
        return
    end

    log("[SkyLib] " .. t)
end