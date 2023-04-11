Hooks:PostHook(WeaponFactoryTweakData, "init", "zm_init_weapon_data_factory", function(self)
    self:_init_no_weapon()
    self:_init_shovigun()
	self:_init_wunderwaffe()
    self:_init_wunderwaffe_dg3()
	
    self:_init_multiplix()
    self:_init_upgraded_multiplix()
	
	
end)

function WeaponFactoryTweakData:_init_wunderwaffe()
    self.parts.wpn_fps_spe_wunderwaffe_body = deep_clone(self.parts.wpn_fps_snp_mosin_body_standard)
    self.parts.wpn_fps_spe_wunderwaffe_body.unit = "units/mods/weapons/wpn_fps_spe_wunderwaffe_pts/wpn_fps_spe_wunderwaffe_body"
    self.parts.wpn_fps_spe_wunderwaffe_body.type = "barrel"
    self.parts.wpn_fps_spe_wunderwaffe_body.third_unit = "units/mods/weapons/wpn_fps_spe_wunderwaffe_pts/wpn_fps_spe_wunderwaffe_body"
	
    self.parts.wpn_fps_spe_wunderwaffe_illum = deep_clone(self.parts.wpn_fps_snp_mosin_body_standard)
    self.parts.wpn_fps_spe_wunderwaffe_illum.unit = "units/mods/weapons/wpn_fps_spe_wunderwaffe_pts/wpn_fps_spe_wunderwaffe_illum"
    self.parts.wpn_fps_spe_wunderwaffe_illum.type = "extra"
    self.parts.wpn_fps_spe_wunderwaffe_illum.third_unit = "units/mods/weapons/wpn_fps_spe_wunderwaffe_pts/wpn_fps_spe_wunderwaffe_illum"
	
    self.parts.wpn_fps_spe_wunderwaffe_mag = deep_clone(self.parts.wpn_fps_ass_m14_m_standard)
    self.parts.wpn_fps_spe_wunderwaffe_mag.animations = nil
    self.parts.wpn_fps_spe_wunderwaffe_mag.unit = "units/mods/weapons/wpn_fps_spe_wunderwaffe_pts/wpn_fps_spe_wunderwaffe_mag"
    self.parts.wpn_fps_spe_wunderwaffe_mag.third_unit = "units/mods/weapons/wpn_fps_spe_wunderwaffe_pts/wpn_fps_spe_wunderwaffe_mag"
	
    self.parts.wpn_fps_spe_wunderwaffe_bulb_outer = deep_clone(self.parts.wpn_fps_snp_mosin_body_standard)
    self.parts.wpn_fps_spe_wunderwaffe_bulb_outer.unit = "units/mods/weapons/wpn_fps_spe_wunderwaffe_pts/wpn_fps_spe_wunderwaffe_bulb_outer"
    self.parts.wpn_fps_spe_wunderwaffe_bulb_outer.type = "extra"
    self.parts.wpn_fps_spe_wunderwaffe_bulb_outer.third_unit = "units/mods/weapons/wpn_fps_spe_wunderwaffe_pts/wpn_fps_spe_wunderwaffe_bulb_outer"
	
    self.parts.wpn_fps_spe_wunderwaffe_center_glow = deep_clone(self.parts.wpn_fps_snp_mosin_body_standard)
    self.parts.wpn_fps_spe_wunderwaffe_center_glow.unit = "units/mods/weapons/wpn_fps_spe_wunderwaffe_pts/wpn_fps_spe_wunderwaffe_center_glow"
    self.parts.wpn_fps_spe_wunderwaffe_center_glow.type = "extra"
    self.parts.wpn_fps_spe_wunderwaffe_center_glow.third_unit = "units/mods/weapons/wpn_fps_spe_wunderwaffe_pts/wpn_fps_spe_wunderwaffe_center_glow"
	
    self.parts.wpn_fps_spe_wunderwaffe_center_tube = deep_clone(self.parts.wpn_fps_snp_mosin_body_standard)
    self.parts.wpn_fps_spe_wunderwaffe_center_tube.unit = "units/mods/weapons/wpn_fps_spe_wunderwaffe_pts/wpn_fps_spe_wunderwaffe_center_tube"
    self.parts.wpn_fps_spe_wunderwaffe_center_tube.type = "extra"
    self.parts.wpn_fps_spe_wunderwaffe_center_tube.third_unit = "units/mods/weapons/wpn_fps_spe_wunderwaffe_pts/wpn_fps_spe_wunderwaffe_center_tube"
   
    self.parts.wpn_fps_spe_wunderwaffe_metal = deep_clone(self.parts.wpn_fps_snp_mosin_body_standard)
    self.parts.wpn_fps_spe_wunderwaffe_metal.unit = "units/mods/weapons/wpn_fps_spe_wunderwaffe_pts/wpn_fps_spe_wunderwaffe_metal"
    self.parts.wpn_fps_spe_wunderwaffe_metal.type = "extra"
    self.parts.wpn_fps_spe_wunderwaffe_metal.third_unit = "units/mods/weapons/wpn_fps_spe_wunderwaffe_pts/wpn_fps_spe_wunderwaffe_metal"
	
    self.parts.wpn_fps_spe_wunderwaffe_pipes = deep_clone(self.parts.wpn_fps_snp_mosin_body_standard)
    self.parts.wpn_fps_spe_wunderwaffe_pipes.unit = "units/mods/weapons/wpn_fps_spe_wunderwaffe_pts/wpn_fps_spe_wunderwaffe_pipes"
    self.parts.wpn_fps_spe_wunderwaffe_pipes.type = "extra"
    self.parts.wpn_fps_spe_wunderwaffe_pipes.third_unit = "units/mods/weapons/wpn_fps_spe_wunderwaffe_pts/wpn_fps_spe_wunderwaffe_pipes"
	
    self.parts.wpn_fps_spe_wunderwaffe_wood = deep_clone(self.parts.wpn_fps_snp_mosin_body_standard)
    self.parts.wpn_fps_spe_wunderwaffe_wood.unit = "units/mods/weapons/wpn_fps_spe_wunderwaffe_pts/wpn_fps_spe_wunderwaffe_wood"
    self.parts.wpn_fps_spe_wunderwaffe_wood.type = "extra"
    self.parts.wpn_fps_spe_wunderwaffe_wood.third_unit = "units/mods/weapons/wpn_fps_spe_wunderwaffe_pts/wpn_fps_spe_wunderwaffe_wood"
 
    self.wpn_fps_spe_wunderwaffe_primary = deep_clone(self.wpn_fps_snp_mosin)
    self.wpn_fps_spe_wunderwaffe_primary.unit = "units/mods/weapons/wpn_fps_spe_wunderwaffe/wpn_fps_spe_wunderwaffe"
    self.wpn_fps_spe_wunderwaffe_primary.default_blueprint = {
        "wpn_fps_spe_wunderwaffe_body",
        "wpn_fps_spe_wunderwaffe_illum",
        "wpn_fps_spe_wunderwaffe_mag",
        "wpn_fps_spe_wunderwaffe_bulb_outer",
        "wpn_fps_spe_wunderwaffe_center_glow",
        "wpn_fps_spe_wunderwaffe_center_tube",
        "wpn_fps_spe_wunderwaffe_metal",
        "wpn_fps_spe_wunderwaffe_pipes",
        "wpn_fps_spe_wunderwaffe_wood"
    }
    self.wpn_fps_spe_wunderwaffe_primary.uses_parts = self.wpn_fps_spe_wunderwaffe_primary.default_blueprint
 
    self.wpn_fps_spe_wunderwaffe_secondary = deep_clone(self.wpn_fps_spe_wunderwaffe_primary)
    self.wpn_fps_spe_wunderwaffe_secondary.unit = "units/mods/weapons/wpn_fps_spe_wunderwaffe/wpn_fps_spe_wunderwaffe_secondary"

    self.wpn_fps_spe_wunderwaffe_primary_npc = deep_clone(self.wpn_fps_spe_wunderwaffe_primary)
    self.wpn_fps_spe_wunderwaffe_primary_npc.unit = "units/mods/weapons/wpn_fps_spe_wunderwaffe/wpn_fps_spe_wunderwaffe_npc"
    self.wpn_fps_spe_wunderwaffe_secondary_npc = deep_clone(self.wpn_fps_spe_wunderwaffe_secondary)
	self.wpn_fps_spe_wunderwaffe_secondary_npc.unit = "units/mods/weapons/wpn_fps_spe_wunderwaffe/wpn_fps_spe_wunderwaffe_secondary_npc"
end
 
function WeaponFactoryTweakData:_init_wunderwaffe_dg3()
    self.parts.wpn_fps_spe_wunderwaffe_dg3_body = deep_clone(self.parts.wpn_fps_snp_mosin_body_standard)
    self.parts.wpn_fps_spe_wunderwaffe_dg3_body.unit = "units/mods/weapons/wpn_fps_spe_wunderwaffe_pts/wpn_fps_spe_wunderwaffe_dg3_body"
    self.parts.wpn_fps_spe_wunderwaffe_dg3_body.type = "barrel"
    self.parts.wpn_fps_spe_wunderwaffe_dg3_body.third_unit = "units/payday2/weapons/wpn_upg_dummy/wpn_upg_dummy"
	
    self.parts.wpn_fps_spe_wunderwaffe_dg3_illum = deep_clone(self.parts.wpn_fps_snp_mosin_body_standard)
    self.parts.wpn_fps_spe_wunderwaffe_dg3_illum.unit = "units/mods/weapons/wpn_fps_spe_wunderwaffe_pts/wpn_fps_spe_wunderwaffe_dg3_illum"
    self.parts.wpn_fps_spe_wunderwaffe_dg3_illum.type = "extra"
    self.parts.wpn_fps_spe_wunderwaffe_dg3_illum.third_unit = "units/payday2/weapons/wpn_upg_dummy/wpn_upg_dummy"
	
    self.parts.wpn_fps_spe_wunderwaffe_dg3_mag = deep_clone(self.parts.wpn_fps_ass_m14_m_standard)
    self.parts.wpn_fps_spe_wunderwaffe_dg3_mag.animations = nil
    self.parts.wpn_fps_spe_wunderwaffe_dg3_mag.unit = "units/mods/weapons/wpn_fps_spe_wunderwaffe_pts/wpn_fps_spe_wunderwaffe_dg3_mag"
    self.parts.wpn_fps_spe_wunderwaffe_dg3_mag.third_unit = "units/payday2/weapons/wpn_upg_dummy/wpn_upg_dummy"
	
    self.parts.wpn_fps_spe_wunderwaffe_dg3_bulb_outer = deep_clone(self.parts.wpn_fps_snp_mosin_body_standard)
    self.parts.wpn_fps_spe_wunderwaffe_dg3_bulb_outer.unit = "units/mods/weapons/wpn_fps_spe_wunderwaffe_pts/wpn_fps_spe_wunderwaffe_dg3_bulb_outer"
    self.parts.wpn_fps_spe_wunderwaffe_dg3_bulb_outer.type = "extra"
    self.parts.wpn_fps_spe_wunderwaffe_dg3_bulb_outer.third_unit = "units/payday2/weapons/wpn_upg_dummy/wpn_upg_dummy"
   
    self.parts.wpn_fps_spe_wunderwaffe_dg3_metal = deep_clone(self.parts.wpn_fps_snp_mosin_body_standard)
    self.parts.wpn_fps_spe_wunderwaffe_dg3_metal.unit = "units/mods/weapons/wpn_fps_spe_wunderwaffe_pts/wpn_fps_spe_wunderwaffe_dg3_metal"
    self.parts.wpn_fps_spe_wunderwaffe_dg3_metal.type = "extra"
    self.parts.wpn_fps_spe_wunderwaffe_dg3_metal.third_unit = "units/payday2/weapons/wpn_upg_dummy/wpn_upg_dummy"
	
    self.parts.wpn_fps_spe_wunderwaffe_dg3_pipes = deep_clone(self.parts.wpn_fps_snp_mosin_body_standard)
    self.parts.wpn_fps_spe_wunderwaffe_dg3_pipes.unit = "units/mods/weapons/wpn_fps_spe_wunderwaffe_pts/wpn_fps_spe_wunderwaffe_dg3_pipes"
    self.parts.wpn_fps_spe_wunderwaffe_dg3_pipes.type = "extra"
    self.parts.wpn_fps_spe_wunderwaffe_dg3_pipes.third_unit = "units/payday2/weapons/wpn_upg_dummy/wpn_upg_dummy"
	
    self.parts.wpn_fps_spe_wunderwaffe_dg3_wood = deep_clone(self.parts.wpn_fps_snp_mosin_body_standard)
    self.parts.wpn_fps_spe_wunderwaffe_dg3_wood.unit = "units/mods/weapons/wpn_fps_spe_wunderwaffe_pts/wpn_fps_spe_wunderwaffe_dg3_wood"
    self.parts.wpn_fps_spe_wunderwaffe_dg3_wood.type = "extra"
    self.parts.wpn_fps_spe_wunderwaffe_dg3_wood.third_unit = "units/payday2/weapons/wpn_upg_dummy/wpn_upg_dummy"
 
    self.wpn_fps_spe_wunderwaffe_dg3_primary = deep_clone(self.wpn_fps_snp_mosin)
    self.wpn_fps_spe_wunderwaffe_dg3_primary.unit = "units/mods/weapons/wpn_fps_spe_wunderwaffe/wpn_fps_spe_wunderwaffe_dg3"
    self.wpn_fps_spe_wunderwaffe_dg3_primary.default_blueprint = {
        "wpn_fps_spe_wunderwaffe_dg3_body",
        "wpn_fps_spe_wunderwaffe_dg3_illum",
        "wpn_fps_spe_wunderwaffe_dg3_mag",
        "wpn_fps_spe_wunderwaffe_dg3_bulb_outer",
        "wpn_fps_spe_wunderwaffe_center_glow",
        "wpn_fps_spe_wunderwaffe_center_tube",
        "wpn_fps_spe_wunderwaffe_dg3_metal",
        "wpn_fps_spe_wunderwaffe_dg3_pipes",
        "wpn_fps_spe_wunderwaffe_dg3_wood"
    }
    self.wpn_fps_spe_wunderwaffe_dg3_primary.uses_parts = self.wpn_fps_spe_wunderwaffe_dg3_primary.default_blueprint

    self.wpn_fps_spe_wunderwaffe_dg3_secondary = deep_clone(self.wpn_fps_spe_wunderwaffe_dg3_primary)
    self.wpn_fps_spe_wunderwaffe_dg3_secondary.unit = "units/mods/weapons/wpn_fps_spe_wunderwaffe/wpn_fps_spe_wunderwaffe_dg3_secondary"

    self.wpn_fps_spe_wunderwaffe_dg3_primary_npc = deep_clone(self.wpn_fps_spe_wunderwaffe_dg3_primary)
    self.wpn_fps_spe_wunderwaffe_dg3_primary_npc.unit = "units/mods/weapons/wpn_fps_spe_wunderwaffe/wpn_fps_spe_wunderwaffe_dg3_npc"
    self.wpn_fps_spe_wunderwaffe_dg3_secondary_npc = deep_clone(self.wpn_fps_spe_wunderwaffe_dg3_secondary)
	self.wpn_fps_spe_wunderwaffe_dg3_secondary_npc.unit = "units/mods/weapons/wpn_fps_spe_wunderwaffe/wpn_fps_spe_wunderwaffe_dg3_secondary_npc"
end

function WeaponFactoryTweakData:_init_no_weapon()
    self.parts.wpn_fps_pis_nothing_sight = deep_clone(self.parts.wpn_fps_m4_uupg_o_flipup)
    self.parts.wpn_fps_pis_nothing_sight.unit = "units/payday2/weapons/wpn_upg_dummy/wpn_upg_dummy"
    self.parts.wpn_fps_pis_nothing_body_standard = deep_clone(self.parts.wpn_fps_pis_p226_body_standard)
    self.parts.wpn_fps_pis_nothing_body_standard.unit = "units/payday2/weapons/wpn_upg_dummy/wpn_upg_dummy"
    self.parts.wpn_fps_pis_nothing_body_standard.stats.damage = -10
    self.parts.wpn_fps_pis_nothing_body_standard.stats.concealment = 10
    self.parts.wpn_fps_pis_nothing_body_standard.stats.recoil = -24
    self.parts.wpn_fps_pis_nothing_body_standard.stats.spread = -8

    self.wpn_fps_ass_nothing2_primary = {
        unit = "units/pd2_mod_zombies/weapons/wpn_fps_ass_nothing2/wpn_fps_ass_nothing2",
		optional_types = {
			"gadget",
			"barrel_ext"
		},
		default_blueprint = {
			"wpn_fps_pis_nothing_sight",
			"wpn_fps_pis_nothing_body_standard"
		},
		uses_parts = {
            "wpn_fps_pis_nothing_sight",
			"wpn_fps_pis_nothing_body_standard"
		}
    }

    self.wpn_fps_ass_nothing2_primary.override = {
		wpn_fps_pis_nothing_sight = {
			stats = {
				zoom = 0
			},
			stance_mod = {
				wpn_fps_ass_nothing2 = {
					translation = Vector3( 9999999999, 99999999, 999999)
				}
			}
        }
    }
	
	
end

function WeaponFactoryTweakData:_init_shovigun()
    self.parts.wpn_fps_spe_raygun_body = deep_clone(self.parts.wpn_fps_pis_breech_body)
    self.parts.wpn_fps_spe_raygun_body.unit = "units/mods/weapons/wpn_fps_spe_raygun_pts/wpn_fps_spe_raygun_body"
    self.parts.wpn_fps_spe_raygun_metal = deep_clone(self.parts.wpn_fps_pis_breech_body)
    self.parts.wpn_fps_spe_raygun_metal.unit = "units/mods/weapons/wpn_fps_spe_raygun_pts/wpn_fps_spe_raygun_metal_static"
    self.parts.wpn_fps_spe_raygun_reticle = deep_clone(self.parts.wpn_fps_pis_breech_body)
    self.parts.wpn_fps_spe_raygun_reticle.unit = "units/mods/weapons/wpn_fps_spe_raygun_pts/wpn_fps_spe_raygun_reticle"
    self.parts.wpn_fps_spe_raygun_glass = deep_clone(self.parts.wpn_fps_pis_breech_body)
    self.parts.wpn_fps_spe_raygun_glass.unit = "units/mods/weapons/wpn_fps_spe_raygun_pts/wpn_fps_spe_raygun_glass"
    self.parts.wpn_fps_spe_raygun_power = deep_clone(self.parts.wpn_fps_pis_breech_body)
    self.parts.wpn_fps_spe_raygun_power.unit = "units/mods/weapons/wpn_fps_spe_raygun_pts/wpn_fps_spe_raygun_power"
    self.parts.wpn_fps_spe_raygun_meter = deep_clone(self.parts.wpn_fps_pis_breech_body)
    self.parts.wpn_fps_spe_raygun_meter.unit = "units/mods/weapons/wpn_fps_spe_raygun_pts/wpn_fps_spe_raygun_meter"
    self.parts.wpn_fps_spe_raygun_b_dummy = deep_clone(self.parts.wpn_fps_pis_breech_b_standard)
    self.parts.wpn_fps_spe_raygun_b_dummy.unit = "units/mods/weapons/wpn_fps_spe_raygun_pts/wpn_fps_spe_raygun_b_dummy"

    self.wpn_fps_spe_raygun_primary = deep_clone(self.wpn_fps_pis_breech)
    self.wpn_fps_spe_raygun_primary.unit = "units/mods/weapons/wpn_fps_spe_raygun/wpn_fps_spe_raygun_primary"
    self.wpn_fps_spe_raygun_primary.default_blueprint = {
        "wpn_fps_spe_raygun_body",
        "wpn_fps_spe_raygun_b_dummy",
        "wpn_fps_spe_raygun_metal",
        "wpn_fps_spe_raygun_glass",
        "wpn_fps_spe_raygun_power",
        "wpn_fps_spe_raygun_meter",
        "wpn_fps_spe_raygun_reticle"
    }
    self.wpn_fps_spe_raygun_primary_npc = deep_clone(self.wpn_fps_spe_raygun_primary)
    self.wpn_fps_spe_raygun_primary_npc.unit = "units/mods/weapons/wpn_fps_spe_raygun/wpn_fps_spe_raygun_npc"
    self.wpn_fps_spe_raygun_secondary = deep_clone(self.wpn_fps_spe_raygun_primary)
    self.wpn_fps_spe_raygun_secondary.unit = "units/mods/weapons/wpn_fps_spe_raygun/wpn_fps_spe_raygun_secondary"
    self.wpn_fps_spe_raygun_secondary_npc = deep_clone(self.wpn_fps_spe_raygun_primary)
    self.wpn_fps_spe_raygun_secondary_npc.unit = "units/mods/weapons/wpn_fps_spe_raygun/wpn_fps_spe_raygun_npc"
end

function WeaponFactoryTweakData:_init_multiplix()    
	--NAGANT SNIPER RIFLE
    self.wpn_fps_snp_mosin_primary = deep_clone(self.wpn_fps_snp_mosin)
    self.wpn_fps_snp_mosin_primary.unit = "units/pd2_mod_zombies/weapons/wpn_fps_snp_mosin_primary"
	self.wpn_fps_snp_mosin_primary.default_blueprint = {
        "wpn_fps_snp_mosin_iron_sight",
		"wpn_fps_snp_mosin_body_standard",
		"wpn_fps_snp_mosin_b_standard",
		"wpn_fps_snp_mosin_m_standard"
    }
    self.wpn_fps_snp_mosin_secondary = deep_clone(self.wpn_fps_snp_mosin_primary)
    self.wpn_fps_snp_mosin_secondary.unit = "units/pd2_mod_zombies/weapons/wpn_fps_snp_mosin_secondary"
    self.wpn_fps_snp_mosin_primary_npc = deep_clone(self.wpn_fps_snp_mosin_primary)
    self.wpn_fps_snp_mosin_primary_npc.unit = "units/pd2_dlc_gage_historical/weapons/wpn_fps_snp_mosin/wpn_fps_snp_mosin_npc"
    self.wpn_fps_snp_mosin_secondary_npc = deep_clone(self.wpn_fps_snp_mosin_secondary)
	self.wpn_fps_snp_mosin_secondary_npc.unit = "units/pd2_dlc_gage_historical/weapons/wpn_fps_snp_mosin/wpn_fps_snp_mosin_npc"
end

function WeaponFactoryTweakData:_init_upgraded_multiplix()
    -- self.wpn_fps_bow_elastic_upg_primary = deep_clone(self.wpn_fps_bow_elastic)
    -- self.wpn_fps_bow_elastic_upg_primary.unit = "units/mods/weapons/wpn_fps_spe_storm_bow/wpn_fps_spe_storm_bow"
    -- self.wpn_fps_bow_elastic_upg_primary.default_blueprint = {
        -- "wpn_fps_spe_storm_bow_base",
        -- "wpn_fps_spe_storm_bow_bone_base",
        -- "wpn_fps_spe_storm_bow_elec_base",
        -- "wpn_fps_bow_elastic_m_standard",
    -- }
    -- self.wpn_fps_bow_elastic_upg_primary.uses_parts = self.wpn_fps_bow_elastic_upg_primary.default_blueprint
    -- self.wpn_fps_bow_elastic_upg_secondary = deep_clone(self.wpn_fps_bow_elastic_upg_primary)
    -- self.wpn_fps_bow_elastic_upg_secondary.unit = "units/mods/weapons/wpn_fps_spe_storm_bow/wpn_fps_spe_storm_bow_secondary"
    -- self.wpn_fps_bow_elastic_upg_primary_npc = deep_clone(self.wpn_fps_bow_elastic_upg_primary)
	-- self.wpn_fps_bow_elastic_upg_primary_npc.unit = "units/pd2_dlc_ram/weapons/wpn_fps_bow_elastic/wpn_fps_bow_elastic_npc"
    -- self.wpn_fps_bow_elastic_upg_primary_npc.skip_thq_parts = true
    -- self.wpn_fps_bow_elastic_upg_secondary_npc = deep_clone(self.wpn_fps_bow_elastic_upg_secondary)
	-- self.wpn_fps_bow_elastic_upg_secondary_npc.unit = "units/pd2_dlc_ram/weapons/wpn_fps_bow_elastic/wpn_fps_bow_elastic_npc"
	-- self.wpn_fps_bow_elastic_upg_secondary_npc.skip_thq_parts = true
end










