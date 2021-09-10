SkyHook:Post(InteractionTweakData, "init", function(self, tweak_data)

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

    self.zm_wall_buy_ray = {
		zm_interaction = true,
		weapon = "Commando 101",
		weapon_id = "ray",
		points_cost = 9000,
		stay_active = true,
		action_text_id = "zm_buy_weapon",
		start_active = false,
		sound_done = "zm_gen_ching",
		axis = "y",
		timer = 0.5
	}

    self.zm_wall_buy_m14 = {
		zm_interaction = true,
		weapon = "M308 Rifle",
		weapon_id = "new_m14",
		points_cost = 1350,
		stay_active = true,
		action_text_id = "zm_buy_weapon",
		start_active = false,
		sound_done = "zm_gen_ching",
		axis = "y",
		timer = 0.5
	}

	self.zm_wall_buy_raygun = {
		zm_interaction = true,
		weapon = "Raygun",
		weapon_id = "raygun",
		points_cost = 5000,
		stay_active = true,
		action_text_id = "zm_buy_weapon",
		start_active = false,
		sound_done = "zm_gen_ching",
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
		sound_done = "zm_gen_ching",
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
		sound_done = "zm_gen_ching",
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
		sound_done = "zm_gen_ching",
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
		sound_done = "zm_gen_ching",
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
		sound_done = "zm_gen_ching",
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
		sound_done = "zm_gen_ching",
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
		sound_done = "zm_gen_ching",
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
		sound_done = "zm_gen_ching",
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
		sound_done = "zm_gen_ching",
		axis = "y",
		timer = 0.5
	}

	self.zm_wall_buy_mosin = {
		zm_interaction = true,
		weapon = "Nagant",
		weapon_id = "mosin",
		points_cost = 500,
		stay_active = true,
		action_text_id = "zm_buy_weapon",
		start_active = false,
		sound_done = "zm_gen_ching",
		axis = "y",
		timer = 0.5
	}

	self.zm_wall_buy_mp40 = {
		zm_interaction = true,
		weapon = "MP40 SMG",
		weapon_id = "erma",
		points_cost = 1300,
		stay_active = true,
		action_text_id = "zm_buy_weapon",
		start_active = false,
		sound_done = "zm_gen_ching",
		axis = "y",
		timer = 0.5,
	}

	self.zm_wall_buy_garand = {
		zm_interaction = true,
		weapon = "Galant Rifle",
		weapon_id = "ching",
		points_cost = 1350,
		stay_active = true,
		action_text_id = "zm_buy_weapon",
		start_active = false,
		sound_done = "zm_gen_ching",
		axis = "y",
		timer = 0.5,
	}

	self.zm_wall_buy_box_ray = {
        zm_interaction = true,
        box_weapon = "Commando 101",
        weapon_id = "ray",
        points_cost = 0,
        stay_active = false,
        action_text_id = "zm_buy_weapon",
        start_active = false,
        sound_done = "zm_gen_ching",
        axis = "y",
        timer = 0.5
    }

	self.zm_wall_buy_box_deamon = {
        zm_interaction = true,
        box_weapon = "Breaker 12G",
        weapon_id = "boot",
        points_cost = 0,
        box_box_weapon = true,
        stay_active = false,
        action_text_id = "zm_buy_weapon",
        start_active = false,
        sound_done = "zm_gen_ching",
        axis = "y",
        timer = 0.5
    }

    self.zm_wall_buy_box_m14 = {
        zm_interaction = true,
        box_weapon = "M308 Rifle",
        weapon_id = "new_m14",
        points_cost = 0,
        stay_active = false,
        action_text_id = "zm_buy_weapon",
        start_active = false,
        sound_done = "zm_gen_ching",
        axis = "y",
        timer = 0.5
    }

    self.zm_wall_buy_box_raygun = {
        zm_interaction = true,
        box_weapon = "Raygun",
        weapon_id = "raygun",
        points_cost = 0,
        stay_active = false,
        action_text_id = "zm_buy_weapon",
        start_active = false,
        sound_done = "zm_gen_ching",
        axis = "y",
        timer = 0.5
    }

    self.zm_wall_buy_box_joceline = {
        zm_interaction = true,
        box_weapon = "Joceline Shotgun",
        weapon_id = "b682",
        points_cost = 0,
        stay_active = false,
        action_text_id = "zm_buy_weapon",
        start_active = false,
        sound_done = "zm_gen_ching",
        axis = "y",
        timer = 0.5
    }

    self.zm_wall_buy_box_r870 = {
        zm_interaction = true,
        box_weapon = "Reinfeld 880 Shotgun",
        weapon_id = "r870",
        points_cost = 0,
        stay_active = false,
        action_text_id = "zm_buy_weapon",
        start_active = false,
        sound_done = "zm_gen_ching",
        axis = "y",
        timer = 0.5
    }

    self.zm_wall_buy_box_57 = {
        zm_interaction = true,
        box_weapon = "5/7 Pistol",
        weapon_id = "lemming",
        points_cost = 0,
        stay_active = false,
        action_text_id = "zm_buy_weapon",
        start_active = false,
        sound_done = "zm_gen_ching",
        axis = "y",
        timer = 0.5
    }

    self.zm_wall_buy_box_ump45 = {
        zm_interaction = true,
        box_weapon = "Jackal SMG",
        weapon_id = "schakal",
        points_cost = 0,
        stay_active = false,
        action_text_id = "zm_buy_weapon",
        start_active = false,
        sound_done = "zm_gen_ching",
        axis = "y",
        timer = 0.5
    }

    self.zm_wall_buy_box_m37 = {
        zm_interaction = true,
        box_weapon = "GSPS Shotgun",
        weapon_id = "m37",
        points_cost = 0,
        stay_active = false,
        action_text_id = "zm_buy_weapon",
        start_active = false,
        sound_done = "zm_gen_ching",
        axis = "y",
        timer = 0.5
    }

        self.zm_wall_buy_box_tec9 = {
        zm_interaction = true,
        box_weapon = "Blaster 9mm",
        weapon_id = "tec9",
        points_cost = 0,
        stay_active = false,
        action_text_id = "zm_buy_weapon",
        start_active = false,
        sound_done = "zm_gen_ching",
        axis = "y",
        timer = 0.5
    }

    self.zm_wall_buy_box_mp9 = {
        zm_interaction = true,
        box_weapon = "MP9 Submachine Gun",
        weapon_id = "mp9",
        points_cost = 0,
        stay_active = false,
        action_text_id = "zm_buy_weapon",
        start_active = false,
        sound_done = "zm_gen_ching",
        axis = "y",
        timer = 0.5
    }

    self.zm_wall_buy_box_ak47 = {
        zm_interaction = true,
        box_weapon = "AK Rifle",
        weapon_id = "ak74",
        points_cost = 0,
        stay_active = false,
        action_text_id = "zm_buy_weapon",
        start_active = false,
        sound_done = "zm_gen_ching",
        axis = "y",
        timer = 0.5
    }

    self.zm_wall_buy_box_fal = {
        zm_interaction = true,
        box_weapon = "Falcon",
        weapon_id = "fal",
        points_cost = 0,
        stay_active = false,
        action_text_id = "zm_buy_weapon",
        start_active = false,
        sound_done = "zm_gen_ching",
        axis = "y",
        timer = 0.5
    }

    self.zm_wall_buy_box_mosin = {
        zm_interaction = true,
        box_weapon = "Nagant",
        weapon_id = "mosin",
        points_cost = 0,
        stay_active = false,
        action_text_id = "zm_buy_weapon",
        start_active = false,
        sound_done = "zm_gen_ching",
        axis = "y",
        timer = 0.5
    }

    self.zm_wall_buy_box_mp40 = {
        zm_interaction = true,
        box_weapon = "MP40 SMG",
        weapon_id = "erma",
        points_cost = 0,
        stay_active = false,
        action_text_id = "zm_buy_weapon",
        start_active = false,
        sound_done = "zm_gen_ching",
        axis = "y",
        timer = 0.5,
    }

    self.zm_wall_buy_box_garand = {
        zm_interaction = true,
        box_weapon = "Galant Rifle",
        weapon_id = "ching",
        points_cost = 0,
        stay_active = false,
        action_text_id = "zm_buy_weapon",
        start_active = false,
        sound_done = "zm_gen_ching",
        axis = "y",
        timer = 0.5,
    }

    self.zm_wall_buy_box_1911 = {
        zm_interaction = true,
        box_weapon = "Colt 1911",
        weapon_id = "col_1911",
        points_cost = 0,
        stay_active = false,
        action_text_id = "zm_buy_weapon",
        start_active = false,
        sound_done = "zm_gen_ching",
        axis = "y",
        timer = 0.5,
    }

    self.zm_wall_buy_box_amcar = {
        zm_interaction = true,
        box_weapon = "Amcar",
        weapon_id = "amcar",
        points_cost = 0,
        stay_active = false,
        action_text_id = "zm_buy_weapon",
        start_active = false,
        sound_done = "zm_gen_ching",
        axis = "y",
        timer = 0.5,
    }

    self.zm_wall_buy_box_aug = {
        zm_interaction = true,
        box_weapon = "UAR",
        weapon_id = "aug",
        points_cost = 0,
        stay_active = false,
        action_text_id = "zm_buy_weapon",
        start_active = false,
        sound_done = "zm_gen_ching",
        axis = "y",
        timer = 0.5,
    }

    self.zm_wall_buy_box_breech = {
        zm_interaction = true,
        box_weapon = "Parabellum",
        weapon_id = "breech",
        points_cost = 0,
        stay_active = false,
        action_text_id = "zm_buy_weapon",
        start_active = false,
        sound_done = "zm_gen_ching",
        axis = "y",
        timer = 0.5,
    }

    self.zm_wall_buy_box_deagle = {
        zm_interaction = true,
        box_weapon = "Deagle",
        weapon_id = "deagle",
        points_cost = 0,
        stay_active = false,
        action_text_id = "zm_buy_weapon",
        start_active = false,
        sound_done = "zm_gen_ching",
        axis = "y",
        timer = 0.5,
    }

    self.zm_wall_buy_box_flint = {
        zm_interaction = true,
        box_weapon = "AK17",
        weapon_id = "flint",
        points_cost = 0,
        stay_active = false,
        action_text_id = "zm_buy_weapon",
        start_active = false,
        sound_done = "zm_gen_ching",
        axis = "y",
        timer = 0.5,
    }

    self.zm_wall_buy_box_g3 = {
        zm_interaction = true,
        box_weapon = "Gewehr 3",
        weapon_id = "g3",
        points_cost = 0,
        stay_active = false,
        action_text_id = "zm_buy_weapon",
        start_active = false,
        sound_done = "zm_gen_ching",
        axis = "y",
        timer = 0.5,
    }

    self.zm_wall_buy_box_g22c = {
        zm_interaction = true,
        box_weapon = "Chimano Custom",
        weapon_id = "g22c",
        points_cost = 0,
        stay_active = false,
        action_text_id = "zm_buy_weapon",
        start_active = false,
        sound_done = "zm_gen_ching",
        axis = "y",
        timer = 0.5,
    }

    self.zm_wall_buy_box_hk21 = {
        zm_interaction = true,
        box_weapon = "Brenner 21",
        weapon_id = "hk21",
        points_cost = 0,
        stay_active = false,
        action_text_id = "zm_buy_weapon",
        start_active = false,
        sound_done = "zm_gen_ching",
        axis = "y",
        timer = 0.5,
    }

    self.zm_wall_buy_box_judge = {
        zm_interaction = true,
        box_weapon = "Judge",
        weapon_id = "judge",
        points_cost = 0,
        stay_active = false,
        action_text_id = "zm_buy_weapon",
        start_active = false,
        sound_done = "zm_gen_ching",
        axis = "y",
        timer = 0.5,
    }

    self.zm_wall_buy_box_m16 = {
        zm_interaction = true,
        box_weapon = "AMR-16",
        weapon_id = "m16",
        points_cost = 0,
        stay_active = false,
        action_text_id = "zm_buy_weapon",
        start_active = false,
        sound_done = "zm_gen_ching",
        axis = "y",
        timer = 0.5,
    }

    self.zm_wall_buy_box_m95 = {
        zm_interaction = true,
        box_weapon = "Thanatos .50 cal",
        weapon_id = "m95",
        points_cost = 0,
        stay_active = false,
        action_text_id = "zm_buy_weapon",
        start_active = false,
        sound_done = "zm_gen_ching",
        axis = "y",
        timer = 0.5,
    }

    self.zm_wall_buy_box_m249 = {
        zm_interaction = true,
        box_weapon = "KSP",
        weapon_id = "m249",
        points_cost = 0,
        stay_active = false,
        action_text_id = "zm_buy_weapon",
        start_active = false,
        sound_done = "zm_gen_ching",
        axis = "y",
        timer = 0.5,
    }

    self.zm_wall_buy_box_p90 = {
        zm_interaction = true,
        box_weapon = "Kobus 90",
        weapon_id = "p90",
        points_cost = 0,
        stay_active = false,
        action_text_id = "zm_buy_weapon",
        start_active = false,
        sound_done = "zm_gen_ching",
        axis = "y",
        timer = 0.5,
    }

    self.zm_wall_buy_box_packrat = {
        zm_interaction = true,
        box_weapon = "Contractor",
        weapon_id = "packrat",
        points_cost = 0,
        stay_active = false,
        action_text_id = "zm_buy_weapon",
        start_active = false,
        sound_done = "zm_gen_ching",
        axis = "y",
        timer = 0.5,
    }

    self.zm_wall_buy_box_par = {
        zm_interaction = true,
        box_weapon = "KSP 58",
        weapon_id = "par",
        points_cost = 0,
        stay_active = false,
        action_text_id = "zm_buy_weapon",
        start_active = false,
        sound_done = "zm_gen_ching",
        axis = "y",
        timer = 0.5,
    }

    self.zm_wall_buy_box_rage = {
        zm_interaction = true,
        box_weapon = "Bronco .44",
        weapon_id = "new_raging_bull",
        points_cost = 0,
        stay_active = false,
        action_text_id = "zm_buy_weapon",
        start_active = false,
        sound_done = "zm_gen_ching",
        axis = "y",
        timer = 0.5,
    }

    self.zm_wall_buy_box_rpg7 = {
        zm_interaction = true,
        box_weapon = "HRL-7",
        weapon_id = "rpg7",
        points_cost = 0,
        stay_active = false,
        action_text_id = "zm_buy_weapon",
        start_active = false,
        sound_done = "zm_gen_ching",
        axis = "y",
        timer = 0.5,
    }

    self.zm_wall_buy_box_scar = {
        zm_interaction = true,
        box_weapon = "Eagle Heavy",
        weapon_id = "scar",
        points_cost = 0,
        stay_active = false,
        action_text_id = "zm_buy_weapon",
        start_active = false,
        sound_done = "zm_gen_ching",
        axis = "y",
        timer = 0.5,
    }

    self.zm_wall_buy_box_tar21 = {
        zm_interaction = true,
        box_weapon = "Tempest 21",
        weapon_id = "komodo",
        points_cost = 0,
        stay_active = false,
        action_text_id = "zm_buy_weapon",
        start_active = false,
        sound_done = "zm_gen_ching",
        axis = "y",
        timer = 0.5,
    }

    self.zm_wall_buy_box_thompson = {
        zm_interaction = true,
        box_weapon = "Chicago Typewriter",
        weapon_id = "m1928",
        points_cost = 0,
        stay_active = false,
        action_text_id = "zm_buy_weapon",
        start_active = false,
        sound_done = "zm_gen_ching",
        axis = "y",
        timer = 0.5,
    }

    self.zm_wall_buy_box_wunderwaffe = {
        zm_interaction = true,
        box_weapon = "wunderwaffe DG-2",
        weapon_id = "wunderwaffe",
        points_cost = 0,
        stay_active = false,
        action_text_id = "zm_buy_weapon",
        start_active = false,
        sound_done = "zm_gen_ching",
        axis = "y",
        timer = 0.5,
    }

    self.zm_wall_buy_box_striker = {
        zm_interaction = true,
        box_weapon = "Street Sweeper",
        weapon_id = "striker",
        points_cost = 0,
        stay_active = false,
        action_text_id = "zm_buy_weapon",
        start_active = false,
        sound_done = "zm_gen_ching",
        axis = "y",
        timer = 0.5,
    }

	self.zm_wall_buy_nades = {
		zm_interaction = true,
		weapon = "Grenades",
		grenade_spot = true,
		points_cost = 1000,
		stay_active = true,
		action_text_id = "zm_buy_weapon",
		start_active = false,
		sound_done = "zm_gen_ching",
		axis = "y",
		timer = 0.5,
	}

	self.zm_pack_a_punch = {
		zm_interaction = true,
		pack_a_punch = true,
		points_cost = 5000,
		action_text_id = "zm_upgrade_weapon",
		start_active = false,
		sound_done = "zm_gen_ching",
		axis = "y",
		timer = 4,
	}

	self.zm_open_path_1500 = {
		zm_interaction = true,
		path = true,
		points_cost = 1500,
		action_text_id = "zm_opening_path",
		start_active = false,
		sound_done = "zm_gen_door_bought1",
		timer = 1.5,
	}

	self.zm_open_path_1250 = {
		zm_interaction = true,
		path = true,
		points_cost = 1250,
		action_text_id = "zm_opening_path",
		start_active = false,
		sound_done = "zm_gen_door_bought2",
		timer = 1.5,
	}

	self.zm_open_path_750 = {
		zm_interaction = true,
		path = true,
		points_cost = 750,
		action_text_id = "zm_opening_path",
		start_active = false,
		sound_done = "zm_gen_door_bought3",
		timer = 1.5,
	}

	self.zm_open_path_1000 = {
		zm_interaction = true,
		path = true,
		points_cost = 1000,
		action_text_id = "zm_opening_path",
		start_active = false,
		sound_done = "zm_gen_door_bought2",
		timer = 1.5,
	}

	self.zm_mystery_box = {
		zm_interaction = true,
		mystery_box = true,
		points_cost = 950,
		action_text_id = "zm_buy_weapon",
		start_active = false,
        --TODO: fix this by rotating the interact point 180 in model
		--axis = "y",
		timer = 0.5
	}

	self.zm_activate_song_invisible = {
		text_id = "zm_activate_song_invisible",
		action_text_id = "zm_buy_weapon",
		start_active = false,
		sound_done = "zm_gen_magic_interact",
		interact_distance = 250
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

    self.zm_power_req = { 
		text_id = "zm_teleporter",
		action_text_id = "zm_use_teleporter",
		start_active = false,
		special_equipment = "zm_power_on",
		equipment_text_id = "zm_no_power",
	}

    self.zm_take_weapon = {
        zm_interaction = true,
        box_weapon = true,
        points_cost = 0,
        stay_active = false,
        action_text_id = "zm_buy_weapon",
        start_active = false,
        sound_done = "zm_gen_ching",
        timer = 0.5
    }

    self.zm_wallbuy = {
        zm_interaction = true,
        wallbuy = true,
        stay_active = true,
        action_text_id = "zm_buy_weapon",
        start_active = true,
        sound_done = "zm_gen_ching",
        timer = 0.5
    }

    self.zm_tradepoint = {
        zm_interaction = true,
        stay_active = true,
        action_text_id = "zm_buy_weapon",
        start_active = true,
        timer = 0
    }

    self.zm_perk_juggernog = {
		zm_interaction = true,
		points_cost = 2500,
		perk = "Juggernog",
		is_perk_interaction = true,
		action_text_id = "zm_buy_perk",
		start_active = false,
		axis = "y",
		timer = 0.5,
		sound_done = "zm_perk_bought",
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
		timer = 0.5,
		sound_done = "zm_perk_bought",
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
		timer = 0.5,
		sound_done = "zm_perk_bought",
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
		timer = 0.5,
		sound_done = "zm_perk_bought",
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
		timer = 0.5,
		sound_done = "zm_perk_bought",
		special_equipment_block = "perk_quickrevive"
	}

	self.zm_perk_deadshot = {
		zm_interaction = true,
		points_cost = 4000,
		perk = "Dead Shot",
		is_perk_interaction = true,
		action_text_id = "zm_buy_perk",
		start_active = false,
		axis = "z",
		interact_distance = 350,
		timer = 0.5,
		sound_done = "zm_perk_bought",
		special_equipment_block = "perk_deadshot"
	}

	self.zm_perk_stamin = {
		zm_interaction = true,
		points_cost = 3000,
		perk = "Stamin' Up",
		is_perk_interaction = true,
		action_text_id = "zm_buy_perk",
		start_active = false,
		axis = "z",
		timer = 0.5,	
		sound_done = "zm_perk_bought",
		special_equipment_block = "perk_staminup"
	}

    self.zm_perk_flopper = {
		zm_interaction = true,
		points_cost = 2500,
		perk = "PhD Flopper",
		is_perk_interaction = true,
		action_text_id = "zm_buy_perk",
		start_active = false,
		axis = "z",
		timer = 0.5,
		sound_done = "zm_perk_bought",
		special_equipment_block = "perk_flopper"
	}

    self.zm_perk_cherry = {
		zm_interaction = true,
		points_cost = 2000,
		perk = "Electric Cherry",
		is_perk_interaction = true,
		action_text_id = "zm_buy_perk",
		start_active = false,
		axis = "z",
		timer = 0.5,
		sound_done = "zm_perk_bought",
		special_equipment_block = "perk_cherry"
	}

    self.zm_perk_vulture = {
		zm_interaction = true,
		points_cost = 3000,
		perk = "Vulture Aid",
		is_perk_interaction = true,
		action_text_id = "zm_buy_perk",
		start_active = false,
		axis = "z",
		timer = 0.5,
		sound_done = "zm_perk_bought",
		special_equipment_block = "perk_vulture"
	}

    self.zm_perk_widows = {
		zm_interaction = true,
		points_cost = 2000,
		perk = "Widow's Wine",
		is_perk_interaction = true,
		action_text_id = "zm_buy_perk",
		start_active = false,
		axis = "z",
		timer = 0.5,
		sound_done = "zm_perk_bought",
		special_equipment_block = "perk_widows"
	}

    self.zm_perk_armor = {
		zm_interaction = true,
		points_cost = 2500,
		perk = "Unnamed Armor Perk",
		is_perk_interaction = true,
		action_text_id = "zm_buy_perk",
		start_active = false,
		axis = "z",
		timer = 0.5,
		sound_done = "zm_perk_bought",
		special_equipment_block = "perk_armor"
	}
end)
--hooks gets set too late, need to reinit
tweak_data.interaction:init(tweak_data)