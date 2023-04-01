SkyHook:Post(UpgradesTweakData, "_init_pd2_values", function(self)
	--ABSOLUTELY DISGUSTING DON'T FUCKING USE THIS BUT SKYLIB STUFF INIT'S AFTER TWEAKDATA
	if BeardLib then
		local current_level = BeardLib.current_level or ""
		if current_level == "" and not current_level._mod then
			log("pain")
			return
		elseif current_level._mod and current_level._mod.global then
			log("global")
			self.explosive_bullet.player_dmg_mul = 0.01
			self.explosive_bullet.range = 400
		else
			log("else")
		end
	end
end)