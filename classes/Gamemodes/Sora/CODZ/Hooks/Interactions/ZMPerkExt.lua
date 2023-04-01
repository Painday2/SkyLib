ZMPerkExt = ZMPerkExt or class(SpecialEquipmentInteractionExt)

function ZMPerkExt:selected(player, locator, hand_id)
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

		--Is a ZM Perk Interaction?
		if self._tweak_data.perk then
			local item = self._tweak_data.perk

			if self._tweak_data.special_equipment and not managers.player:has_special_equipment(self._tweak_data.special_equipment) then
				local has_special_equipment = false
				if self._tweak_data.possible_special_equipment then
					for i, special_equipment in ipairs(self._tweak_data.possible_special_equipment) do
						if managers.player:has_special_equipment(special_equipment) then
							has_special_equipment = true

							break
						end
					end
				end

				if not has_special_equipment then
					text = managers.localization:text(self._tweak_data.equipment_text_id, string_macros)
					icon = self.no_equipment_icon or self._tweak_data.no_equipment_icon or icon
				end

				managers.hud:show_interact({
					text = text,
					icon = icon
				})

				return true
			end

			if current_money >= cost then
				text = text .. " " .. item
				text = text .. " [Cost : " .. cost .. "]"
			else
				local points_needed = cost - current_money
				text = "You need " .. points_needed .. " more points to buy " .. item
			end
		end

	managers.hud:show_interact({
		text = text,
		icon = icon
	})

	return true
    end
end