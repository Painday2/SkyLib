Hooks:PostHook(InteractionTweakData, "init", "zm_init_new_interactions", function(self, tweak_data)

	self.pick_lock_hard_no_skill.timer = 7
	
	self.zm_free_raygun = {
		zm_interaction = true,
		weapon = "gun",
		weapon_id = "raygun",
		points_cost = 0,
		action_text_id = "zm_buy_weapon",
		start_active = false,
		sound_done = "bar_rescue",
		axis = "y",
		timer = 0.5
	}
	
	self.zm_secret_bunker = {
		text_id = "zm_secret_bunker_hack",
		action_text_id = "zm_hack",
		start_active = false,
		sound_start = "bar_keyboard",
		sound_interupt = "bar_keyboard_cancel",
		sound_done = "bar_keyboard_finished",
		timer = 5
	}

	self.zm_activate_song_invisible = {
		text_id = "zm_activate_song_invisible",
		action_text_id = "zm_buy_weapon",
		start_active = false,
		sound_done = "bar_steal_painting",
		interact_distance = 250
	}
	
	self.zm_invisible = {
		text_id = "zm_activate_song_invisible",
		start_active = false,
		action_text_id = "zm_buy_weapon",
		special_equipment_block = "gas",
		interact_distance = 250
	}

	self.zm_need_authorization = {
		text_id = "zm_need_authorization",
		special_equipment = "zm_power_on",
		equipment_text_id = "zm_need_authorization",
		start_active = false,
		timer = 3
	}
	
	self.zm_raygun_hint = { 
		text_id = "zm_teleporter",
		action_text_id = "zm_use_teleporter",
		start_active = false,
		special_equipment = "zm_power_on",
		equipment_text_id = "zm_raygun_hint",
	}
	
	self.zm_hack1 = {
		zm_interaction = true,
		hack = true,
		text_id = "zm_secret_bunker_hack",
		action_text_id = "zm_hack",
		start_active = false,
		points_cost = 1500,
		sound_start = "bar_keyboard",
		sound_interupt = "bar_keyboard_cancel",
		sound_done = "bar_keyboard_finished",
		timer = 5
	}
	
	self.zm_hack2 = {
		zm_interaction = true,
		hack = true,
		text_id = "zm_secret_bunker_hack",
		action_text_id = "zm_hack",
		start_active = false,
		points_cost = 3000,
		sound_start = "bar_keyboard",
		sound_interupt = "bar_keyboard_cancel",
		sound_done = "bar_keyboard_finished",
		timer = 5
	}
	
	self.zm_hack3 = {
		zm_interaction = true,
		hack = true,
		text_id = "zm_secret_bunker_hack",
		action_text_id = "zm_hack",
		start_active = false,
		points_cost = 3000,
		sound_start = "bar_keyboard",
		sound_interupt = "bar_keyboard_cancel",
		sound_done = "bar_keyboard_finished",
		timer = 5
	}
	
	self.zm_hack4 = {
		zm_interaction = true,
		hack = true,
		text_id = "zm_secret_bunker_hack",
		action_text_id = "zm_hack",
		start_active = false,
		points_cost = 3000,
		sound_start = "bar_keyboard",
		sound_interupt = "bar_keyboard_cancel",
		sound_done = "bar_keyboard_finished",
		timer = 5
	}
	
	self.zm_car = {
		zm_interaction = true,
		key = true,
		text_id = "zm_car",
		action_text_id = "zm_car",
		start_active = false,
		points_cost = 30000,
		sound_start = "bar_cop_car",
		sound_interupt = "bar_cop_car_cancel",
		sound_done = "bar_cop_car_finished",
		timer = 5
	}
	
	self.zm_key = {
		text_id = "zm_key",
		action_text_id = "zm_keying",
		start_active = false,
		special_equipment = "keychain",
		equipment_text_id = "zm_no_key",
		sound_start = "bar_unlock_grate_door",
		sound_interupt = "bar_unlock_grate_door_cancel",
		sound_done = "bar_unlock_grate_door_finished",
		timer = 5
	}
	
	self.zm_gas = {
		text_id = "zm_gas",
		action_text_id = "zm_gassing",
		start_active = false,
		special_equipment = "gas",
		equipment_text_id = "zm_no_gas",
		equipment_consume = true,
		sound_start = "liquid_pour",
		sound_interupt = "liquid_pour_stop",
		sound_done = "liquid_pour_stop",
		timer = 10
	}

end)