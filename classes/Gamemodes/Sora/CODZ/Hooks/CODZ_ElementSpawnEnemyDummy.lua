function ElementSpawnEnemyDummy:produce(params)
	if not managers.groupai:state():is_AI_enabled() then
		return
	end

    local unit = nil

	if params and params.name then
		unit = safe_spawn_unit(params.name, self:get_orientation())
		local spawn_ai = self:_create_spawn_AI_parametric(params.stance, params.objective, self._values)

		unit:brain():set_spawn_ai(spawn_ai)
	else
		local enemy_name = self:value("enemy") or self._enemy_name
		unit = safe_spawn_unit(enemy_name, self:get_orientation())
		local objective = nil
		local action = self._create_action_data(CopActionAct._act_redirects.enemy_spawn[self._values.spawn_action])
		local stance = managers.groupai:state():enemy_weapons_hot() and "cbt" or "ntl"

		if action.type == "act" then
			objective = {
				type = "act",
				action = action,
				stance = stance
			}
		end

		local spawn_ai = {
			init_state = "idle",
			objective = objective
		}

		unit:brain():set_spawn_ai(spawn_ai)

		local team_id = params and params.team or self._values.team or tweak_data.levels:get_default_team_ID(unit:base():char_tweak().access == "gangster" and "gangster" or "combatant")

		if self._values.participate_to_group_ai then
			managers.groupai:state():assign_enemy_to_group_ai(unit, team_id)
		else
			managers.groupai:state():set_char_team(unit, team_id)
		end

		if self._values.voice then
			unit:sound():set_voice_prefix(self._values.voice)
		end
	end

	unit:base():add_destroy_listener(self._unit_destroy_clbk_key, callback(self, self, "clbk_unit_destroyed"))

	unit:unit_data().mission_element = self

	table.insert(self._units, unit)
	self:event("spawn", unit)

	if self._values.force_pickup and self._values.force_pickup ~= "none" then
		local pickup_name = self._values.force_pickup ~= "no_pickup" and self._values.force_pickup or nil

		unit:character_damage():set_pickup(pickup_name)
	end

	return unit
end