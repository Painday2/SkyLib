SkyLib.Network = SkyLib.Network or class()

function SkyLib.Network:init()
    log("SkyLib.Network : Initialized.")
end

function SkyLib.Network:_my_peer_id()
    return Global.game_settings.single_player and 1 or managers.network:session() and managers.network:session():local_peer():id() or 1
end

function SkyLib.Network:_get_steam_id_by_peer(peer_id)
    local peer_data = managers.network and managers.network:session() and managers.network:session():peer(peer_id)

    if peer_data then
        return peer_data:user_id()
    end
end

function SkyLib.Network:_peer_by_peer_id(peer_id)
    if not managers.network and managers.network:session() then
        return
    end

    peer_id = peer_id or 1
    return managers.network and managers.network:session() and managers.network:session():peer(peer_id)
end

function SkyLib.Network:_get_tweak_color_by_peer_id(peer_id)
    return tweak_data.chat_colors[peer_id]
end

function SkyLib.Network:_number_of_players()
    return managers.network:session() and managers.network:session():amount_of_players() or 1
end

function SkyLib.Network:_is_solo()
    if Global.game_settings.single_player then
        return true
    end

    local nb_players = self:_number_of_players()

    if nb_players == 1 then
        return true
    end

    return false
end

function SkyLib.Network:_send(pck, data)
    local safe_data = ""

    if type(data) == "number" then
        safe_data = tostring(data)
    elseif type(data) == "table" then
        safe_data = LuaNetworking:TableToString(data)
    else
        safe_data = tostring(pck, data) -- Parse data to str anyways.
    end

    LuaNetworking:SendToPeers(pck, safe_data)
end

function SkyLib.Network:_init_survival_network()
    Hooks:Add("NetworkReceivedData", "NetworkReceivedData_SkyLibNetwork", function(peer, pck, data)



    end)
end

function SkyLib.Network:_init_codz_network()
    Hooks:Add("NetworkReceivedData", "NetworkReceivedData_SkyLibNetwork", function(sender, id, data)
        if id == "UpdPts" then
            local tbl_data = LuaNetworking:StringToTable(data)
            SkyLib.CODZ._players[sender].codz_points = tonumber(tbl_data.cm)
            local positive = tonumber(tbl_data.pg) > 0 and true or false

            if managers.hud then
                SkyLib.CODZ:_update_hud_element()
                --managers.hud._hud_zm_points:_animate_points_gained_v2(sender, tonumber(tbl_data.pg), positive)
            end

            SkyLib.CODZ:_update_total_score(sender, tonumber(tbl_data.pg))
        end
        if id == "PWUP_EXECUTE" then
            local power_up = tonumber(data)
    
            if power_up == 1 then
                SkyLib.CODZ.PowerUpManager:execute_max_ammo()
            elseif power_up == 2 then
                SkyLib.CODZ.PowerUpManager:execute_double_points()
            elseif power_up == 3 then
                SkyLib.CODZ.PowerUpManager:execute_instakill()
            elseif power_up == 4 then
                SkyLib.CODZ.PowerUpManager:execute_firesale()
            elseif power_up == 5 then
                SkyLib.CODZ.PowerUpManager:execute_kaboom()
            elseif power_up == 7 then
                local unit_by_peer = managers.criminals:character_unit_by_peer_id(sender)
                if alive(unit_by_peer) then
                    unit_by_peer:movement():set_team(managers.groupai:state():team_data(tweak_data.levels:get_default_team_ID("non_combatant")))
                end
    
                SkyLib.CODZ.PowerUpManager:execute_zombie_blood_on(unit_by_peer)
            end
        end
    
        if id == "ZMWallBuyData" then
            local decode = LuaNetworking:StringToTable(data)
            ZMWallbuyBase:sync_spawn(decode)
        end

        if id == "ZMBoxData" then
            local decode = LuaNetworking:StringToTable(data)
            MisterySafeBase:sync_spawn(decode)
        end

        if id == "ZombieBloodEnded" then
            local unit_by_peer = managers.criminals:character_unit_by_peer_id(sender)
            if alive(unit_by_peer) then
                unit_by_peer:movement():set_team(managers.groupai:state():team_data(tweak_data.levels:get_default_team_ID("player")))
            end
        end

        if id == "SpecialWave_PlayShadowSpook" then
            local pos = string_to_vector(data)

            SkyLib.Sound:play({
                name = "play_shadow_spook",
                custom_dir = "units/pd2_mod_zombies/sounds/zm_enemy/shadow",
                custom_package = "assets_zm",
                file_name = "zm_ene_shadow_scream_01.ogg",
                is_loop = false,
                is_relative = false,
                is_3d = true,
                position = pos
            })
        end

        if id == "SpecialWave_SpawnPosition" then
            --if managers.wdu:_is_special_wave() then
                local pos = string_to_vector(data)

                if pos then
                    World:effect_manager():spawn({
                        effect = Idstring("units/pd2_mod_zombies/effects/zm/zm_special_spawn"),
                        position = pos
                    })
                end

                SkyLib.Sound:play({
                    name = "zm_enemy_spawn_electrical",
                    file_name = "zm_enemy_spawn_electrical.ogg",
                    custom_dir = "units/pd2_mod_zombies/sounds/zm_enemy/spawning",
                    custom_package = "assets_zm",
                    is_loop = false,
                    is_relative = false
                })

                DelayedCalls:Add("zm_shake_little_delay", 1.6, function()
                    if alive(managers.player:player_unit()) then
                        local feedback = managers.feedback:create("mission_triggered")
                        feedback:set_unit(managers.player:player_unit())
                        feedback:set_enabled("camera_shake", true)
                        feedback:set_enabled("rumble", true)
                        feedback:set_enabled("above_camera_effect", false)

                        local params = {
                            "camera_shake",
                            "multiplier",
                            1,
                            "camera_shake",
                            "amplitude",
                            0.5,
                            "camera_shake",
                            "attack",
                            0.05,
                            "camera_shake",
                            "sustain",
                            0.15,
                            "camera_shake",
                            "decay",
                            0.5,
                            "rumble",
                            "multiplier_data",
                            1,
                            "rumble",
                            "peak",
                            0.5,
                            "rumble",
                            "attack",
                            0.05,
                            "rumble",
                            "sustain",
                            0.15,
                            "rumble",
                            "release",
                            0.5
                        }

                        feedback:play(unpack(params))
                    end
                end)
            --end
        end

        if id == "ZMStatsEndGame" then
            local player_id = sender
            local panel_endgame = managers.hud._zm_result_panel[player_id]
            local kills_text = panel_endgame:child("total_kills")
            local downs_text = panel_endgame:child("total_downs")
            local revives_text = panel_endgame:child("total_revives")
            local total_score = panel_endgame:child("total_score")

            local stats = LuaNetworking:StringToTable(data)

            kills_text:set_text(stats.kills)
            downs_text:set_text(stats.downs)
            revives_text:set_text(stats.revives)
            total_score:set_text(stats.total_score)
        end

        if id == "ShareCashTo" then
            local player_id = tonumber(data)
            managers.wdu:_add_money_to(player_id, 1000, true)
        end

        if id == "SecretsCompleted" then
            if Network:is_server() then
                local unit_by_peer = managers.criminals:character_unit_by_peer_id(sender)
                if alive(unit_by_peer) then
                    local rpc_params = {
                        "give_equipment",
                        "perk_god",
                        1,
                        false
                    }

                    unit_by_peer:network():send_to_unit(rpc_params)
                end
            end
        end
    end)
end