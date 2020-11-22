SkyLib.SGM = SkyLib.SGM or class()

function SkyLib.SGM:init(custom_rules)
    custom_rules = custom_rules or {}

    self._players = {
        [1] = {
            name = "Operator not online",
            steam_id = 0,
            connected = false,
            money = custom_rules.starting_money,
            max_waves = 0,
            title = 1
        },
        [2] = {
            name = "Operator not online",
            steam_id = 0,
            connected = true,
            money = custom_rules.starting_money,
            max_waves = 0,
            title = 1
        },
        [3] = {
            name = "Operator not online",
            steam_id = 0,
            connected = true,
            money = custom_rules.starting_money,
            max_waves = 0,
            title = 1
        },
        [4] = {
            name = "Operator not online",
            steam_id = 0,
            connected = true,
            money = custom_rules.starting_money,
            max_waves = 0,
            title = 1
        }
    }
    
    self._current_wave = 0
    self._first_wave_enemies = 12
    self._starting_money = custom_rules.starting_money

    log("SkyLib.SurvivalGameManager - Initd")
end

function SkyLib.SGM:_create_new_player(peer_id, name, steam_id)
    self._players[peer_id].name = name
    self._players[peer_id].steam_id = steam_id
    self._players[peer_id].connected = true
end

function SkyLib.SGM:_destroy_player(peer_id)
    self._players[peer_id] = {
        name = "none",
        steam_id = 0,
        connected = false,
        money = self._starting_money,
        max_waves = 0,
        title = 1
    }
end

function SkyLib.SGM:_get_current_wave()
    return self._current_wave
end

function SkyLib.SGM:_increment_wave()
    self._current_wave = self._current_wave + 1
    SkyLib.Network:_send("SurvivalWave", self._current_wave)
end

function SkyLib.SGM:_get_money()
    local peer = SkyLib.Network:_my_peer_id()
    return tonumber(self._players[peer].money)
end

function SkyLib.SGM:_get_money_by_peer(peer_id)
    return tonumber(self._players[peer_id].money)
end

function SkyLib.SGM:_get_players()
    return self._players
end

function SkyLib.SGM:_get_connected_players()
    local t = {}

    for i, player in ipairs(self._players) do
        if player.connected then
            table.insert(t, player)
        end
    end

    return t
end