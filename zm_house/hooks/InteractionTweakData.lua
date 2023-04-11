Hooks:PostHook(InteractionTweakData, "init", "int_zm_house_int", function(self, tweak_data)

	self.pick_lock_hard_no_skill.timer = 7
	

	self.muriatic_acid = {
		icon = "develop",
		text_id = "take_battery",
		start_active = false,
		interact_distance = 225,
		special_equipment_block = "acid"
	}
	self.caustic_soda = {
		icon = "develop",
		text_id = "take_body",
		start_active = false,
		interact_distance = 225,
		special_equipment_block = "caustic_soda"
	}
	self.hydrogen_chloride = {
		icon = "develop",
		text_id = "take_blade",
		start_active = false,
		interact_distance = 225,
		special_equipment_block = "hydrogen_chloride"
	}
	
	self.methlab_caustic_cooler = {
		icon = "develop",
		text_id = "add_body",
		equipment_text_id = "no_body",
		special_equipment = "caustic_soda",
		equipment_consume = true,
		start_active = false,
		timer = 1,
		action_text_id = "adding_part",
		sound_start = "bar_secure_winch",
		sound_interupt = "bar_secure_winch_cancel",
		sound_done = "bar_secure_winch_finished"
	}
	self.methlab_gas_to_salt = {
		icon = "develop",
		text_id = "add_blade",
		equipment_text_id = "no_blade",
		special_equipment = "hydrogen_chloride",
		equipment_consume = true,
		start_active = false,
		timer = 1,
		action_text_id = "adding_part",
		sound_start = "bar_secure_winch",
		sound_interupt = "bar_secure_winch_cancel",
		sound_done = "bar_secure_winch_finished"
	}
	self.methlab_bubbling = {
		icon = "develop",
		text_id = "add_battery",
		equipment_text_id = "no_battery",
		special_equipment = "acid",
		equipment_consume = true,
		start_active = false,
		timer = 1,
		action_text_id = "adding_part",
		sound_start = "bar_secure_winch",
		sound_interupt = "bar_secure_winch_cancel",
		sound_done = "bar_secure_winch_finished"
	}
	
	self.zm_car = {
		zm_interaction = true,
		key = true,
		text_id = "zm_car",
		action_text_id = "zm_car",
		start_active = false,
		points_cost = 50000,
		sound_start = "bar_unlock_grate_door",
		sound_interupt = "bar_unlock_grate_door_cancel",
		sound_done = "bar_unlock_grate_door_finished",
		timer = 5
	}

end)