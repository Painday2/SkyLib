Hooks:PostHook(WeaponFactoryTweakData, "init", "zm_init_weapon_data_factory", function(self)
	self:_init_pap_parts()
end)

function WeaponFactoryTweakData:_assemble_random_blueprint(factory_id, weapon_category)
	local tweak = self[factory_id]
	local blueprint = {}
	local required_types = {}
	for _, part in pairs(tweak.default_blueprint) do
		local part_tweak = self.parts[part]
		table.insert(required_types, part_tweak.type)
	end
    local allowed_parts = self.pap_parts[weapon_category]
	local available_parts = {}
	local available_parts_count = 0
	local part_types = {}
	for _, part in pairs(tweak.uses_parts) do
		if table.contains(allowed_parts, part) or table.contains(tweak.default_blueprint, part) then
			local part_tweak = self.parts[part]
			local type = part_tweak.type
			if available_parts[type] then
				table.insert(available_parts[type], part)
			else
				available_parts[type] = {part}
				table.insert(part_types, type)
            end
            available_parts_count = available_parts_count+1
		end
	end

	local ran_count = math.random(0,5)
	local part_count = #required_types + math.min(ran_count, #part_types - #required_types)
	local forbidden_parts = {}
	function add_part(part, type, size)
		if not table.contains(forbidden_parts, part) then
			if self.parts[part].forbids then
				for _, i in pairs(self.parts[part].forbids) do
					table.insert(forbidden_parts, i)
				end
			end
			table.insert(blueprint, part)
			local i = 0
			for k,v in pairs(part_types) do
				if v == type then
					i = k
				end
			end
			table.remove(part_types, i)
			available_parts_count = available_parts_count - size
			available_parts[type] = nil
		end
    end
	local tries = part_count * 2
	while available_parts_count > 0 and #blueprint < part_count do
		if #required_types > 0 then
			local required_type = required_types[1]
			local part_table = available_parts[required_type]
			if part_table then
				local index = #part_table > 1 and math.random(1, #part_table ) or 1
				local part = part_table[index]
				add_part(part, required_type, #part_table)
			end
			table.remove(required_types, 1)
		else
			local type_index = #part_types > 1 and math.random(1, #part_types ) or 1
			local type = part_types[type_index]
			local part_table = available_parts[type]
			local index = #part_table > 1 and math.random(1, #part_table ) or 1
			local part = part_table[index]
			add_part(part, type, #part_table)
		end
		if tries > 0 then
			tries = tries - 1
		else
			return managers.weapon_factory:get_default_blueprint_by_factory_id(factory_id)
		end
	end
	if not blueprint then
		blueprint = managers.weapon_factory:get_default_blueprint_by_factory_id(factory_id)
    end
	return blueprint
end

function WeaponFactoryTweakData:_init_pap_parts()
    self.pap_parts = {
        assault_rifle = {
            "wpn_fps_lmg_hk21_g_standard",
			"wpn_fps_lmg_hk21_s_standard",
			"wpn_fps_upg_i_singlefire",
			"wpn_fps_upg_i_autofire",
			"wpn_fps_upg_o_specter",
			"wpn_fps_upg_o_aimpoint",
			"wpn_fps_upg_o_docter",
			"wpn_fps_upg_o_eotech",
			"wpn_fps_upg_o_t1micro",
			"wpn_fps_upg_o_cmore",
			"wpn_fps_upg_o_aimpoint_2",
			"wpn_fps_upg_o_acog",
			"wpn_fps_upg_fl_ass_smg_sho_peqbox",
			"wpn_fps_upg_fl_ass_smg_sho_surefire",
			"wpn_fps_upg_ns_ass_smg_large",
			"wpn_fps_upg_ns_ass_smg_medium",
			"wpn_fps_upg_ns_ass_smg_small",
			"wpn_fps_upg_ns_ass_smg_firepig",
			"wpn_fps_upg_ns_ass_smg_stubby",
			"wpn_fps_upg_ns_ass_smg_tank",
			"wpn_fps_upg_o_eotech_xps",
			"wpn_fps_upg_o_reflex",
			"wpn_fps_upg_o_rx01",
			"wpn_fps_upg_o_rx30",
			"wpn_fps_upg_o_cs",
			"wpn_fps_upg_ass_ns_jprifles",
			"wpn_fps_upg_ass_ns_linear",
			"wpn_fps_upg_ass_ns_surefire",
			"wpn_fps_upg_fl_ass_peq15",
			"wpn_fps_upg_fl_ass_laser",
			"wpn_fps_upg_ass_ns_battle",
			"wpn_fps_upg_fl_ass_utg",
			"wpn_fps_upg_o_45rds",
			"wpn_fps_upg_o_spot",
			"wpn_fps_upg_o_xpsg33_magnifier",
			"wpn_fps_upg_o_45rds_v2",
			"wpn_fps_upg_ns_ass_smg_v6",
			"wpn_fps_upg_o_sig",
			"wpn_fps_upg_o_bmg",
			"wpn_fps_upg_o_uh",
			"wpn_fps_upg_o_fc1",
			"wpn_fps_upg_o_45steel"
        },
        smg = {
            "wpn_fps_upg_m4_s_standard",
			"wpn_fps_upg_m4_s_pts",
			"wpn_fps_upg_m4_s_crane",
			"wpn_fps_upg_m4_s_mk46",
			"wpn_fps_upg_ns_ass_smg_large",
			"wpn_fps_upg_ns_ass_smg_medium",
			"wpn_fps_upg_ns_ass_smg_small",
			"wpn_fps_upg_ns_ass_smg_firepig",
			"wpn_fps_upg_ns_ass_smg_stubby",
			"wpn_fps_upg_ns_ass_smg_tank",
			"wpn_fps_upg_fl_ass_smg_sho_peqbox",
			"wpn_fps_upg_fl_ass_smg_sho_surefire",
			"wpn_fps_upg_vg_ass_smg_verticalgrip",
			"wpn_fps_upg_vg_ass_smg_stubby",
			"wpn_fps_upg_vg_ass_smg_afg",
			"wpn_fps_upg_i_singlefire",
			"wpn_fps_upg_i_autofire",
			"wpn_fps_upg_ass_ns_jprifles",
			"wpn_fps_upg_ass_ns_linear",
			"wpn_fps_upg_ass_ns_surefire",
			"wpn_fps_upg_fl_ass_peq15",
			"wpn_fps_upg_fl_ass_laser",
			"wpn_fps_upg_o_specter",
			"wpn_fps_upg_o_aimpoint",
			"wpn_fps_upg_o_docter",
			"wpn_fps_upg_o_eotech",
			"wpn_fps_upg_o_t1micro",
			"wpn_fps_upg_o_cmore",
			"wpn_fps_upg_o_aimpoint_2",
			"wpn_fps_upg_o_eotech_xps",
			"wpn_fps_upg_o_reflex",
			"wpn_fps_upg_o_rx01",
			"wpn_fps_upg_o_rx30",
			"wpn_fps_upg_o_cs",
			"wpn_fps_upg_m4_s_ubr",
			"wpn_fps_upg_ass_ns_battle",
			"wpn_fps_upg_fl_ass_utg",
			"wpn_fps_upg_o_spot",
			"wpn_fps_snp_tti_s_vltor",
			"wpn_fps_upg_ns_ass_smg_v6",
			"wpn_fps_upg_o_uh",
			"wpn_fps_upg_o_fc1"
        },
        pistol = {
            "wpn_fps_upg_o_rmr",
			"wpn_fps_upg_fl_pis_laser",
			"wpn_fps_upg_fl_pis_tlr1",
			"wpn_fps_upg_fl_pis_x400v",
			"wpn_fps_upg_fl_pis_m3x",
			"wpn_fps_upg_fl_pis_crimson",
			"wpn_fps_upg_ns_ass_filter",
			"wpn_fps_upg_ns_pis_jungle",
			"wpn_fps_upg_ns_pis_ipsccomp",
			"wpn_fps_upg_ns_pis_meatgrinder",
			"wpn_fps_upg_ns_pis_medium_slim",
			"wpn_fps_upg_pis_ns_flash",
			"wpn_fps_upg_ns_pis_large",
			"wpn_fps_upg_ns_pis_medium",
			"wpn_fps_upg_ns_pis_small",
			"wpn_fps_upg_ns_pis_large_kac",
			"wpn_fps_upg_ns_pis_medium_gem",
			"wpn_fps_upg_o_rms",
			"wpn_fps_upg_o_rikt",
			"wpn_fps_upg_ns_pis_typhoon"
        },
        shotgun = {
			"wpn_fps_upg_o_specter",
			"wpn_fps_upg_o_aimpoint",
			"wpn_fps_upg_o_docter",
			"wpn_fps_upg_o_eotech",
			"wpn_fps_upg_o_t1micro",
			"wpn_fps_upg_o_cmore",
			"wpn_fps_upg_fl_ass_smg_sho_peqbox",
			"wpn_fps_upg_fl_ass_smg_sho_surefire",
			"wpn_fps_upg_o_aimpoint_2",
			"wpn_fps_upg_o_acog",
			"wpn_fps_upg_ns_shot_thick",
			"wpn_fps_upg_ns_shot_shark",
			"wpn_fps_upg_shot_ns_king",
			"wpn_fps_upg_fl_ass_peq15",
			"wpn_fps_upg_fl_ass_laser",
			"wpn_fps_upg_o_eotech_xps",
			"wpn_fps_upg_o_reflex",
			"wpn_fps_upg_o_rx01",
			"wpn_fps_upg_o_rx30",
			"wpn_fps_upg_o_cs",
			"wpn_fps_upg_fl_ass_utg",
			"wpn_fps_upg_ns_sho_salvo_large",
			"wpn_fps_upg_o_spot",
			"wpn_fps_upg_ns_duck",
			"wpn_fps_upg_o_xpsg33_magnifier",
			"wpn_fps_upg_o_sig",
			"wpn_fps_upg_o_bmg",
			"wpn_fps_upg_o_uh",
			"wpn_fps_upg_o_fc1"
        },
        snp = {
            "wpn_fps_upg_o_specter",
			"wpn_fps_upg_o_aimpoint",
			"wpn_fps_upg_o_docter",
			"wpn_fps_upg_o_eotech",
			"wpn_fps_upg_o_t1micro",
			"wpn_fps_upg_o_rx30",
			"wpn_fps_upg_o_rx01",
			"wpn_fps_upg_o_reflex",
			"wpn_fps_upg_o_eotech_xps",
			"wpn_fps_upg_o_cmore",
			"wpn_fps_upg_o_aimpoint_2",
			"wpn_fps_upg_o_acog",
			"wpn_fps_upg_o_cs",
			"wpn_fps_upg_o_shortdot",
			"wpn_fps_upg_o_leupold",
			"wpn_fps_upg_o_45iron",
			"wpn_fps_upg_fl_ass_smg_sho_peqbox",
			"wpn_fps_upg_fl_ass_smg_sho_surefire",
			"wpn_fps_upg_fl_ass_peq15",
			"wpn_fps_upg_fl_ass_laser",
			"wpn_fps_snp_mosin_ns_bayonet",
			"wpn_fps_upg_fl_ass_utg",
			"wpn_fps_upg_o_spot",
			"wpn_fps_upg_o_box",
			"wpn_fps_upg_o_45rds",
			"wpn_fps_upg_o_xpsg33_magnifier",
			"wpn_fps_upg_o_45rds_v2",
			"wpn_fps_upg_o_sig",
			"wpn_fps_upg_o_bmg",
			"wpn_fps_upg_o_uh",
			"wpn_fps_upg_o_fc1",
			"wpn_fps_upg_o_45steel"
        },
        grenade_launcher = {
            "wpn_fps_gre_m79_grenade",
			"wpn_fps_upg_o_specter",
			"wpn_fps_upg_o_aimpoint",
			"wpn_fps_upg_o_docter",
			"wpn_fps_upg_o_eotech",
			"wpn_fps_upg_o_t1micro",
			"wpn_fps_upg_o_cmore",
			"wpn_fps_upg_o_aimpoint_2",
			"wpn_fps_upg_o_acog",
			"wpn_fps_upg_fl_ass_smg_sho_peqbox",
			"wpn_fps_upg_fl_ass_smg_sho_surefire",
			"wpn_fps_upg_o_eotech_xps",
			"wpn_fps_upg_o_reflex",
			"wpn_fps_upg_o_rx01",
			"wpn_fps_upg_o_rx30",
			"wpn_fps_upg_o_cs",
			"wpn_fps_upg_fl_ass_peq15",
			"wpn_fps_upg_fl_ass_laser",
			"wpn_fps_upg_fl_ass_utg",
			"wpn_fps_upg_o_spot",
			"wpn_fps_upg_o_bmg",
			"wpn_fps_upg_o_uh",
			"wpn_fps_upg_o_fc1"

        },
        lmg = {
            "wpn_fps_lmg_mg42_n42",
			"wpn_fps_lmg_mg42_n34",
			"wpn_fps_upg_ns_ass_smg_firepig",
			"wpn_fps_upg_ns_ass_smg_stubby",
			"wpn_fps_upg_ns_ass_smg_tank",
			"wpn_fps_upg_ns_ass_smg_large",
			"wpn_fps_upg_ns_ass_smg_medium",
			"wpn_fps_upg_ns_ass_smg_small",
			"wpn_fps_upg_fl_ass_smg_sho_peqbox",
			"wpn_fps_upg_fl_ass_smg_sho_surefire",
			"wpn_fps_upg_ass_ns_jprifles",
			"wpn_fps_upg_ass_ns_linear",
			"wpn_fps_upg_ass_ns_surefire",
			"wpn_fps_upg_fl_ass_peq15",
			"wpn_fps_upg_fl_ass_laser",
			"wpn_fps_upg_ass_ns_battle",
			"wpn_fps_upg_fl_ass_utg",
			"wpn_fps_upg_ns_ass_smg_v6"
        },
        bow = {}
    }
end