SkyHook:Post(EquipmentsTweakData, "init", function(self)
	--these will always be there but gamemode loading is too late for it to work and a reinit doesn't help.
	--i could probably find a way, but i'm lazy and this isn't too bad so...
    local perks = {"perk_juggernog", "perk_speedcola", "perk_doubletap", "perk_deadshot", "perk_staminup", "perk_flopper","perk_cherry","perk_vulture","perk_widows","perk_armor", "perk_god"}
	for i, v in ipairs(perks) do
		self.specials[v] = {
			sync_possession = true,
			transfer_quantity = 0,
			icon = v,
			text_id = "hud_" .. v
		}
	end
	self.specials.zm_power_on = {
        sync_possession = true,
		transfer_quantity = 0,
		icon = "zm_power_on",
		text_id = "hud_zm_power_on"
    }

	self.specials.key_doubletap = {
		sync_possession = true,
		action_message = "key_doubletap_obtained",
		transfer_quantity = 4,
		text_id = "hud_key_doubletap",
		icon = "hud_perk_doubletap"
	}
end)