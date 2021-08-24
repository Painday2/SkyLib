ZMPackAPunchExt = ZMPackAPunchExt or class(UseInteractionExt)

function ZMPackAPunchExt:selected(player, locator, hand_id)
	if not self:can_select(player) then
		return
	end

	self._hand_id = hand_id
	self._is_selected = true
	local string_macros = {}

	self:_add_string_macros(string_macros)

	local text = ""
	local icon = ""
	local current_money = SkyLib.CODZ:_get_own_money()
	local cost

	--Is a Zombie Mode Interaction?
	if self._tweak_data.zm_interaction then
		cost = self._unit:unit_data().cost or self._tweak_data.points_cost or 0
		text = "Hold " .. managers.localization:btn_macro("interact") .. " to buy"

		if self._tweak_data.pack_a_punch then
			text = "Hold " .. managers.localization:btn_macro("interact") .. " to upgrade your weapon"

			if current_money >= cost then
				text = text .. " [Cost : " .. cost .. "]"
			else
				local points_needed = cost - current_money
				text = "You need " .. points_needed .. " more points to upgrade your weapon"
			end
		end
    end
	managers.hud:show_interact({
		text = text,
		icon = icon
	})

	return true
end

function ZMPackAPunchExt:interact(player)
    if player then
        SkyLib.CODZ.WeaponHelper:_perform_weapon_switch(false, player, false, false, true)
        
        if self._unit:damage() then
            self._unit:damage():run_sequence_simple("interact", {unit = player})
        end
    end
end