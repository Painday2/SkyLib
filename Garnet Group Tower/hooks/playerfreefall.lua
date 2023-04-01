function PlayerFreefall:enter(state_data, enter_data)
	print("[PlayerFreefall:enter]", "Enter freefall state")
	PlayerFreefall.super.enter(self, state_data, enter_data)

	if self._state_data.ducking then
		self:_end_action_ducking()
	end

	self:_interupt_action_steelsight()
	self:_interupt_action_melee(managers.player:player_timer():time())
	self:_interupt_action_ladder(managers.player:player_timer():time())

	local projectile_entry = managers.blackmarket:equipped_projectile()

	if tweak_data.blackmarket.projectiles[projectile_entry].is_a_grenade then
		self:_interupt_action_throw_grenade(managers.player:player_timer():time())
	else
		self:_interupt_action_throw_projectile(managers.player:player_timer():time())
	end

	self:_interupt_action_charging_weapon(managers.player:player_timer():time())

	self._original_damping = self._unit:mover():damping()

	self._unit:mover():set_damping(self._tweak_data.gravity / self._tweak_data.terminal_velocity)
	self._unit:sound():play("skydive", nil, false)
end