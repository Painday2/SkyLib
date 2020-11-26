Hooks:PostHook(HudIconsTweakData, "init", "init_zm_icons_gui", function(self)

	--PERK ICONS
	self.perk_deadshot = {
        texture = "units/pd2_mod_zombies/guis/perks/perk_sheet",
		texture_rect = {
			0,
			0,
			128,
			128
		}
	}
	self.perk_speedcola = {
        texture = "units/pd2_mod_zombies/guis/perks/perk_sheet",
		texture_rect = {
			128,
			0,
			128,
			128
		}
	}
    self.perk_juggernog = {
        texture = "units/pd2_mod_zombies/guis/perks/perk_sheet",
		texture_rect = {
			256,
			0,
			128,
			128
		}
	}
	self.perk_staminup = {
        texture = "units/pd2_mod_zombies/guis/perks/perk_sheet",
		texture_rect = {
			384,
			0,
			128,
			128
		}
	}
	self.perk_doubletap = {
        texture = "units/pd2_mod_zombies/guis/perks/perk_sheet",
		texture_rect = {
			0,
			128,
			128,
			128
		}
	}
	self.perk_quickrevive = {
        texture = "units/pd2_mod_zombies/guis/perks/perk_sheet",
		texture_rect = {
			128,
			128,
			128,
			128
		}
	}
	
	--Junk
	self.zm_power_on = {
        texture = "perks/power",
		texture_rect = {
			0,
			0,
			128,
			128
		}
    }
	self.perk_god = {
        texture = "units/pd2_mod_zombies/guis/perks/god_strength",
		texture_rect = {
			0,
			0,
			128,
			128
		}
    }
end)