Hooks:PostHook(InteractionTweakData, "init", "zm_dah_init_int", function(self, tweak_data)

	self.pick_lock_hard_no_skill.timer = 7
	

	self.zm_call_elevator = {
		zm_interaction = true,
		zm_elevator = true,
		points_cost = 250,
		start_active = false,
		interact_distance = 125,
		timer = 0.5
	}
	
	self.zm_unlock_elevator = {
		zm_interaction = true,
		zm_elevator = true,
		points_cost = 750,
		start_active = false,
		interact_distance = 125,
		timer = 0.5
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
	
	self.zm_keycard_place = {
		text_id = "zm_place_keycard",
		sound_done = "pick_up_key_card",
		start_active = false,
		interact_distance = 500
	}

	self.zm_open_vent = {
		text_id = "zm_open_vent",
		start_active = false,
		sound_start = "bar_move_vent_panel",
		sound_interupt = "bar_move_vent_panel_cancel",
		sound_done = "bar_move_vent_panel_finished",
		timer = 1
	}

	self.zm_pickup_antenna_part = {
		text_id = "zm_pickup_antenna_part",
		start_active = false,
		timer = 1
	}
	
	self.zm_place_antenna_part = {
		text_id = "zm_place_antenna_part",
		start_active = false,
		timer = 1
	}
	
	self.zm_pickup_gum = {
		text_id = "zm_pickup_gum",
		start_active = false,
		interact_distance = 125
	}
	
	self.computer_blueprints = {
		text_id = "hud_int_search_blueprints",
		action_text_id = "hud_action_searching_blueprints",
		timer = 4.5,
		axis = "x",
		stay_active = true,
		contour = "interactable_icon",
		interact_distance = 200,
		sound_start = "bar_shuffle_papers",
		sound_interupt = "bar_shuffle_papers_cancel",
		sound_done = "bar_shuffle_papers_finished",
		icon = "equipment_files",
		special_equipment_block = "blueprints"
	}

end)