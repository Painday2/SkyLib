SkyHook:Post(UpgradesTweakData, "_init_pd2_values", function(self)
	SkyLib:log("ZM UTD pd2values INIT")
	--ABSOLUTELY DISGUSTING DON'T FUCKING USE THIS BUT SKYLIB STUFF INIT'S AFTER TWEAKDATA
	if BeardLib then
		local current_level = BeardLib.current_level or ""
		if current_level == "" and not current_level._mod then
			SkyLib:log("pain")
			return
		elseif current_level._mod and current_level._mod.global then
			SkyLib:log("global")
			self.explosive_bullet.player_dmg_mul = 0.01
			self.explosive_bullet.range = 400
		else
			SkyLib:log("else")
		end
	end
end)