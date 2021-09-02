core:import("CoreMissionScriptElement")
ElementPlayVideo = ElementPlayVideo or class(CoreMissionScriptElement.MissionScriptElement)

function ElementPlayVideo:init(...)
	ElementPlayVideo.super.init(self, ...)
end
function ElementPlayVideo:client_on_executed(...)
	self:on_executed(...)
end

function ElementPlayVideo:on_executed(instigator)

	if not self._values.enabled then
		self._mission_script:debug_output("Element '" .. self._editor_name .. "' not enabled. Skip.", Color(1, 1, 0, 0))
		return
	end

	if instigator == managers.player:player_unit() then
		managers.wdu:_play_teleporter_transition()
	end

	ElementPlayVideo.super.on_executed(self, instigator)
end

function ElementPlayVideo:on_script_activated()
    self._mission_script:add_save_state_cb(self._id)
end

function ElementPlayVideo:save(data)
    data.save_me = true
    data.enabled = self._values.enabled
end

function ElementPlayVideo:load(data)
    self:set_enabled(data.enabled)
end
