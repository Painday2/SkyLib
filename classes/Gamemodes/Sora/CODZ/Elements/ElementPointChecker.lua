core:import("CoreMissionScriptElement")
ElementPointChecker = ElementPointChecker or class(CoreMissionScriptElement.MissionScriptElement)

function ElementPointChecker:init(...)
	ElementPointChecker.super.init(self, ...)
end
function ElementPointChecker:client_on_executed(...)
	self:on_executed(...)
end

function ElementPointChecker:on_executed(instigator)

	if not self._values.enabled then
		self._mission_script:debug_output("Element '" .. self._editor_name .. "' not enabled. Skip.", Color(1, 1, 0, 0))
		return
	end

	SkyLib.Sound:Play({
		name = self._editor_name .. "_" .. self._id,
		custom_dir = "sound",
		custom_package = "SkyLib-zm-assets",
		file_name = "cashin.ogg",
		sound_type = "sfx",
		is_3d = true,
		position = self._values.position
	})

	ElementPointChecker.super.on_executed(self, instigator)
end

function ElementPointChecker:on_script_activated()
    self._mission_script:add_save_state_cb(self._id)
end

function ElementPointChecker:save(data)
    data.save_me = true
    data.enabled = self._values.enabled
end

function ElementPointChecker:load(data)
    self:set_enabled(data.enabled)
end
