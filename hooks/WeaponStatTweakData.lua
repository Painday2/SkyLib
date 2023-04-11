local PRIMARY = 2
local SECONDARY = 1
local UNDERBARREL = 3

Hooks:PostHook(WeaponTweakData, "_init_new_weapons", "zm_init_new_weapons", function(self, weapon_data)
    self.nothing2_primary = deep_clone(self.m134)
    self.nothing2_primary.AMMO_PICKUP = {0, 0}
    self.nothing2_primary.timers.reload_not_empty = 0
    self.nothing2_primary.timers.reload_empty = 0
    self.nothing2_primary.timers.unequip = 0
    self.nothing2_primary.timers.equip = 0
    self.nothing2_primary.CLIP_AMMO_MAX = 0
    self.nothing2_primary.NR_CLIPS_MAX = 1
    self.nothing2_primary.fire_mode_data = {fire_rate = 10000}
    self.nothing2_primary.sounds.fire = nil
    self.nothing2_primary.sounds.fire_single = nil
    self.nothing2_primary.sounds.fire_auto = nil
    self.nothing2_primary.sounds.dryfire = nil
    self.nothing2_primary.sounds.enter_steelsight = nil
    self.nothing2_primary.sounds.leave_steelsight = nil
    self.nothing2_primary.stats = {
        zoom = 1,
		total_ammo_mod = 1,
		damage = 0,
		alert_size = 7,
		spread = 0,
		spread_moving = 0,
		recoil = 0,
		value = 1,
		extra_ammo = 51,
		reload = 11,
		suppression = 5,
		concealment = 30
    }

     self.wunderwaffe_primary = deep_clone(self.wa2000)
    self.wunderwaffe_primary.name_id = "wpn_waffe_name"
    self.wunderwaffe_primary.AMMO_PICKUP = {0, 0}
    self.wunderwaffe_primary.CLIP_AMMO_MAX = 3
    self.wunderwaffe_primary.NR_CLIPS_MAX = 6
    self.wunderwaffe_primary.AMMO_MAX = self.wunderwaffe_primary.CLIP_AMMO_MAX * self.wunderwaffe_primary.NR_CLIPS_MAX
    self.wunderwaffe_primary.FIRE_MODE = "single"
    self.wunderwaffe_primary.CAN_TOGGLE_FIREMODE = false
    self.wunderwaffe_primary.single = {fire_rate = 1}
    self.wunderwaffe_primary.fire_mode_data = {fire_rate = 1}
    self.wunderwaffe_primary.stats_modifiers = {damage = 1500}
    self.wunderwaffe_primary.muzzleflash = "units/pd2_mod_zombies/effects/particles/weapons/wunder_fire"
    self.wunderwaffe_primary.shell_ejection = "effects/payday2/particles/weapons/shells/shell_empty"
    self.wunderwaffe_primary.sounds.fire = "wunderwaffe_fire"
    self.wunderwaffe_primary.sounds.fire_single = "wunderwaffe_fire"
    self.wunderwaffe_primary.sounds.dryfire = nil
    self.wunderwaffe_primary.timers = {
		reload_not_empty = 6,
		reload_empty = 6,
		unequip = 1,
		equip = 1
	}
    self.wunderwaffe_primary.animations.reload_name_id = "wa2000"
    self.wunderwaffe_primary.weapon_hold = "wa2000"
    self.wunderwaffe_primary.can_shoot_through_wall = false
    self.wunderwaffe_primary.can_shoot_through_enemy = false

    self.wunderwaffe_secondary = deep_clone(self.wunderwaffe_primary)
    self.wunderwaffe_secondary.use_data = {selection_index = 1}

    self.wunderwaffe_dg3_primary = deep_clone(self.wunderwaffe_primary)
    self.wunderwaffe_dg3_primary.name_id = "wpn_waffe_upg_name"
    self.wunderwaffe_dg3_primary.CLIP_AMMO_MAX = 6
    self.wunderwaffe_dg3_primary.muzzleflash = "units/pd2_mod_zombies/effects/particles/weapons/wunder_dg3_fire"
    self.wunderwaffe_dg3_primary.NR_CLIPS_MAX = 6
    self.wunderwaffe_dg3_primary.AMMO_MAX = self.wunderwaffe_dg3_primary.CLIP_AMMO_MAX * self.wunderwaffe_dg3_primary.NR_CLIPS_MAX
    self.wunderwaffe_dg3_primary.timers = {
		reload_not_empty = 4.7,
		reload_empty = 4.7,
		unequip = 1,
		equip = 1
	}
    self.wunderwaffe_dg3_secondary = deep_clone(self.wunderwaffe_dg3_primary)
    self.wunderwaffe_dg3_secondary.use_data = {selection_index = 1}

    self.waffle_prim_crew = {
        usage = "is_sniper",
		anim_usage = "is_bullpup",
		sounds = {},
		use_data = {},
		auto = {}
    }
    self.waffle_prim_crew.categories = clone(self.wa2000.categories)
	self.waffle_prim_crew.sounds.prefix = "lakner_npc"
	self.waffle_prim_crew.use_data.selection_index = PRIMARY
	self.waffle_prim_crew.DAMAGE = 1
	self.waffle_prim_crew.muzzleflash = "units/pd2_mod_zombies/effects/particles/weapons/wunder_fire"
	self.waffle_prim_crew.muzzleflash_silenced = "units/pd2_mod_zombies/effects/particles/weapons/wunder_fire"
	self.waffle_prim_crew.shell_ejection = "effects/payday2/particles/weapons/shells/shell_empty"
	self.waffle_prim_crew.CLIP_AMMO_MAX = 3
	self.waffle_prim_crew.NR_CLIPS_MAX = 6
	self.waffle_prim_crew.auto.fire_rate = 0.5
	self.waffle_prim_crew.hold = {
		"bullpup",
		"rifle"
	}
	self.waffle_prim_crew.alert_size = 5000
	self.waffle_prim_crew.suppression = 1
    self.waffle_prim_crew.FIRE_MODE = "single"
    
    self.waffle_seco_crew = clone(self.waffle_prim_crew)
    self.waffle_seco_crew.use_data.selection_index = SECONDARY

    self.waffle_dg3_prim_crew = clone(self.waffle_prim_crew)
    self.waffle_dg3_prim_crew.muzzleflash = "units/pd2_mod_zombies/effects/particles/weapons/wunder_dg3_fire"
    self.waffle_dg3_prim_crew.muzzleflash_silenced = "units/pd2_mod_zombies/effects/particles/weapons/wunder_dg3_fire"
    self.waffle_dg3_prim_crew.CLIP_AMMO_MAX = 6
    self.waffle_dg3_prim_crew.NR_CLIPS_MAX = 6
    
    self.waffle_dg3_seco_crew = clone(self.waffle_dg3_prim_crew)
    self.waffle_dg3_seco_crew.use_data.selection_index = SECONDARY

    self:_init_zm_new_weapons()
end)

function WeaponTweakData:_init_zm_new_weapons()


	self.raygun_primary = deep_clone(self.breech)
    self.raygun_primary.name_id = "wpn_raygun"
    self.raygun_primary.sounds = {
        fire = "raygun_fire",
        fire_single = "raygun_fire",
        fire_auto = "raygun_fire",
        magazine_empty = "",
        use_fix = true,
        reload = {
            wp_breech_clip_slide_out = "raygun_out",
            wp_breech_clip_slide_in = "raygun_in",
            wp_breech_clip_take_new = "raygun_eject"
        }
    }
    self.raygun_primary.animations.reload_name_id = "breech"
    self.raygun_primary.ignore_damage_upgrades = true
    self.raygun_primary.shell_ejection = "effects/payday2/particles/weapons/shells/shell_empty"
    self.raygun_primary.muzzleflash = "effects/raygun_fire"
    self.raygun_primary.animations.ignore_fullreload = true
    self.raygun_primary.timers.reload_empty = 1.33
    self.raygun_primary.weapon_hold = "breech"
    self.raygun_primary.projectile_type = "raygun_blast"
    self.raygun_primary.CLIP_AMMO_MAX = 20
    self.raygun_primary.NR_CLIPS_MAX = 9
    self.raygun_primary.AMMO_MAX = self.raygun_primary.CLIP_AMMO_MAX * self.raygun_primary.NR_CLIPS_MAX
    self.raygun_primary.stats.spread = 24
    self.raygun_primary.upgrade_blocks = {
        weapon = {
            "clip_ammo_increase"
        }
    }
    self.raygun_primary.stats_modifiers = {damage = 10}
    self.raygun_primary.fire_mode_data = {
		fire_rate = 0.331
    }
    self.raygun_primary.use_data = {selection_index = PRIMARY}

    self.raygun_secondary = deep_clone(self.raygun_primary)
    self.raygun_secondary.use_data = {selection_index = SECONDARY}

	-- CRASHING
    -- self.elastic_primary = deep_clone(self.elastic)
    -- self.elastic_primary.animations.reload_name_id = "elastic"
    -- self.elastic_primary.weapon_hold = "elastic"
    -- self.elastic_primary.stats_modifiers = {damage = 3}
    -- self.elastic_primary.NR_CLIPS_MAX = self.elastic_primary.NR_CLIPS_MAX * 2
    -- self.elastic_primary.AMMO_MAX = self.elastic_primary.CLIP_AMMO_MAX * self.elastic_primary.NR_CLIPS_MAX
    -- self.elastic_primary.use_data = {selection_index = PRIMARY, align_place = "left_hand"}
    -- self.elastic_primary.timers = {
        -- reload_not_empty = 1,
        -- reload_empty = 1
    -- }
    -- self.elastic_primary.charge_data = {
		-- max_t = 1
    -- }
    -- self.elastic_primary.bow_reload_speed_multiplier = 3
    -- self.elastic_secondary = deep_clone(self.elastic_primary)
    -- self.elastic_secondary.use_data = {selection_index = SECONDARY, align_place = "left_hand"}

	--DONE WEAPON TWEAK
    self:_init_upgraded_zm_weapons()
end

function WeaponTweakData:_init_upgraded_zm_weapons()
	-- CRASHING
    -- self.elastic_upg_primary = deep_clone(self.elastic_primary)
    -- self.elastic_upg_primary.name_id = "wpn_elastic_upg_name"
    -- self.elastic_upg_primary.stats_modifiers = {damage = 16}
    -- self.elastic_upg_primary.muzzleflash = "units/pd2_mod_zombies/effects/zm_weapons/zm_pap_muzzle"
    -- self.elastic_upg_secondary = deep_clone(self.elastic_upg_primary)
    -- self.elastic_upg_secondary.use_data = {selection_index = SECONDARY, align_place = "left_hand"}
	
	self.raygun_upg_primary = deep_clone(self.raygun_primary)
    self.raygun_upg_primary.name_id = "wpn_raygun_upg_name"
    self.raygun_upg_primary.muzzleflash = "effects/raygun_fire_pap"
    self.raygun_upg_primary.projectile_type = "raygun_blast_pap"
    self.raygun_upg_primary.CLIP_AMMO_MAX = 40
    self.raygun_upg_primary.NR_CLIPS_MAX = 4.5
    self.raygun_upg_primary.AMMO_MAX = self.raygun_upg_primary.CLIP_AMMO_MAX * self.raygun_upg_primary.NR_CLIPS_MAX
    self.raygun_upg_primary.use_data = {selection_index = PRIMARY}
    self.raygun_upg_secondary = deep_clone(self.raygun_upg_primary)
    self.raygun_upg_secondary.use_data = {selection_index = SECONDARY}
	
	--DONE UPG WEAPON TWEAK
end

Hooks:PostHook(WeaponTweakData, "_init_data_swat_van_turret_module_npc", "zm_tweak_swat_turret", function(self)
    self.swat_van_turret_module.DAMAGE = 15
    self.swat_van_turret_module.CLIP_SIZE = 1000
    self.swat_van_turret_module.FIRE_RANGE = 20000
    self.swat_van_turret_module.alert_size = 10000
    self.swat_van_turret_module.DETECTION_DELAY = {
		{
			900,
			0.3
		},
		{
			self.swat_van_turret_module.FIRE_RANGE,
			0.3
		}
    }
    self.swat_van_turret_module.muzzleflash = "units/pd2_mod_zombies/effects/payday2/particles/weapons/big_762_auto"
    self.swat_van_turret_module.DETECTION_RANGE = self.swat_van_turret_module.FIRE_RANGE
    self.swat_van_turret_module.MAX_VEL_SPIN = 72 * 2
	self.swat_van_turret_module.MIN_VEL_SPIN = self.swat_van_turret_module.MAX_VEL_SPIN * 0.05
	self.swat_van_turret_module.SLOWDOWN_ANGLE_SPIN = 30 * 2
	self.swat_van_turret_module.ACC_SPIN = self.swat_van_turret_module.MAX_VEL_SPIN * 5
	self.swat_van_turret_module.MAX_VEL_PITCH = 60 * 2
	self.swat_van_turret_module.MIN_VEL_PITCH = self.swat_van_turret_module.MAX_VEL_PITCH * 0.05
	self.swat_van_turret_module.SLOWDOWN_ANGLE_PITCH = 20 * 2
	self.swat_van_turret_module.ACC_PITCH = self.swat_van_turret_module.MAX_VEL_PITCH * 5
end)

Hooks:PostHook(WeaponTweakData, "_set_normal", "zm_td__set_normal", function(self)
    self.swat_van_turret_module.DAMAGE = 4
end)

Hooks:PostHook(WeaponTweakData, "_set_hard", "zm_td__set_hard", function(self)
    self.swat_van_turret_module.DAMAGE = 7
end)

Hooks:PostHook(WeaponTweakData, "_set_overkill", "zm_td__set_overkill", function(self)
    self.swat_van_turret_module.DAMAGE = 7
end)

Hooks:PostHook(WeaponTweakData, "_set_overkill_145", "zm_td__set_overkill_145", function(self)
    self.swat_van_turret_module.DAMAGE = 9
end)

Hooks:PostHook(WeaponTweakData, "_set_easy_wish", "zm_td__set_easy_wish", function(self)
    self.swat_van_turret_module.DAMAGE = 10
end)

Hooks:PostHook(WeaponTweakData, "_set_overkill_290", "zm_td__set_overkill_290", function(self)
    self.swat_van_turret_module.DAMAGE = 12
end)

Hooks:PostHook(WeaponTweakData, "_set_sm_wish", "zm_td_smwish", function(self)
    self.swat_van_turret_module.DAMAGE = 15
end)

Hooks:PostHook(WeaponTweakData, "_init_data_smoke_npc", "zm_reduce_shadow_cockers_damage", function(self)
    self.smoke_npc.DAMAGE = 1
end)
