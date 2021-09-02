core:import("CoreMissionScriptElement")
ElementCheckSecret = ElementCheckSecret or class(CoreMissionScriptElement.MissionScriptElement)

function ElementCheckSecret:init(...)
	ElementCheckSecret.super.init(self, ...)
end
function ElementCheckSecret:client_on_executed(...)
	self:on_executed(...)
end

function ElementCheckSecret:on_executed(instigator)

	if not self._values.enabled then
		self._mission_script:debug_output("Element '" .. self._editor_name .. "' not enabled. Skip.", Color(1, 1, 0, 0))
		return
    end
    
    local secret_key = managers.mission:get_saved_job_value(self._values.secret_key)

    if not secret_key then
        return
    end

	ElementCheckSecret.super.on_executed(self, instigator)
end

function ElementCheckSecret:on_script_activated()
    self._mission_script:add_save_state_cb(self._id)
end

function ElementCheckSecret:save(data)
    data.save_me = true
    data.enabled = self._values.enabled
end

function ElementCheckSecret:load(data)
    self:set_enabled(data.enabled)
end
