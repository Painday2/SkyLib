SkyLib.CODZ.PowerUpManager = SkyLib.CODZ.PowerUpManager or class()

function SkyLib.CODZ.PowerUpManager:init()
    self._default_color_grading = "color_payday"

    self._zombie_blood_obj = {
        Idstring("Spine1"),
        Idstring("Head"),
        Idstring("Spine2"),
        Idstring("Spine"),
        Idstring("Neck")
    }

    self._zombie_blood_obj_small = {
        Idstring("LeftShoulder"),
        Idstring("LeftArm"),
        Idstring("LeftForeArm"),
        Idstring("LeftForeArmRoll"),
        Idstring("LeftHand"),
        Idstring("RightShoulder"),
        Idstring("RightArm"),
        Idstring("RightForeArm"),
        Idstring("RightForeArmRoll"),
        Idstring("RightHand"),
        Idstring("LeftUpLeg"),
        Idstring("LeftLeg"),
        Idstring("LeftFoot"),
        Idstring("RightUpLeg"),
        Idstring("RightLeg"),
        Idstring("RightFoot")
    }

    self._zombie_blood_obj_trails = {
        Idstring("LeftHand"),
        Idstring("RightHand"),
        Idstring("LeftFoot"),
        Idstring("RightFoot")
    }
end

function SkyLib.CODZ.PowerUpManager:execute_max_ammo()
    local player_unit = managers.player:player_unit()

    if player_unit then
        for id,weapon in pairs( player_unit:inventory():available_selections() ) do
            if alive(weapon.unit) then
                weapon.unit:base():soft_replenish()
                managers.hud:set_ammo_amount( id, weapon.unit:base():ammo_info() )
            end
            
            managers.player:add_grenade_amount(10, true)
            managers.player:add_cable_ties(2)
        end
    end

    if managers.hud then
        managers.hud:show_hint( { text = "Max Ammo!" } )
    end

    self._source = SoundDevice:create_source("max_ammo_announcer")
    self._source:post_event("zm_pwrup_max_ammo")
end

function SkyLib.CODZ.PowerUpManager:execute_double_points()
    managers.hud._hud_codz:_set_gift_visible("icon_double_points", true)
    SkyLib.CODZ:_setup_event_state("double_points", true)

    self._source = SoundDevice:create_source("double_points_announcer")
    self._source:post_event("zm_pwrup_double_points")

    SkyLib.Sound:play({
        name = "zm_pwrup_double_points",
        file_name = "zm_pwrup_double_points.ogg",
        sound_type = "sfx",
        custom_dir = "units/pd2_mod_zombies/sounds/zm_power_ups",
        custom_package = "assets_zm",
        is_relative = false,
        is_loop = false,
        is_3d = false,
        use_velocity = false
    })

    SkyLib:wait(30, function()
        SkyLib.CODZ:_setup_event_state("double_points", false)
        managers.hud._hud_codz:_set_gift_visible("icon_double_points", false)
    end)
end

function SkyLib.CODZ.PowerUpManager:execute_firesale()
    if managers.hud then
        managers.hud._hud_codz:_set_gift_visible("icon_firesale", true) 
    end

    self._source = SoundDevice:create_source("firesale_announcer")
    self._source:post_event("zm_pwrup_firesale")
    SkyLib.CODZ:_setup_event_state("firesale", true)

    SkyLib.Sound:play({
        name = "zm_pwrup_firesale",
        file_name = "zm_pwrup_firesale.ogg",
        sound_type = "sfx",
        custom_dir = "units/pd2_mod_zombies/sounds/zm_power_ups",
        custom_package = "assets_zm",
        is_relative = false,
        is_loop = false,
        is_3d = false,
        use_velocity = false
    })
	
	SkyLib.Sound:play({
        name = "zm_pwrup_firesale_song",
        file_name = "zm_pwrup_firesale_song.ogg",
        sound_type = "sfx",
        custom_dir = "units/pd2_mod_zombies/sounds/zm_power_ups", 
        custom_package = "assets_zm",
        is_relative = false,
        is_loop = false,
        is_3d = false,
        use_velocity = false
    })

    SkyLib:wait(30, function()
        SkyLib.CODZ:_setup_event_state("firesale", false)
        managers.hud._hud_codz:_set_gift_visible("icon_firesale", false)
    end)
end

function SkyLib.CODZ.PowerUpManager:execute_instakill()
    managers.hud._hud_codz:_set_gift_visible("icon_instakill", true)
    SkyLib.CODZ:_setup_event_state("instakill", true)
    self._source = SoundDevice:create_source("instakill_announcer")
    self._source:post_event("zm_pwrup_instakill")

    SkyLib.Sound:play({
        name = "zm_pwrup_instakill",
        file_name = "zm_pwrup_instakill.ogg",
        sound_type = "sfx",
        custom_dir = "units/pd2_mod_zombies/sounds/zm_power_ups", 
        custom_package = "assets_zm",
        is_relative = false,
        is_loop = false,
        is_3d = false,
        use_velocity = false
    })

    SkyLib:wait(30, function()
        SkyLib.CODZ:_setup_event_state("instakill", false)
        managers.hud._hud_codz:_set_gift_visible("icon_instakill", false)
    end)
end

function SkyLib.CODZ.PowerUpManager:execute_kaboom()
    local overlay_effect = {
        blend_mode = "normal",
        sustain = 0,
        play_paused = true,
        fade_in = 0,
        fade_out = 3,
        color = Color(0.65, 1, 1, 1),
        timer = TimerManager:main()
    }
    
    self._source = SoundDevice:create_source("announcer_nuke")
    self._source:post_event("zm_pwrup_nuke")

    self._source_boom = SoundDevice:create_source("nuke_explosion")
    self._source_boom:post_event("zm_pwrup_nuke_explosion")

    managers.overlay_effect:play_effect(overlay_effect)

    local double_point_effect = SkyLib.CODZ:_is_event_active("double_points") and 2 or 1

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

    SkyLib:wait(1, function()
        local function nukeunit(pawn)
            local col_ray = { }
            col_ray.ray = Vector3(1, 0, 0)
            col_ray.position = pawn.unit:position()
        
            local action_data = {}
            action_data.variant = "explosion"
            action_data.damage = 1000000
            action_data.attacker_unit = nil
            action_data.col_ray = col_ray
        
            pawn.unit:character_damage():damage_explosion(action_data)
        end

        for u_key,u_data in pairs(managers.enemy:all_enemies()) do
            nukeunit(u_data)
        end

        SkyLib.CODZ:_money_change(400 * double_point_effect , SkyLib.Network:_my_peer_id())
    end)
end

function SkyLib.CODZ.PowerUpManager:execute_blood_money()
    SkyLib.Sound:play({
        name = "blood_money_pickup",
        file_name = "zm_pwrup_float_collect.ogg",
        sound_type = "sfx",
        custom_dir = "units/pd2_mod_zombies/sounds/zm_power_ups", 
        custom_package = "assets_zm",
        is_relative = false,
        is_loop = false,
        is_3d = false,
        use_velocity = false
    })

    self._source = SoundDevice:create_source("bloodmoney_announcer")
    self._source:post_event("zm_pwrup_blood_money")

    local cash_table = {
        50,
        100,
        150,
        200,
        250,
        300,
        500
    }

    local double_points = SkyLib.CODZ._level.active_events.double_points and 2 or 1
    local random_cash = cash_table[math.random(#cash_table)] * double_points
    local peer_id = SkyLib.Network:_my_peer_id()
    SkyLib.CODZ:_money_change(random_cash, peer_id)
end

function SkyLib.CODZ.PowerUpManager:execute_zombie_blood()
    local previous_grading = self._default_color_grading
    local zb_grading = "color_sin_classic"
    local zb_duration = 30
    local team_data_player = managers.groupai:state():team_data(tweak_data.levels:get_default_team_ID("player"))
    local team_data_enemy = managers.groupai:state():team_data(tweak_data.levels:get_default_team_ID("non_combatant"))
    local my_peer_id = SkyLib.Network:_my_peer_id()

    SkyLib.Sound:play({
        name = "zombie_blood_pickup",
        file_name = "zm_pwrup_float_collect.ogg",
        sound_type = "sfx",
        custom_dir = "units/pd2_mod_zombies/sounds/zm_power_ups",
        custom_package = "assets_zm",
        is_relative = false,
        is_loop = false,
        is_3d = false,
        use_velocity = false
    })

    self._source_ambiance = SoundDevice:create_source("zombieblood_ambiance")
    self._source_ambiance:post_event("zm_pwrup_zombie_blood_ambiance")

    self._source = SoundDevice:create_source("zombieblood_announcer")
    self._source:post_event("zm_pwrup_zombie_blood")

    managers.hud._hud_codz:_set_gift_visible("icon_zombie_blood", true)
    SkyLib.CODZ:_setup_event_state("zombie_blood", true)

    -- Set Grading
    managers.environment_controller:set_default_color_grading(zb_grading)
    managers.environment_controller:refresh_render_settings()

    -- Set Default Team
    local unit = managers.criminals:character_unit_by_peer_id(my_peer_id)
    
    if alive(unit) then
        unit:movement():set_team(team_data_enemy)
    end

    SkyLib:wait(31, function()
        -- Revert changes
        managers.environment_controller:set_default_color_grading(previous_grading)
        managers.environment_controller:refresh_render_settings()

        if alive(unit) then
            unit:movement():set_team(team_data_player)
        end

        LuaNetworking:SendToPeers( "ZombieBloodEnded", "1" )
        SkyLib.CODZ:_setup_event_state("zombie_blood", false)
    end)
end

function SkyLib.CODZ.PowerUpManager:execute_zombie_blood_on(unit)
    if not unit then
        return
    end

    for id, obj in pairs(self._zombie_blood_obj) do
        World:effect_manager():spawn({
            effect = Idstring("units/pd2_mod_zombies/effects/zm_power_ups/zm_blood_smoke_distorted"),
            parent = unit:get_object(obj)
        })
    end

    for id_small, obj_small in pairs(self._zombie_blood_obj_small) do
        World:effect_manager():spawn({
            effect = Idstring("units/pd2_mod_zombies/effects/zm_power_ups/zm_blood_smoke_distorted_small"),
            parent = unit:get_object(obj_small)
        })
    end

    for id_trail, obj_trail in pairs(self._zombie_blood_obj_trails) do
        World:effect_manager():spawn({
            effect = Idstring("units/pd2_mod_zombies/effects/zm_power_ups/zm_blood_smoke_trail_small"),
            parent = unit:get_object(obj_trail)
        })
    end
end