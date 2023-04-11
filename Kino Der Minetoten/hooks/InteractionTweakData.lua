Hooks:PostHook(InteractionTweakData, "init", "zm_kino_init_int", function(self, tweak_data)

	self.pick_lock_hard_no_skill.timer = 7

	self.use_lever = {
		text_id = "hud_int_use_lever",
		action_text_id = "hud_action_use_lever",
		timer = 0.5,
		start_active = false
	}

		self.zm_link_teleporter = { 
		text_id = "zm_link_teleporter",
		action_text_id = "zm_action_link_teleporter",
		timer = 1.0,
		start_active = false,
	}

	self.zm_use_teleporter = { 
		text_id = "zm_usetwo_teleporter",
		action_text_id = "zm_action_use_teleporter",
		timer = 5.0,
		start_active = false,
	}
	
	self.zm_free_points_25 = {
		zm_interaction = true,
		points_cost = -25,
		text_id = "zm_activate_song_invisible",
		action_text_id = "zm_activate_song_invisible",
		start_active = false,
		interact_distance = 75,
		axis = "y"
	}
	
	self.zm_free_points_1000 = {
		zm_interaction = true,
		points_cost = -1000,
		action_text_id = "zm_buy_weapon",
		start_active = false,
		axis = "y"
	}
	
	self.zm_trap_sentrygun = {
		zm_interaction = true,
		zm_trap = true,
		points_cost = 1000,
		action_text_id = "zm_opening_path",
		start_active = false,
		sound_done = "zm_gen_ching",
		timer = 0.5
	}
end)