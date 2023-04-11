Hooks:PostHook(EquipmentsTweakData, "init", "init_zm_house", function(self)
	self.specials.acid = {
		sync_possession = true,
		icon = "saw_battery",
		transfer_quantity = 4,
		text_id = "hud_saw_battery"
	}
	self.specials.hydrogen_chloride  = {
		sync_possession = true,
		icon = "saw_blade",
		transfer_quantity = 4,
		text_id = "hud_saw_blade"
	}
	self.specials.caustic_soda = {
		sync_possession = true,
		icon = "saw_body",
		transfer_quantity = 4,
		text_id = "hud_saw_body"
	}
end)