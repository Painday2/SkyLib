Hooks:PostHook(PlayerTweakData, "init", "zm_no_penalty_timer", function(self)
	self.damage.respawn_time_penalty = 0
	self.damage.base_respawn_time_penalty = 1
end)

Hooks:PostHook(PlayerTweakData, "_init_new_stances", "zm_init_new_stances", function(self)
    self.stances.nothing2_primary = deep_clone(self.stances.default)
    self.stances.nothing2_primary.standard.shoulders.translation = Vector3(1, 999999999, 0.2)
    self.stances.nothing2_primary.steelsight.shoulders.translation = Vector3(1, 999999999, 0.2)
    self.stances.nothing2_primary.crouched.shoulders.translation = Vector3(1, 999999999, -0.2)

	self.stances.wunderwaffe_primary = deep_clone(self.stances.default)
	local pivot_shoulder_translation = Vector3(10.5287, 10.4677, 0.247723)
	local pivot_shoulder_rotation = Rotation(0.000398715, -0.000868289, -0.000330621)
	local pivot_head_translation = Vector3(10, 14, 1)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.wunderwaffe_primary.standard.shoulders.translation = Vector3(-0.777, 5.503, 4.127)
	self.stances.wunderwaffe_primary.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.wunderwaffe_primary.standard.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -86, 0)
	local pivot_head_translation = Vector3(0, 20, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.wunderwaffe_primary.steelsight.shoulders.translation = Vector3(-10.529, 9.532, 2)
	self.stances.wunderwaffe_primary.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.wunderwaffe_primary.steelsight.zoom_fov = false
	self.stances.wunderwaffe_primary.steelsight.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -50, 0)
	self.stances.wunderwaffe_primary.steelsight.vel_overshot.yaw_neg = 0
	self.stances.wunderwaffe_primary.steelsight.vel_overshot.yaw_pos = -0
	self.stances.wunderwaffe_primary.steelsight.vel_overshot.pitch_neg = -0
	self.stances.wunderwaffe_primary.steelsight.vel_overshot.pitch_pos = 0
	local pivot_head_translation = Vector3(9, 13, -1)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.wunderwaffe_primary.crouched.shoulders.translation = Vector3(-0.777, 5.503, 4.127)
	self.stances.wunderwaffe_primary.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.wunderwaffe_primary.crouched.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -36, 0)

	self.stances.wunderwaffe_secondary = deep_clone(self.stances.wunderwaffe_primary)
	self.stances.wunderwaffe_dg3_primary = deep_clone(self.stances.wunderwaffe_primary)
	self.stances.wunderwaffe_dg3_secondary = deep_clone(self.stances.wunderwaffe_primary)

	self.stances.elastic_primary = deep_clone(self.stances.elastic)
	self.stances.elastic_secondary = deep_clone(self.stances.elastic)
	self.stances.elastic_upg_primary = deep_clone(self.stances.elastic)
	self.stances.elastic_upg_primary.standard.shoulders.translation = Vector3(-5.696, -20.377, 10.841)
	self.stances.elastic_upg_primary.standard.shoulders.rotation = Rotation(0.00215024, -0.0345012, 0.00130212, -0.999402)
	self.stances.elastic_upg_primary.steelsight.shoulders.translation = Vector3(-5.603, -5.377, 10.807)
	self.stances.elastic_upg_primary.steelsight.shoulders.rotation = Rotation(0.000160639, 0.0440202, 0.00246083, -0.999028)
	self.stances.elastic_upg_secondary = deep_clone(self.stances.elastic_upg_primary)

	self.stances.raygun_primary = deep_clone(self.stances.breech)
	self.stances.raygun_primary.standard.shoulders.translation = Vector3(1.784, -0.432, -4.207)
	self.stances.raygun_primary.steelsight.shoulders.translation = Vector3(-8.000, 0.668, -6.207)
	self.stances.raygun_primary.steelsight.shoulders.rotation = Rotation(-0.018108, -4.61179e-006, 0.00141215, -0.999835)
	self.stances.raygun_primary.crouched.shoulders.translation = Vector3(0.783923, -1.43154, -5.207)
	self.stances.raygun_secondary = deep_clone(self.stances.raygun_primary)
	self.stances.raygun_upg_primary = deep_clone(self.stances.raygun_primary)
	self.stances.raygun_upg_secondary = deep_clone(self.stances.raygun_primary)
end)
