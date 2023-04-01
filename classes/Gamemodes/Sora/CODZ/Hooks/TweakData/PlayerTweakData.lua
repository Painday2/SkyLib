SkyHook:Post(PlayerTweakData, "init", function(self)
	SkyLib:log("ZM playertweakdata INIT")
	self.damage.respawn_time_penalty = 0
	self.damage.base_respawn_time_penalty = 1
end)

