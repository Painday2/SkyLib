function CharacterTweakData:_multiply_by_wave_nb(wave)

	if wave < 10 then
		local addition = 10
		self.fbi.HEALTH_INIT = self.fbi.HEALTH_INIT + addition
		self.swat.HEALTH_INIT = self.swat.HEALTH_INIT + addition
		self.heavy_swat.HEALTH_INIT = self.heavy_swat.HEALTH_INIT + addition
		self.fbi_heavy_swat.HEALTH_INIT = self.fbi_heavy_swat.HEALTH_INIT + addition
		self.sniper.HEALTH_INIT = self.sniper.HEALTH_INIT + addition
		self.gangster.HEALTH_INIT = self.gangster.HEALTH_INIT + addition
		self.biker.HEALTH_INIT = self.biker.HEALTH_INIT + addition
		self.tank.HEALTH_INIT = self.tank.HEALTH_INIT + addition
		self.tank_mini.HEALTH_INIT = self.tank_mini.HEALTH_INIT + addition
		self.tank_medic.HEALTH_INIT = self.tank_medic.HEALTH_INIT + addition
		self.spooc.HEALTH_INIT = self.spooc.HEALTH_INIT + addition
		self.shield.HEALTH_INIT = self.shield.HEALTH_INIT + addition
		self.phalanx_minion.HEALTH_INIT = self.phalanx_minion.HEALTH_INIT + addition
		self.phalanx_vip.HEALTH_INIT = self.phalanx_vip.HEALTH_INIT + addition
		self.taser.HEALTH_INIT = self.taser.HEALTH_INIT + addition
		self.city_swat.HEALTH_INIT = self.city_swat.HEALTH_INIT + addition
		self.biker_escape.HEALTH_INIT = self.biker_escape.HEALTH_INIT + addition
		self.fbi_swat.HEALTH_INIT = self.fbi_swat.HEALTH_INIT + addition
		self.tank_hw.HEALTH_INIT = self.tank_hw.HEALTH_INIT + addition
		self.medic.HEALTH_INIT = self.medic.HEALTH_INIT + addition
		self.bolivian.HEALTH_INIT = self.bolivian.HEALTH_INIT + addition
		self.bolivian_indoors.HEALTH_INIT = self.bolivian_indoors.HEALTH_INIT + addition
		self.drug_lord_boss.HEALTH_INIT = self.drug_lord_boss.HEALTH_INIT + addition
		self.drug_lord_boss_stealth.HEALTH_INIT = self.drug_lord_boss_stealth.HEALTH_INIT + addition
		self.shadow_spooc.HEALTH_INIT = self.shadow_spooc.HEALTH_INIT + addition
		return
	end

    local base = 1
	local divider = 0.200

	self.fbi.HEALTH_INIT = self.fbi.HEALTH_INIT * base + (wave / divider)
	self.swat.HEALTH_INIT = self.swat.HEALTH_INIT * base + (wave / divider)
	self.heavy_swat.HEALTH_INIT = self.heavy_swat.HEALTH_INIT * base + (wave / divider)
	self.fbi_heavy_swat.HEALTH_INIT = self.fbi_heavy_swat.HEALTH_INIT * base + (wave / divider)
	self.sniper.HEALTH_INIT = self.sniper.HEALTH_INIT * base + (wave / divider)
	self.gangster.HEALTH_INIT = self.gangster.HEALTH_INIT * base + (wave / divider)
	self.biker.HEALTH_INIT = self.biker.HEALTH_INIT * base + (wave / divider)
	self.tank.HEALTH_INIT = self.tank.HEALTH_INIT * base + (wave / divider)
	self.tank_mini.HEALTH_INIT = self.tank_mini.HEALTH_INIT * base + (wave / divider)
	self.tank_medic.HEALTH_INIT = self.tank_medic.HEALTH_INIT * base + (wave / divider)
	self.spooc.HEALTH_INIT = self.spooc.HEALTH_INIT * base + (wave / divider)
	self.shield.HEALTH_INIT = self.shield.HEALTH_INIT * base + (wave / divider)
	self.phalanx_minion.HEALTH_INIT = self.phalanx_minion.HEALTH_INIT * base + (wave / divider)
	self.phalanx_vip.HEALTH_INIT = self.phalanx_vip.HEALTH_INIT * base + (wave / divider)
	self.taser.HEALTH_INIT = self.taser.HEALTH_INIT * base + (wave / divider)
	self.city_swat.HEALTH_INIT = self.city_swat.HEALTH_INIT * base + (wave / divider)
	self.biker_escape.HEALTH_INIT = self.biker_escape.HEALTH_INIT * base + (wave / divider)
	self.fbi_swat.HEALTH_INIT = self.fbi_swat.HEALTH_INIT * base + (wave / divider)
	self.tank_hw.HEALTH_INIT = self.tank_hw.HEALTH_INIT * base + (wave / divider)
	self.medic.HEALTH_INIT = self.medic.HEALTH_INIT * base + (wave / divider)
	self.bolivian.HEALTH_INIT = self.bolivian.HEALTH_INIT * base + (wave / divider)
	self.bolivian_indoors.HEALTH_INIT = self.bolivian_indoors.HEALTH_INIT * base + (wave / divider)
	self.drug_lord_boss.HEALTH_INIT = self.drug_lord_boss.HEALTH_INIT * base + (wave / divider)
	self.drug_lord_boss_stealth.HEALTH_INIT = self.drug_lord_boss_stealth.HEALTH_INIT * base + (wave / divider)
	self.shadow_spooc.HEALTH_INIT = self.shadow_spooc.HEALTH_INIT * base + (wave / divider)
end

SkyHook:Post(CharacterTweakData, "_init_fbi", function(self, presets)
	SkyLib:log("ZM CTD fbi INIT")
	self.fbi.surrender = nil
	self.fbi.rescue_hostages = false
	self.fbi.allowed_poses = {crouch = false, stand = true}
	self.fbi.dodge = nil
	self.fbi.no_retreat = true
	self.fbi.no_arrest = true
	self.fbi.move_speed = presets.move_speed.very_fast
	self.fbi.damage.hurt_severity = presets.hurt_severities.only_light_hurt
	self.fbi.weapon = deep_clone(presets.weapon.good)
	self.fbi.weapon.is_rifle.focus_delay = 1
	self.fbi.weapon.is_smg.focus_delay = 1
end)

SkyHook:Post(CharacterTweakData, "_init_swat", function(self, presets)
	SkyLib:log("ZM CTD swat INIT")
	self.swat.surrender = nil
	self.swat.rescue_hostages = false
	self.swat.allowed_poses = {crouch = false, stand = true}
	self.swat.dodge = nil
	self.swat.no_retreat = true
	self.swat.no_arrest = true
	self.swat.move_speed = presets.move_speed.very_fast
	self.swat.damage.hurt_severity = presets.hurt_severities.only_light_hurt
	self.swat.weapon = deep_clone(presets.weapon.good)
	self.swat.weapon.is_rifle.focus_delay = 1
	self.swat.weapon.is_smg.focus_delay = 1
	self.swat.weapon.is_shotgun_pump.focus_delay = 1
end)

SkyHook:Post(CharacterTweakData, "_init_heavy_swat", function(self, presets)
	SkyLib:log("ZM CTD heavyswat INIT")
	self.heavy_swat.surrender = nil
	self.heavy_swat.rescue_hostages = false
	self.heavy_swat.allowed_poses = {crouch = false, stand = true}
	self.heavy_swat.dodge = nil
	self.heavy_swat.no_retreat = true
	self.heavy_swat.no_arrest = true
	self.heavy_swat.move_speed = presets.move_speed.very_fast
	self.heavy_swat.damage.hurt_severity = presets.hurt_severities.only_light_hurt
	self.heavy_swat.weapon = deep_clone(presets.weapon.good)
	self.heavy_swat.weapon.is_rifle.focus_delay = 1
	self.heavy_swat.weapon.is_smg.focus_delay = 1
	self.heavy_swat.weapon.is_shotgun_pump.focus_delay = 1
end)

SkyHook:Post(CharacterTweakData, "_init_fbi_swat", function(self, presets)
	SkyLib:log("ZM CTD fbiswat INIT")
	self.fbi_swat.surrender = nil
	self.fbi_swat.rescue_hostages = false
	self.fbi_swat.allowed_poses = {crouch = false, stand = true}
	self.fbi_swat.dodge = nil
	self.fbi_swat.no_retreat = true
	self.fbi_swat.no_arrest = true
	self.fbi_swat.move_speed = presets.move_speed.very_fast
	self.fbi_swat.damage.hurt_severity = presets.hurt_severities.only_light_hurt
	self.fbi_swat.weapon = deep_clone(presets.weapon.good)
	self.fbi_swat.weapon.is_rifle.focus_delay = 1
	self.fbi_swat.weapon.is_smg.focus_delay = 1
	self.fbi_swat.weapon.is_shotgun_pump.focus_delay = 1
end)

SkyHook:Post(CharacterTweakData, "_init_fbi_heavy_swat", function(self, presets)
	SkyLib:log("ZM CTD fbiheavyswat INIT")
	self.fbi_heavy_swat.surrender = nil
	self.fbi_heavy_swat.rescue_hostages = false
	self.fbi_heavy_swat.allowed_poses = {crouch = false, stand = true}
	self.fbi_heavy_swat.dodge = nil
	self.fbi_heavy_swat.no_retreat = true
	self.fbi_heavy_swat.no_arrest = true
	self.fbi_heavy_swat.move_speed = presets.move_speed.very_fast
	self.fbi_heavy_swat.damage.hurt_severity = presets.hurt_severities.only_light_hurt
	self.fbi_heavy_swat.weapon = deep_clone(presets.weapon.good)
	self.fbi_heavy_swat.weapon.is_rifle.focus_delay = 1
	self.fbi_heavy_swat.weapon.is_smg.focus_delay = 1
	self.fbi_heavy_swat.weapon.is_shotgun_pump.focus_delay = 1
end)

SkyHook:Post(CharacterTweakData, "_init_city_swat", function(self, presets)
	SkyLib:log("ZM CTD cityswat INIT")
	self.city_swat.surrender = nil
	self.city_swat.rescue_hostages = false
	self.city_swat.allowed_poses = {crouch = false, stand = true}
	self.city_swat.dodge = nil
	self.city_swat.no_retreat = true
	self.city_swat.no_arrest = true
	self.city_swat.move_speed = presets.move_speed.very_fast
	self.city_swat.damage.hurt_severity = presets.hurt_severities.only_light_hurt
	self.city_swat.weapon = deep_clone(presets.weapon.good)
	self.city_swat.weapon.is_rifle.focus_delay = 1
	self.city_swat.weapon.is_smg.focus_delay = 1
	self.city_swat.weapon.is_shotgun_pump.focus_delay = 1
end)

SkyHook:Post(CharacterTweakData, "_init_medic", function(self, presets)
	SkyLib:log("ZM CTD medic INIT")
	self.medic.rescue_hostages = false
	self.medic.suppression = nil
	self.medic.allowed_poses = {crouch = false, stand = true}
	self.medic.dodge = nil
	self.medic.no_retreat = true
	self.medic.no_arrest = true
	self.medic.move_speed = presets.move_speed.very_fast
	self.medic.weapon = deep_clone(presets.weapon.normal)
	self.medic.weapon.is_rifle.focus_delay = 1
	self.medic.weapon.is_shotgun_pump.focus_delay = 1
end)

SkyHook:Post(CharacterTweakData, "_init_taser", function(self, presets)
	SkyLib:log("ZM CTD taser INIT")
	self.taser.dodge = nil
	self.taser.no_retreat = true
	self.taser.no_arrest = true
	self.taser.allowed_poses = {crouch = false, stand = true}
	self.taser.move_speed = presets.move_speed.very_fast
	self.taser.weapon.is_rifle.focus_delay = 1
end)

SkyHook:Post(CharacterTweakData, "_init_spooc", function(self, presets)
	SkyLib:log("ZM CTD spooc INIT")
	self.spooc.allowed_poses = {crouch = false, stand = true}
	self.spooc.weapon.is_smg.focus_delay = 1
end)

SkyHook:Post(CharacterTweakData, "_init_tank", function(self, presets)
	SkyLib:log("ZM CTD tank INIT")
	self.tank.weapon.is_shotgun_mag.focus_delay = 1
	self.tank.weapon.is_rifle.focus_delay = 1
	self.tank.weapon.is_lmg.focus_delay = 1
	self.tank_hw.HEALTH_INIT = 500
end)
--hooks gets set too late, need to reinit
tweak_data.character:init(tweak_data)