core:import("CoreMissionScriptElement")
ElementAnnouncerGift = ElementAnnouncerGift or class(CoreMissionScriptElement.MissionScriptElement)

function ElementAnnouncerGift:init(...)
	ElementAnnouncerGift.super.init(self, ...)
end
function ElementAnnouncerGift:client_on_executed(...)
	self:on_executed(...)
end

function ElementAnnouncerGift:on_executed(instigator)

	if not self._values.enabled then
		self._mission_script:debug_output("Element '" .. self._editor_name .. "' not enabled. Skip.", Color(1, 1, 0, 0))
		return
	end

    if self._values.gift_id == "max_ammo" then
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

        self._source = SoundDevice:create_source(self._editor_name)
		self._source:set_position(self._values.position)
        self._source:set_orientation(self._values.rotation)
        self._source:post_event("zm_announcer_max_ammo")
    end

    if self._values.gift_id == "firesale" then
        if managers.hud then
            managers.hud._hud_zm_waves:_set_gift_visible("icon_firesale", true) 
        end

        managers.wdu:_setup_event_state("firesale", true)
    -- Scripted in game
    end

    if self._values.gift_id == "firesale_first" then
    -- Scripted in game
    end

    if self._values.gift_id == "firesale_disable" then
        managers.wdu:_setup_event_state("firesale", false)
        managers.hud._hud_zm_waves:_set_gift_visible("icon_firesale", false)
    end

    if self._values.gift_id == "double_points" then
        managers.hud._hud_zm_waves:_set_gift_visible("icon_double_points", true) 
        managers.wdu:_setup_event_state("double_points", true)
        self._source = SoundDevice:create_source(self._editor_name)
		self._source:set_position(self._values.position)
        self._source:set_orientation(self._values.rotation)
        self._source:post_event("zm_announcer_double_points")

        managers.wdu:_element_play_sound({
            name = self._id,
			file_name = "zm_pwrup_double_points.ogg",
			sound_type = "sfx",
			custom_dir = "units/pd2_mod_zombies/sounds/zm_power_ups",
            is_relative = false,
            is_loop = false,
            is_3d = false,
            use_velocity = false
        })
    end

    if self._values.gift_id == "double_points_disable" then
        managers.wdu:_setup_event_state("double_points", false)
        managers.hud._hud_zm_waves:_set_gift_visible("icon_double_points", false)         
    end

    if self._values.gift_id == "instakill" then
        managers.hud._hud_zm_waves:_set_gift_visible("icon_instakill", true)
        managers.wdu:_setup_event_state("instakill", true)
        self._source = SoundDevice:create_source(self._editor_name)
		self._source:set_position(self._values.position)
        self._source:set_orientation(self._values.rotation)
        self._source:post_event("zm_announcer_instakill")

        managers.wdu:_element_play_sound({
            name = self._id,
			file_name = "zm_pwrup_instakill.ogg",
			sound_type = "sfx",
			custom_dir = "units/pd2_mod_zombies/sounds/zm_power_ups",
            is_relative = false,
            is_loop = false,
            is_3d = false,
            use_velocity = false
        })
    end

    if self._values.gift_id == "instakill_disable" then
        managers.wdu:_setup_event_state("instakill", false)        
        managers.hud._hud_zm_waves:_set_gift_visible("icon_instakill", false)        
    end

    if self._values.gift_id == "kaboom" then
        local overlay_effect = {
			blend_mode = "normal",
			sustain = 0,
			play_paused = true,
			fade_in = 0,
			fade_out = 3,
			color = Color(0.65, 1, 1, 1),
			timer = TimerManager:main()
        }
        
        self._source = SoundDevice:create_source(self._editor_name)
		self._source:set_position(self._values.position)
        self._source:set_orientation(self._values.rotation)
        self._source:post_event("zm_announcer_kaboom")

        self._source_boom = SoundDevice:create_source(self._editor_name .. "_boom")
		self._source_boom:set_position(self._values.position)
        self._source_boom:set_orientation(self._values.rotation)
        self._source_boom:post_event("zm_boom")

        managers.overlay_effect:play_effect(overlay_effect)

        managers.wdu:wait(1, "kaboom_wait", function()
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
        end)
    end
	
	ElementAnnouncerGift.super.on_executed(self, instigator)
end

function ElementAnnouncerGift:on_script_activated()
    self._mission_script:add_save_state_cb(self._id)
end

function ElementAnnouncerGift:save(data)
    data.save_me = true
    data.enabled = self._values.enabled
end

function ElementAnnouncerGift:load(data)
    self:set_enabled(data.enabled)
end