SkyLib.CODZ = SkyLib.CODZ or class()
SkyLib.CODZ.INITIALIZED = false

function SkyLib.CODZ:init(custom_rules)
    self._starting_money = custom_rules and custom_rules.mod_start_money or 500
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
            currently_spawned = 0,
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
        power_up_chance = 3,
        power_up_table = {
            "max_ammo",
            "double_points",
            "firesale",
            "instakill",
            "nuke",
            "blood_money",
            "zombie_blood"
        },
        scale = 0,
        scale_value_max = 0
    }

    self:_init_hooks()
    SkyLib.Sound:init()
    SkyLib.Network:_init_codz_network()

    SkyLib.CODZ.INITIALIZED = true
    log("Initialized CODZ Gamemode.")
end

function SkyLib.CODZ:_init_hooks()
    log("Init Hooks.")

    local mod_path = SkyLib.ModPath

    self._hooks = {
        "classes/Gamemodes/Sora/CODZ/Hooks/ElementSpawnEnemyDummy",
        "classes/Gamemodes/Sora/CODZ/Hooks/HUDManager",
        "classes/Gamemodes/Sora/CODZ/Hooks/HUDManagerPD2",
        "classes/Gamemodes/Sora/CODZ/Hooks/HUDMissionBriefing",
        "classes/Gamemodes/Sora/CODZ/Hooks/PlayerManager",
        "classes/Gamemodes/Sora/CODZ/Hooks/CopDamage",

        "classes/Gamemodes/Sora/CODZ/Hooks/Interactions/ZMMoneyExt",

        "classes/Gamemodes/Sora/CODZ/Editor/EditorWave",
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

function SkyLib.CODZ:_get_own_money()
    local my_id = SkyLib.Network:_my_peer_id()
    return self._players[my_id].codz_points
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

function SkyLib.CODZ:_create_new_weapon(data)

    --[[
        Parameters:

        {
            weapon_id = "xxx"                                           -- ID Used in weapontweakdata
            factory_id = "wpn_fps_smg_xxx"                              -- ID Used in weaponfactorytweakdata
            based_on = {                                                -- IDs about the base weapon.
                weapon_id = "based_on_id",
                factory_id = "wpn_fps_smg_based_on"
            }
            generate_stances = true/false ; default: false              -- Automatically generate stances
            custom_factory_unit = "path_to_unit"                        -- Defines a new unit. If nothing defined, use the one from based_on.
            custom_blueprint = {                                        -- Weapon mod IDs for the new blueprint. If nothing defined, use the one from based_on.
                <blueprint data>
            }
            custom_stats = {                                            -- Stats as they would be defined in weapontweakdata. If nothing defined, use the one from based_on.
                <custom stats>
            },
            custom_ammo_clip = 30                                       -- How much bullets in mag. If nothing defined, use the one from based_on.
            custom_ammo_clips_max = 5                                   -- How much mags (Ammo clip * Clip Max). If nothing defined, use the one from based_on.
            custom_animation = {                                        -- Sometimes you have to define these, to make animations working. If nothing defined, use the one from based_on.
                hold = "anim",
                reload = "anim"
            }
        }

        weapon name string ID is defined:           wpn_<weapon_id>_name
    ]]

    local weapon_data = {
        weapon_id = data.weapon_id,
        factory_id = data.factory_id,
        based_on = data.based_on,
        generate_stances = data.generate_stances or false,
        custom_factory_unit = data.custom_factory_unit or nil,
        custom_blueprint = data.custom_blueprint or nil,
        custom_stats = data.custom_stats or nil,
        custom_ammo_clip = data.custom_ammo_clip or nil,
        custom_ammo_clips_max = data.custom_ammo_clips_max or nil,
        custom_animation = data.custom_animation or nil 
    }
end

function SkyLib.CODZ:_respawn_players()
    for i = 1, 4, 1 do
        if managers.trade:is_peer_in_custody(i) then
            IngameWaitingForRespawnState.request_player_spawn(i)
        end
    end
end