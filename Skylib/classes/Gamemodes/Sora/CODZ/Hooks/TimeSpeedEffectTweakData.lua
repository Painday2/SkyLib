Hooks:PostHook(TimeSpeedEffectTweakData, "_init_base_effects", "zm_post_no_slowmo_shit", function(self)
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