Hooks:PostHook(PlayerTweakData, "init", "zm_no_penalty_timer", function(self)
	self.damage.respawn_time_penalty = 0
	self.damage.base_respawn_time_penalty = 1
end)

