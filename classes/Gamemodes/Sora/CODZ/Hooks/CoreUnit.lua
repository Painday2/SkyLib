function safe_spawn_unit(unit_name, ...)

    local arg = {...}
    local pos = arg[1]

    if SkyLib and SkyLib.CODZ then
        if unit_name == Idstring("units/pd2_dlc_hvh/characters/ene_spook_hvh_1/ene_spook_hvh_1") or unit_name == Idstring("units/pd2_dlc_hvh/characters/ene_bulldozer_hvh_1/ene_bulldozer_hvh_1") or unit_name == Idstring("units/pd2_dlc_hvh/characters/ene_bulldozer_hvh_2/ene_bulldozer_hvh_2") or unit_name == Idstring("units/pd2_dlc_hvh/characters/ene_bulldozer_hvh_3/ene_bulldozer_hvh_3") or unit_name == Idstring("units/pd2_dlc_help/characters/ene_zeal_bulldozer_halloween/ene_zeal_bulldozer_halloween") or unit_name == Idstring("units/pd2_mod_zombies/characters/ene_shadow_cloaker_1/ene_shadow_cloaker_1") then
            if Network:is_server() and not SkyLib.Network:_is_solo() then
                LuaNetworking:SendToPeers("SpecialWave_SpawnPosition", math.vector_to_string(pos))
            end

            if pos then
                World:effect_manager():spawn({
                    effect = Idstring("units/pd2_mod_zombies/effects/zm/zm_special_spawn"),
                    position = pos
                })
            end

            if unit_name == Idstring("units/pd2_mod_zombies/characters/ene_shadow_cloaker_1/ene_shadow_cloaker_1") then
                if Network:is_server() and not SkyLib.Network:_is_solo() then
                    LuaNetworking:SendToPeers("SpecialWave_PlayShadowSpook", math.vector_to_string(pos))
                end
                SkyLib.Sound:play({
                    name = "zm_ene_shadow_scream_01",
                    custom_package = "assets_zm",
                    custom_dir = "units/pd2_mod_zombies/sounds/zm_enemy/shadow",
                    file_name = "zm_ene_shadow_scream_01.ogg",
                    is_loop = false,
                    is_relative = false,
                    is_3d = true,
                    position = pos
                })
            end

            SkyLib.Sound:play({
                name = "zm_enemy_spawn_electrical",
                file_name = "zm_enemy_spawn_electrical.ogg",
                custom_package = "assets_zm",
                custom_dir = "units/pd2_mod_zombies/sounds/zm_enemy/spawning",
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
        end
    end

	if editor_load_unit(unit_name) then
		return World:spawn_unit(unit_name:id(), ...)
	end
end