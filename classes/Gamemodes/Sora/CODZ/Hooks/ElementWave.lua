core:import("CoreMissionScriptElement")
ElementWave = ElementWave or class(CoreMissionScriptElement.MissionScriptElement)

function ElementWave:init(...)
    ElementWave.super.init(self, ...)
    
    self._paused = false
    self._stopped = false
end

function ElementWave:client_on_executed(...)
	self:on_executed(...)
end

function ElementWave:on_executed(instigator)
    if not self._values.enabled then
		return
    end

    if self._stopped then
        return
    end

    if self._values.increase_kill then
        SkyLib.CODZ:_increase_wave_kills()
        return
    end

    if SkyLib.CODZ:_get_current_wave() > 0 then
        managers.player:add_grenade_amount(2, true)
    end

    SkyLib.CODZ:_increase_wave()
    managers.hud._hud_codz:_wave_change_anim(SkyLib.CODZ:_get_current_wave())
    SkyLib.CODZ:_reset_wave_kills()
    SkyLib.CODZ:_respawn_players()

    ElementWave.super.on_executed(self, instigator)
end

function ElementWave:pause_wave()
    self._paused = true
end

function ElementWave:resume_wave()
    self._paused = false
end

function ElementWave:reset_wave()
end

function ElementWave:stop_wave()
    self._stopped = true
end

function ElementWave:on_script_activated()
    self._mission_script:add_save_state_cb(self._id)
end

function ElementWave:save(data)
    data.save_me = true
    data.enabled = self._values.enabled
end

function ElementWave:load(data)
    self:set_enabled(data.enabled)
end





ElementWaveOperator = ElementWaveOperator or class(CoreMissionScriptElement.MissionScriptElement)

function ElementWaveOperator:init(...)
	ElementWaveOperator.super.init(self, ...)
end

function ElementWaveOperator:client_on_executed(...)
	self:on_executed(...)
end

function ElementWaveOperator:on_executed(instigator)
    if not self._values.enabled then
		return
    end
    
    for _, id in ipairs(self._values.elements) do
		local element = self:get_mission_element(id)

        if element then
            if self._values.operation == "pause" then
                element:pause_wave()
            elseif self._values.operation == "stop" then
                element:stop_wave()
            elseif self._values.operation == "reset" then
                element:reset_wave()
            elseif self._values.operation == "resume" then
                element:resume_wave()
            end
        end
    end

    ElementWaveOperator.super.on_executed(self, instigator)
end

function ElementWaveOperator:on_script_activated()
    self._mission_script:add_save_state_cb(self._id)
end

function ElementWaveOperator:save(data)
    data.save_me = true
    data.enabled = self._values.enabled
end

function ElementWaveOperator:load(data)
    self:set_enabled(data.enabled)
end





ElementWaveTrigger = ElementWaveTrigger or class(CoreMissionScriptElement.MissionScriptElement)

function ElementWaveTrigger:init(...)
	ElementWaveTrigger.super.init(self, ...)
end

function ElementWaveTrigger:client_on_executed(...)
	self:on_executed(...)
end

function ElementWaveTrigger:on_executed(instigator)
    if not self._values.enabled then
		return
    end

    local trigger_on = self._values.trigger
    local pass = false

    local codz = SkyLib.CODZ
    local is_special_wave = codz._level.wave.is_special_wave
    local current_zombies_spawned = codz._level.zombies.currently_spawned
    local current_zombies_killed = codz._level.zombies.killed
    local max_zombies_spawns = is_special_wave and codz._level.zombies.max_special_wave_total_spawns or codz._level.zombies.max_spawns

    local is_first = current_zombies_killed == 1 and true or false
    local is_last = current_zombies_killed == max_zombies_spawns and true or false
    local half_done = current_zombies_killed == (max_zombies_spawns / 2) and true or false

    if trigger_on == "is_special_wave" then
        if is_special_wave then
            pass = true
        end
    elseif trigger_on == "first_zombie_killed" then
        if is_first then
            pass = true
        end
    elseif trigger_on == "last_zombie_killed" then
        if is_last then
            pass = true
        end
    elseif trigger_on == "half_killed" then
        if half_done then
            pass = true
        end
    end

    if pass then
        ElementWaveTrigger.super.on_executed(self, instigator)
    end
end

function ElementWaveTrigger:on_script_activated()
    self._mission_script:add_save_state_cb(self._id)
end

function ElementWaveTrigger:save(data)
    data.save_me = true
    data.enabled = self._values.enabled
end

function ElementWaveTrigger:load(data)
    self:set_enabled(data.enabled)
end