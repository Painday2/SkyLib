function PlayerMovement:_max_stamina()
    local base_stamina = self._STAMINA_INIT + managers.player:stamina_addend()
    local staminup = managers.player:has_special_equipment("perk_staminup") and 2 or 1
    local max_stamina = base_stamina * managers.player:body_armor_value("stamina") * managers.player:stamina_multiplier() * staminup

	managers.hud:set_max_stamina(max_stamina)

	return max_stamina
end