SkyHook:Post(TimeSpeedEffectTweakData, "_init_base_effects", function(self)
	SkyLib:log("ZM TimeSpeedEffect base effects INIT")
	self.downed = {
		speed = 1,
		fade_in = 0,
		sustain = 0,
		fade_out = 0,
		timer = "pausable"
	}
	self.downed_player = {
		speed = 1,
		fade_in = 0,
		sustain = 0,
		fade_out = 0,
		timer = self.downed.timer,
		affect_timer = "player"
	}
end)