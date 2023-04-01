function PlayerParachuting:exit(state_data, new_state_name)
	print("[PlayerParachuting:exit]", "Exiting parachuting state")
	PlayerParachuting.super.exit(self, state_data)
	self._unit:mover():set_damping(self._original_damping or 1)
	self:_remove_camera_limits()

	self._state_data.in_air = false

	self.parachuting = false
end

function PlayerParachuting:enter(state_data, enter_data)
	print("[PlayerParachuting:enter]", "Enter parachuting state")
	PlayerParachuting.super.enter(self, state_data, enter_data)

	if self._state_data.ducking then
		self:_end_action_ducking()
	end

	self._original_damping = self._unit:mover():damping()

	self._unit:mover():set_damping(self._tweak_data.gravity / self._tweak_data.terminal_velocity)

	self.parachuting = true
end