core:import("CoreMissionScriptElement")
ElementDynamicEnvironment = ElementDynamicEnvironment or class(CoreMissionScriptElement.MissionScriptElement)

function ElementDynamicEnvironment:init(...)
	ElementDynamicEnvironment.super.init(self, ...)
end
function ElementDynamicEnvironment:client_on_executed(...)
	self:on_executed(...)
end

function ElementDynamicEnvironment:on_executed(instigator)
	
	if not self._values.enabled then
		self._mission_script:debug_output("Element '" .. self._editor_name .. "' not enabled. Skip.", Color(1, 1, 0, 0))
		return
	end

	managers.viewport:set_default_environment(self._values.environment_path, self._values.blend_time, nil)
	self._mission_script:debug_output("Element '" .. self._editor_name .. "' executed. Environment switching...", Color(1, 0, 1, 0))
	ElementDynamicEnvironment.super.on_executed(self, instigator)
end

function ElementDynamicEnvironment:on_script_activated()
    self._mission_script:add_save_state_cb(self._id)
end

function ElementDynamicEnvironment:save(data)
    data.save_me = true
    data.enabled = self._values.enabled
end

function ElementDynamicEnvironment:load(data)
    self:set_enabled(data.enabled)
end