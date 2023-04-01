--Sets the max amounts of grenades, and sets the raygun projectiles
SkyHook:Post(BlackMarketTweakData, "_init_projectiles", function(self, tweak_data)
    SkyLib:log("ZM BMTD projectiles INIT")
    self.projectiles.frag.max_amount = 4
    self.projectiles.frag.no_cheat_count = true
    self.projectiles.concussion.max_amount = 4
    self.projectiles.concussion.no_cheat_count = true
    self.projectiles.molotov.max_amount = 1
    self.projectiles.molotov.no_cheat_count = true
    self.projectiles.dynamite.max_amount = 4
    self.projectiles.dynamite.no_cheat_count = true
    self.projectiles.wpn_prj_four.max_amount = 4
    self.projectiles.wpn_prj_four.no_cheat_count = true
    self.projectiles.wpn_prj_ace.max_amount = 10
    self.projectiles.wpn_prj_ace.no_cheat_count = true
    self.projectiles.wpn_prj_jav.max_amount = 2
    self.projectiles.wpn_prj_jav.no_cheat_count = true
    self.projectiles.wpn_prj_hur.max_amount = 3
    self.projectiles.wpn_prj_hur.no_cheat_count = true
    self.projectiles.wpn_prj_hur.throw_allowed_expire_t = 0.1
    self.projectiles.wpn_prj_hur.expire_t = 0.8
    self.projectiles.wpn_prj_hur.repeat_expire_t = 0.6
    self.projectiles.wpn_prj_target.max_amount = 3
    self.projectiles.wpn_prj_target.no_cheat_count = true
    self.projectiles.frag_com.max_amount = 4
    self.projectiles.frag_com.no_cheat_count = true
    self.projectiles.fir_com.max_amount = 3
    self.projectiles.fir_com.no_cheat_count = true
	self.projectiles.dada_com.max_amount = 4
    self.projectiles.dada_com.no_cheat_count = true

    self.projectiles.rocket_frag.time_cheat = 0
    self.projectiles.launcher_frag_arbiter.time_cheat = 0

    self.projectiles.raygun_blast = deep_clone(self.projectiles.ecp_arrow_exp)
	self.projectiles.raygun_blast.unit = "units/mods/weapons/wpn_prj_raygun_blast/wpn_prj_raygun_blast"
	self.projectiles.raygun_blast.local_unit = "units/mods/weapons/wpn_prj_raygun_blast/wpn_prj_raygun_blast_local"
    self.projectiles.raygun_blast.weapon_id = "raygun_primary"
    self.projectiles.raygun_blast.physic_effect = Idstring("physic_effects/anti_gravitate")
	self.projectiles.raygun_blast.adjust_z = 0

    self.projectiles.raygun_blast_pap = deep_clone(self.projectiles.ecp_arrow_exp)
	self.projectiles.raygun_blast_pap.unit = "units/mods/weapons/wpn_prj_raygun_blast_pap/wpn_prj_raygun_blast_pap"
	self.projectiles.raygun_blast_pap.local_unit = "units/mods/weapons/wpn_prj_raygun_blast_pap/wpn_prj_raygun_blast_pap_local"
    self.projectiles.raygun_blast_pap.weapon_id = "raygun_upg_primary"
    self.projectiles.raygun_blast_pap.physic_effect = Idstring("physic_effects/anti_gravitate")
	self.projectiles.raygun_blast_pap.adjust_z = 0

end)
