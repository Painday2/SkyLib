Hooks:PostHook(BlackMarketTweakData, "_init_weapon_skins", "zm_init_new_weapon_camos", function(self)
    self.weapon_skins.pap1 = {
        name_id = "none",
		desc_id = "none",
		weapon_id = "none",
		rarity = "common",
		bonus = "spread_p1",
		reserve_quality = true,
		base_gradient =		"units/pd2_mod_zombies/skins/pap_1/base_gradient/base_pack-a-punch",
		pattern_gradient =	"units/pd2_mod_zombies/skins/pap_dm/pattern_gradient/patgra_pap_3_blue",
		pattern =			"units/pd2_mod_zombies/skins/pap_dm/pattern/i_mtl_p7_zm_ctl_packapunch_crystal_e",
		cubemap_pattern_control = Vector3(1, 1, 1)
	}
	self.weapon_skins.pap2 = {
        name_id = "none",
		desc_id = "none",
		weapon_id = "none",
		rarity = "common",
		bonus = "spread_p1",
		reserve_quality = true,
		base_gradient =		"units/pd2_mod_zombies/skins/pap_1/base_gradient/base_pack-a-punch",
		pattern_gradient =	"units/pd2_mod_zombies/skins/pap_dm/pattern_gradient/patgra_pap_3_yellow",
		pattern =			"units/pd2_mod_zombies/skins/pap_dm/pattern/i_mtl_p7_zm_ctl_packapunch_crystal_e",
		pattern_pos = 		Vector3(-0.00333852, 0, 0),
		pattern_tweak = 	Vector3(1, 0, 1),
		cubemap_pattern_control = Vector3(1, 1, 1)
	}
	self.weapon_skins.pap3 = {
        name_id = "none",
		desc_id = "none",
		weapon_id = "none",
		rarity = "common",
		bonus = "spread_p1",
		reserve_quality = true,
		base_gradient =		"units/pd2_mod_zombies/skins/pap_1/base_gradient/base_pack-a-punch",
		pattern_gradient =	"units/pd2_mod_zombies/skins/pap_dm/pattern_gradient/patgra_pap_3_cyan",
		pattern =			"units/pd2_mod_zombies/skins/pap_dm/pattern/i_mtl_p7_zm_ctl_packapunch_crystal_e",
		pattern_pos = 		Vector3(-0.00333852, 0, 0),
		pattern_tweak = 	Vector3(1, 0, 1),
		cubemap_pattern_control = Vector3(1, 1, 1)
	}
end)
