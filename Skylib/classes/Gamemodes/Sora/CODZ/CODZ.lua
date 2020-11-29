SkyLib.CODZ = SkyLib.CODZ or class()
SkyLib.CODZ.INITIALIZED = false

function SkyLib.CODZ:init(custom_rules)
    self._starting_money = custom_rules and custom_rules.mod_start_money or 50000
    self._pregame_music = custom_rules and custom_rules.mod_pregame_music or nil
    self._gameover_music = custom_rules and custom_rules.mod_gameover_music or nil
    self._victory_music = custom_rules and custom_rules.mod_victory_music or nil
    self._round_start_musics = custom_rules and custom_rules.mod_round_start_musics or {  }
    self._round_end_musics = custom_rules and custom_rules.mod_round_end_musics or {  }
    self._special_round_start_musics = custom_rules and custom_rules.mod_special_round_start_musics or {  }
    self._special_round_end_musics = custom_rules and custom_rules.mod_special_round_end_musics or {  }

    self._players = {
        [1] = {
            name = "none",
            steam_id = 0,
            connected = false,
            codz_points = self._starting_money,
            codz_score = self._starting_money,
            codz_max_waves = 0
        },
        [2] = {
            name = "none",
            steam_id = 0,
            connected = false,
            codz_points = self._starting_money,
            codz_score = self._starting_money,
            codz_max_waves = 0
        },
        [3] = {
            name = "none",
            steam_id = 0,
            connected = false,
            codz_points = self._starting_money,
            codz_score = self._starting_money,
            codz_max_waves = 0
        },
        [4] = {
            name = "none",
            steam_id = 0,
            connected = false,
            codz_points = self._starting_money,
            codz_score = self._starting_money,
            codz_max_waves = 0
        }
    }

    self._economy = custom_rules and custom_rules.mod_economy or {
        default = 50,
        on_kill = {
            shield = 80,
            spooc = 120,
            tank = 150,
            tank_green = 160,
            tank_black = 175,
            tank_skull = 190,
            tank_hw = 200,
            taser = 100,
            medic = 80,
            sniper = 95
        },
        on_hit = 10,
        on_headshot = 50,
        on_melee_kill = 130
    }

    self._level = custom_rules and custom_rules.mod_level_rules or {
        zombies = {
            currently_spawned = 8,
            total_alive = 0,
            max_spawns = 8,
            max_special_wave_total_spawns = 10,
            killed = 0,
            add_on_end_wave = 2,
            max_special_wave_spawns = 2
        },
        wave = {
            current = 0,
            delay_timeout = 15,
            is_special_wave = false
        },
        active_events = {
            double_points = false,
            instakill = false,
            firesale = false,
            zombie_blood = false
        },
        power_up_chance = 99,
        power_up_table = {
            "zm_pwrup_max_ammo",
            "zm_pwrup_double_points",
            "zm_pwrup_firesale",
            "zm_pwrup_instakill",
            "zm_pwrup_nuke",
            "zm_pwrup_blood_money",
            "zm_pwrup_zombie_blood"
        },
        scale = 0,
        scale_value_max = 25
    }

    self._weapons = {
        mystery_box = { }
    }


    self:_init_hooks()
    SkyLib.Sound:init()
    --SkyLib.CODZ.WeaponHelper:init()
    SkyLib.Network:_init_codz_network()

    SkyLib.CODZ.INITIALIZED = true
    log("Initialized CODZ Gamemode.")
end

function SkyLib.CODZ:_init_hooks()
    log("Init Hooks.")

    local mod_path = SkyLib.ModPath

    self._hooks = {
        "classes/Gamemodes/Sora/CODZ/Hooks/InteractionTweakData",
        "classes/Gamemodes/Sora/CODZ/Hooks/InteractionExt",
        "classes/Gamemodes/Sora/CODZ/Hooks/EquipmentsTweakData",
        "classes/Gamemodes/Sora/CODZ/Hooks/ElementSpawnEnemyDummy",
        "classes/Gamemodes/Sora/CODZ/Hooks/ElementWeaponSwitch",
        "classes/Gamemodes/Sora/CODZ/Hooks/ElementWave",
        "classes/Gamemodes/Sora/CODZ/Hooks/IngameWaitingForPlayersState",
        "classes/Gamemodes/Sora/CODZ/Hooks/HUDManager",
        "classes/Gamemodes/Sora/CODZ/Hooks/HUDManagerPD2",
        "classes/Gamemodes/Sora/CODZ/Hooks/HUDMissionBriefing",
        "classes/Gamemodes/Sora/CODZ/Hooks/HUDIconsTweakData",
        "classes/Gamemodes/Sora/CODZ/Hooks/PlayerManager",
        "classes/Gamemodes/Sora/CODZ/Hooks/CopDamage",
        "classes/Gamemodes/Sora/CODZ/Hooks/CoreUnit",
        "classes/Gamemodes/Sora/CODZ/Hooks/CharacterTweakData",
        "classes/Gamemodes/Sora/CODZ/Hooks/PlayerDamage",
        "classes/Gamemodes/Sora/CODZ/Hooks/PowerUps",
        "classes/Gamemodes/Sora/CODZ/Hooks/PowerUpManager",
        "classes/Gamemodes/Sora/CODZ/Hooks/TweakData",
        "classes/Gamemodes/Sora/CODZ/Hooks/NewRaycastWeaponBase",
        "classes/Gamemodes/Sora/CODZ/Hooks/RaycastWeaponBase",
        "classes/Gamemodes/Sora/CODZ/Hooks/PlayerTased",
        "classes/Gamemodes/Sora/CODZ/Hooks/PlayerTweakData",
        "classes/Gamemodes/Sora/CODZ/Hooks/PlayerMovement",
        "classes/Gamemodes/Sora/CODZ/Hooks/PlayerStandard",
        "classes/Gamemodes/Sora/CODZ/Hooks/PlayerInventory",
        "classes/Gamemodes/Sora/CODZ/Hooks/ProjectilesTweakData",
        "classes/Gamemodes/Sora/CODZ/Hooks/TimeSpeedEffectTweakData",
        --"classes/Gamemodes/Sora/CODZ/Hooks/GroupAIStateBase",
        "classes/Gamemodes/Sora/CODZ/Hooks/GroupAIStateBesiege",
        "classes/Gamemodes/Sora/CODZ/Hooks/GroupAITweakData",
        "classes/Gamemodes/Sora/CODZ/Hooks/WeaponFactoryTweakData",

        "classes/Gamemodes/Sora/CODZ/Hooks/Interactions/ZMMoneyExt",

        "classes/Gamemodes/Sora/CODZ/Editor/EditorWave",
        "classes/Gamemodes/Sora/CODZ/Editor/EditorWeaponSwitch",
    }

    for _, hook in pairs(self._hooks) do
        dofile(mod_path .. hook .. ".lua")
        log("[SkyLib] Included script ", hook)
    end
end

function SkyLib.CODZ:_create_new_player(data)
    self._players[data.id].name = data.name
    self._players[data.id].codz_points = self._starting_money
    self._players[data.id].codz_score = self._starting_money
    self._players[data.id].connected = true
end


function SkyLib.CODZ:_update_total_score(peer_id, add)
    if not peer_id then
        return
    end

    self._players[peer_id].codz_score = self._players[peer_id].codz_score + add
end

function SkyLib.CODZ:_increase_wave_kills()
    self._level.zombies.killed = self._level.zombies.killed + 1
end

function SkyLib.CODZ:_reset_wave_kills()
    self._level.zombies.killed = 0
end

function SkyLib.CODZ:start_new_wave(t, was_special_wave)
    if not t then
        t = self._level.wave.delay_timeout
    end
    local special_wave = was_special_wave
    --log("start new wave")
    DelayedCalls:Add("zm_delay_between_waves", t, function()
        if special_wave then
            SkyLib.CODZ:_set_special_wave(false)
            --("false")
        end
        --log("delayed call")
        if SkyLib.CODZ._level.wave.is_special_wave and SkyLib.CODZ._level.zombies.killed == SkyLib.CODZ._level.zombies.max_special_wave_total_spawns then
            SkyLib.CODZ:_set_special_wave(false)
            --log("special false")
        end
        SkyLib.CODZ:_reset_wave_kills()
        SkyLib.CODZ:_respawn_players()
        self._level.zombies.currently_spawned = 0
        self:_multiply_zombies_by_wave()
    end)
end

function SkyLib.CODZ:_multiply_zombies_by_wave()
    if SkyLib.Network:_is_solo() then
        self._level.zombies.max_spawns = self._level.zombies.max_spawns + 2
        return
    end

    self._level.zombies.max_spawns = self._level.zombies.max_spawns + (self._level.zombies.add_on_end_wave + 2)
end

function SkyLib.CODZ:_increase_scale_value()
    self._level.scale = self._level.scale + 1
end

function SkyLib.CODZ:_scale_required()
    if self._level.scale >= self._level.scale_value_max then
        return false
    end

    return true
end

function SkyLib.CODZ:points_round(points)
    local mult = 10^(-1)
    return math.floor(points * mult + 0.5) / mult
end

function SkyLib.CODZ:_get_own_money()
    local my_id = SkyLib.Network:_my_peer_id()
    return self._players[my_id].codz_points
end

function SkyLib.CODZ:_player_connected(id)
    if self._players[id] and self._players[id].steam_id == 0 then
        return false
    end

    return true
end

function SkyLib.CODZ:_money_change(amount, peer_id)
    log("Adding ", amount, "to player", peer_id)
    self._players[peer_id].codz_points = self._players[peer_id].codz_points + amount

    if not SkyLib.Network:_is_solo() then
        local tbl = {
            cm = tostring(self:_get_own_money()),
            pg = tostring(amount)
        }
        LuaNetworking:SendToPeers( "UpdPts", LuaNetworking:TableToString(tbl) )
    end

    local is_positive = amount > 0

    if is_positive then
        self:_update_total_score(peer_id, amount)
    end

    self:_update_hud_element()
end

function SkyLib.CODZ:_has_enough_money(amount, peer_id)
    if self._players[peer_id].codz_points >= amount then
        return true
    end

    return false
end

function SkyLib.CODZ:_update_hud_element()
    if not Global.game_settings.single_player then
        if managers and managers.network and managers.network:session() then
            for _, peer in pairs(managers.network:session():all_peers()) do
                local me = peer:id() == SkyLib.Network:_my_peer_id()
                self._players[peer:id()].steam_id = peer:user_id()

                local player_panel = managers.hud._hud_codz._points_panel:child("player_panel_" .. peer:id())
                player_panel:set_visible(true)

                Steam:friend_avatar(2, peer:user_id(), function (texture)
                    local avatar = texture or "guis/textures/pd2/none_icon"
                    player_panel:child("player_avatar_" .. peer:id()):set_image(avatar)
                end)

                SkyLib:wait(1, function()
                    Steam:friend_avatar(2, peer:user_id(), function (texture)
                        local avatar = texture or "guis/textures/pd2/none_icon"
                        player_panel:child("player_avatar_" .. peer:id()):set_image(avatar)
                    end)
                end)

                player_panel:child("player_points_" .. peer:id()):set_text(tostring(self._players[peer:id()].codz_points))

                if not me then
                    player_panel:child("player_bg_points_" .. peer:id()):set_image("ui/bloodtrail_other")
                end
            end
        end
    else
        self._players[1].steam_id = Steam:userid()
        local player_panel = managers.hud._hud_codz._points_panel:child("player_panel_1")
        player_panel:set_visible(true)

        Steam:friend_avatar(2, Steam:userid(), function (texture)
            local avatar = texture or "guis/textures/pd2/none_icon"
            player_panel:child("player_avatar_1"):set_image(avatar)
        end)

        player_panel:child("player_points_1"):set_text(tostring(self._players[1].codz_points))
    end
end

function SkyLib.CODZ:_increase_wave()
    self._level.wave.current = self._level.wave.current + 1
end

function SkyLib.CODZ:_get_current_wave()
    return self._level.wave.current
end

function SkyLib.CODZ:_set_special_wave(status)
    self._level.wave.is_special_wave = status
end

function SkyLib.CODZ:_setup_event_state(event, state)
    self._level.active_events[event] = state
end

function SkyLib.CODZ:_is_event_active(event)
    return self._level.active_events[event]
end

function SkyLib.CODZ:_respawn_players()
    for i = 1, 4, 1 do
        if managers.trade:is_peer_in_custody(i) then
            IngameWaitingForRespawnState.request_player_spawn(i)
        end
    end
end