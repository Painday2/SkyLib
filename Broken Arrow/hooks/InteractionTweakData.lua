Hooks:PostHook(InteractionTweakData, "init", "zm_init_new_interactions", function(self, tweak_data)
	self.pick_lock_hard_no_skill.timer = 7
    self.zm_wall_buy_m14 = {
		zm_interaction = true,
		weapon = "M308 Rifle",
		weapon_id = "new_m14",
		points_cost = 1350,
		stay_active = true,
		action_text_id = "zm_buy_weapon",
		start_active = false,
		sound_done = "bar_plant_breaching_charges",
		axis = "y",
		timer = 0.5
	}
	
	self.zm_wall_buy_random = {
		zm_interaction = true,
		weapon = "Randomizer",
		weapon_id = "g22c",
		points_cost = 1500,
		stay_active = false,
		action_text_id = "zm_buy_weapon",
		start_active = false,
		sound_done = "bar_plant_breaching_charges",
		axis = "y",
		timer = 0.5
	}

	self.zm_wall_buy_joceline = {
		zm_interaction = true,
		weapon = "Joceline Shotgun",
		weapon_id = "b682",
		points_cost = 500,
		stay_active = true,
		action_text_id = "zm_buy_weapon",
		start_active = false,
		sound_done = "bar_plant_breaching_charges",
		axis = "y",
		timer = 0.5
	}

	self.zm_wall_buy_r870 = {
		zm_interaction = true,
		weapon = "Reinfeld 880 Shotgun",
		weapon_id = "r870",
		points_cost = 1200,
		stay_active = true,
		action_text_id = "zm_buy_weapon",
		start_active = false,
		sound_done = "bar_plant_breaching_charges",
		axis = "y",
		timer = 0.5
	}

	self.zm_wall_buy_57 = {
		zm_interaction = true,
		weapon = "5/7 Pistol",
		weapon_id = "lemming",
		points_cost = 850,
		stay_active = true,
		action_text_id = "zm_buy_weapon",
		start_active = false,
		sound_done = "bar_plant_breaching_charges",
		axis = "y",
		timer = 0.5
	}

	self.zm_wall_buy_ump45 = {
		zm_interaction = true,
		weapon = "Jackal SMG",
		weapon_id = "schakal",
		points_cost = 1400,
		stay_active = true,
		action_text_id = "zm_buy_weapon",
		start_active = false,
		sound_done = "bar_plant_breaching_charges",
		axis = "y",
		timer = 0.5
	}

	self.zm_wall_buy_m37 = {
		zm_interaction = true,
		weapon = "GSPS Shotgun",
		weapon_id = "m37",
		points_cost = 1350,
		stay_active = true,
		action_text_id = "zm_buy_weapon",
		start_active = false,
		sound_done = "bar_plant_breaching_charges",
		axis = "y",
		timer = 0.5
	}

		self.zm_wall_buy_tec9 = {
		zm_interaction = true,
		weapon = "Blaster 9mm",
		weapon_id = "tec9",
		points_cost = 1250,
		stay_active = true,
		action_text_id = "zm_buy_weapon",
		start_active = false,
		sound_done = "bar_plant_breaching_charges",
		axis = "y",
		timer = 0.5
	}
	
	self.zm_wall_buy_mp9 = {
		zm_interaction = true,
		weapon = "MP9 Submachine Gun",
		weapon_id = "mp9",
		points_cost = 1000,
		stay_active = true,
		action_text_id = "zm_buy_weapon",
		start_active = false,
		sound_done = "bar_plant_breaching_charges",
		axis = "y",
		timer = 0.5
	}

	self.zm_wall_buy_ak47 = {
		zm_interaction = true,
		weapon = "AK Rifle",
		weapon_id = "ak74",
		points_cost = 1800,
		stay_active = true,
		action_text_id = "zm_buy_weapon",
		start_active = false,
		sound_done = "bar_plant_breaching_charges",
		axis = "y",
		timer = 0.5
	}
	
	self.zm_wall_buy_fal = {
		zm_interaction = true,
		weapon = "Falcon",
		weapon_id = "fal",
		points_cost = 1600,
		stay_active = true,
		action_text_id = "zm_buy_weapon",
		start_active = false,
		sound_done = "bar_plant_breaching_charges",
		axis = "y",
		timer = 0.5
	}
	
	self.zm_wall_buy_msr = {
		zm_interaction = true,
		weapon = "Galant Rifle",
		weapon_id = "ching",
		points_cost = 1350,
		stay_active = true,
		action_text_id = "zm_buy_weapon",
		start_active = false,
		sound_done = "bar_plant_breaching_charges",
		axis = "y",
		timer = 0.5,
	}

	self.zm_wall_buy_mp40 = {
		zm_interaction = true,
		weapon = "MP40 SMG",
		weapon_id = "erma",
		points_cost = 1300,
		stay_active = true,
		action_text_id = "zm_buy_weapon",
		start_active = false,
		sound_done = "bar_plant_breaching_charges",
		axis = "y",
		timer = 0.5,
	}

	self.zm_wall_buy_garand = {
		zm_interaction = true,
		weapon = "Nagant",
		weapon_id = "mosin",
		points_cost = 500,
		stay_active = true,
		action_text_id = "zm_buy_weapon",
		start_active = false,
		sound_done = "bar_plant_breaching_charges",
		axis = "y",
		timer = 0.5
	}

	self.zm_wall_buy_nades = {
		zm_interaction = true,
		weapon = "Grenades",
		grenade_spot = true,
		points_cost = 1000,
		stay_active = true,
		action_text_id = "zm_buy_weapon",
		start_active = false,
		sound_done = "bar_plant_breaching_charges",
		axis = "y",
		timer = 0.5,
	}

	self.zm_pack_a_punch = {
		zm_interaction = true,
		pack_a_punch = true,
		points_cost = 5000,
		stay_active = true,
		action_text_id = "zm_upgrade_weapon",
		start_active = false,
		sound_done = "bar_plant_breaching_charges",
		axis = "y",
		timer = 4,
	}
	
	self.zm_open_path_1500 = {
		zm_interaction = true,
		path = true,
		points_cost = 1500,
		action_text_id = "zm_opening_path",
		start_active = false,
		sound_done = "bar_unlock_grate_door",
		timer = 1.5,
	}
	
	self.zm_open_path_1250 = {
		zm_interaction = true,
		path = true,
		points_cost = 1250,
		action_text_id = "zm_opening_path",
		start_active = false,
		sound_done = "bar_take_watertank",
		timer = 1.5,
	}
	
	self.zm_open_path_750 = {
		zm_interaction = true,
		path = true,
		points_cost = 750,
		action_text_id = "zm_opening_path",
		start_active = false,
		sound_done = "und_limo_chassis_open",
		timer = 1.5,
	}
	
	self.zm_open_path_750_car = {
		zm_interaction = true,
		path = true,
		points_cost = 750,
		action_text_id = "zm_opening_path",
		start_active = false,
		interact_distance = 500,
		sound_done = "bar_unlock_grate_door",
		timer = 1.5,
	}
	
	self.zm_require_everyone = {
		text_id = "zm_req",
		action_text_id = "zm_buy_weapon",
		start_active = false,
		special_equipment = "zm_power_on",
		equipment_text_id = "zm_require_everyone_nearby",
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
	
	self.zm_power_start = {
		text_id = "zm_restart_power_start",
		action_text_id = "zm_power",
		start_active = false,
		timer = 5,
	}

	self.zm_open_path_1000 = {
		zm_interaction = true,
		path = true,
		points_cost = 1000,
		action_text_id = "zm_opening_path",
		start_active = false,
		sound_done = "und_limo_chassis_open",
		timer = 1.5,
	}

	self.zm_mystery_box = {
		zm_interaction = true,
		mystery_box = true,
		points_cost = 950,
		action_text_id = "zm_buy_weapon",
		start_active = false,
		sound_start = "bar_thermal_lance_fix",
		sound_interupt = "bar_thermal_lance_fix_cancel",
		axis = "y",
		timer = 4
	}

	self.zm_activate_song_invisible = {
		text_id = "zm_activate_song_invisible",
		action_text_id = "zm_buy_weapon",
		start_active = false,
		sound_done = "liquid_pour",
		interact_distance = 250
	}
	
	self.zm_invisible = {
		text_id = "zm_activate_song_invisible",
		action_text_id = "zm_buy_weapon",
		start_active = false,
		interact_distance = 250
	}
	
	self.zm_bottle = {
		text_id = "zm_activate_song_invisible",
		action_text_id = "zm_buy_weapon",
		start_active = false,
		interact_distance = 250,
		sound_done = "bar_c4_apply_cancel"
	}
	
	self.zm_authorization = {
		text_id = "zm_activate_song_invisible",
		action_text_id = "zm_grabbing_hand",
		start_active = false,
		sound_start = "bar_cut_off_arm",
		sound_interupt = "bar_cut_off_arm_cancel",
		sound_done = "bar_cut_off_arm_finished",
		interact_distance = 250,
		timer = 3
	}
	
	self.zm_computer_authorize = {
		text_id = "zm_authorize",
		action_text_id = "zm_authorizing",
		start_active = false,
		interact_distance = 250,
		sound_start = "bar_train_panel_hacking",
		sound_interupt = "bar_train_panel_hacking_cancel",
		sound_done = "bar_train_panel_hacking_finished",
		timer = 3
	}
	
	self.zm_place_crystal = {
		text_id = "zm_place_crystal",
		action_text_id = "zm_placing_crystal",
		start_active = false,
		sound_event = "money_grab",
	}
	
	self.zm_next_song = {
		text_id = "zm_next_song",
		action_text_id = "zm_music",
		start_active = false,
		sound_done = "bar_keyboard_cancel",
	}
	
	self.zm_restart_song = {
		text_id = "zm_restart_song",
		action_text_id = "zm_music",
		start_active = false,
		sound_done = "bar_keyboard_cancel",
	}
	
	self.zm_previous_song = {
		text_id = "zm_previous_song",
		action_text_id = "zm_music",
		start_active = false,
		sound_done = "bar_keyboard_cancel",
	}
	
	self.zm_power_req = { 
		text_id = "zm_teleporter",
		action_text_id = "zm_use_teleporter",
		start_active = false,
		special_equipment = "zm_power_on",
		equipment_text_id = "zm_no_power",
	}
	
	self.zm_require_all_crystals = { 
		text_id = "zm_teleporter",
		action_text_id = "zm_use_teleporter",
		start_active = false,
		special_equipment = "zm_power_on",
		equipment_text_id = "zm_require_all_crystals",
	}
	
	self.zm_security = { 
		text_id = "zm_teleporter",
		action_text_id = "zm_use_teleporter",
		start_active = false,
		special_equipment = "zm_power_on",
		equipment_text_id = "zm_security",
	}
	
	self.zm_return_round = { 
		text_id = "zm_teleporter",
		action_text_id = "zm_use_teleporter",
		start_active = false,
		special_equipment = "zm_power_on",
		equipment_text_id = "zm_return_round",
	}
	
	self.zm_grab_crystal = { 
		text_id = "zm_grab_crystal",
		action_text_id = "zm_grabing_part",
		start_active = false,
		sound_event = "money_grab",
	}
	
	
	self.zm_teleporter = {
		is_teleporter = true,
		text_id = "zm_teleporter",
		action_text_id = "zm_use_teleporter",
		start_active = false,
		timer = 1,
		interact_distance = 500
	}
	
	self.zm_teleporter_end = {
		is_teleporter = true,
		text_id = "zm_teleport_end",
		action_text_id = "zm_use_teleporter",
		start_active = false,
		timer = 1,
		interact_distance = 500
	}
	
	self.zm_teleport_back = {
		is_teleporter = true,
		text_id = "zm_teleporter_back",
		action_text_id = "zm_teleport_back",
		start_active = false,
		timer = 5,
		axis = "y"
	}

	self.zm_teleporter_dummy_reload = {
		text_id = "zm_teleporter_cooling_down",
		start_active = false,
		special_equipment = "zm_dummy_item",
		equipment_text_id = "zm_teleporter_cooling_down",
		interact_distance = 500
	}

	self.zm_perk_juggernog = {
		zm_interaction = true,
		points_cost = 2500,
		perk = "Juggernog",
		is_perk_interaction = true,
		action_text_id = "zm_buy_perk",
		start_active = false,
		axis = "y",
		timer = 3,		
		sound_done = "bar_c4_apply_cancel",
		special_equipment_block = "perk_juggernog"
	}

	self.zm_perk_speedcola = {
		zm_interaction = true,
		points_cost = 3000,
		perk = "Speed Cola",
		is_perk_interaction = true,
		action_text_id = "zm_buy_perk",
		start_active = false,
		axis = "y",
		timer = 3,	
		sound_done = "bar_c4_apply_cancel",
		special_equipment_block = "perk_speedcola"
	}

	self.zm_perk_doubletap = {
		zm_interaction = true,
		points_cost = 2000,
		perk = "Double Tap",
		is_perk_interaction = true,
		action_text_id = "zm_buy_perk",
		start_active = false,
		axis = "y",
		timer = 3,	
		sound_done = "bar_c4_apply_cancel",
		special_equipment_block = "perk_doubletap"
	}

	self.zm_perk_quickrevive = {
		zm_interaction = true,
		points_cost = 1500,
		perk = "Quick Revive",
		is_perk_interaction = true,
		action_text_id = "zm_buy_perk",
		start_active = false,
		axis = "y",
		timer = 3,
		sound_done = "bar_c4_apply_cancel",		
		special_equipment_block = "perk_quickrevive"
	}

	self.zm_perk_quickrevive_solo = {
		zm_interaction = true,
		points_cost = 500,
		perk = "Quick Revive",
		is_perk_interaction = true,
		action_text_id = "zm_buy_perk",
		start_active = false,
		axis = "y",
		timer = 3,
		sound_done = "bar_c4_apply_cancel",
		special_equipment_block = "perk_quickrevive"
	}

	self.zm_perk_deadshot = {
		zm_interaction = true,
		points_cost = 4000,
		perk = "Dead Shot",
		is_perk_interaction = true,
		action_text_id = "zm_buy_perk",
		start_active = false,
		axis = "y",
		timer = 3,	
		sound_done = "bar_c4_apply_cancel",
		special_equipment_block = "perk_deadshot"
	}

	self.zm_call_gunship = {
		zm_interaction = true,
		dyn_price_by_wave = true,
		dyn_price_base = 0,
		dyn_price_increase = 175,
		dyn_price_item_name = "Chopper Gunner",
		text_id = "zm_buy_gunship",
		start_active = false,
		timer = 3
	}

	self.zm_perk_stamin = {
		zm_interaction = true,
		points_cost = 3000,
		perk = "Stamin' Up",
		is_perk_interaction = true,
		action_text_id = "zm_buy_perk",
		start_active = false,
		axis = "y",
		timer = 3,	
		sound_done = "bar_c4_apply_cancel",
		special_equipment_block = "perk_staminup"
	}

	self.zm_point_giveaway_spot_1 = {
		zm_interaction = true,
		point_giveaway_spot = true,
		spot_nb = 1,
		points_cost = 0,
		stay_active = true,
		sound_done = "bar_plant_breaching_charges",
		start_active = false,
		axis = "y"
	}

	self.zm_point_giveaway_spot_2 = {
		zm_interaction = true,
		point_giveaway_spot = true,
		spot_nb = 2,
		stay_active = true,
		points_cost = 0,
		sound_done = "bar_plant_breaching_charges",
		start_active = false,
		axis = "y"
	}

	self.zm_point_giveaway_spot_3 = {
		zm_interaction = true,
		point_giveaway_spot = true,
		spot_nb = 3,
		stay_active = true,
		points_cost = 0,
		sound_done = "bar_plant_breaching_charges",
		start_active = false,
		axis = "y"
	}

	self.zm_point_giveaway_spot_4 = {
		zm_interaction = true,
		point_giveaway_spot = true,
		spot_nb = 4,
		stay_active = true,
		points_cost = 0,
		sound_done = "bar_plant_breaching_charges",
		start_active = false,
		axis = "y"
	}
end)