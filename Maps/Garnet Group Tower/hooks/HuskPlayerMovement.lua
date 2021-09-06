function HuskPlayerMovement:_sync_movement_state_parachute(event_descriptor)
	self._unit:inventory():hide_equipped_unit()
	self:play_redirect("freefall_to_parachute")

	self._sync_look_dir = self._look_dir
	self._terminal_velocity = tweak_data.player.parachute.terminal_velocity
	self._damping = tweak_data.player.parachute.gravity / tweak_data.player.parachute.terminal_velocity
	self._gravity = tweak_data.player.parachute.gravity
	self._anim_name = "parachute"

	if self._atention_on then
		self._machine:forbid_modifier(self._look_modifier_name)
		self._machine:forbid_modifier(self._head_modifier_name)
		self._machine:forbid_modifier(self._arm_modifier_name)
		self._machine:forbid_modifier(self._mask_off_modifier_name)

		self._atention_on = false
	end
end