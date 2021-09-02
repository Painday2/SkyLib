core:import("CoreMissionScriptElement")
ElementSoraCinematicCamera = ElementSoraCinematicCamera or class(CoreMissionScriptElement.MissionScriptElement)

function ElementSoraCinematicCamera:init(...)
	ElementSoraCinematicCamera.super.init(self, ...)
end
function ElementSoraCinematicCamera:client_on_executed(...)
	self:on_executed(...)
end

function ElementSoraCinematicCamera:on_executed(instigator)

	if not self._values.enabled then
		self._mission_script:debug_output("Element '" .. self._editor_name .. "' not enabled. Skip.", Color(1, 1, 0, 0))
		return
    end
    
    local lifetime = self._values.lifetime or 6

    self._camera_object = World:create_camera()
    self._camera_object:set_near_range(20)
    self._camera_object:set_far_range(5000000)
    self._camera_object:set_fov(85)
    self._camera_object:set_position(self._values.position)
    self._camera_object:set_rotation(self._values.rotation)

    self._vp = managers.viewport:new_vp(0, 0, 1, 1, "ElementSoraCinematicCamera_" .. self._editor_name, 1)
    self._vp:set_camera(self._camera_object)
    self._vp:set_active(true)

    DelayedCalls:Add("zm_deactivate_camera_" .. self._editor_name, lifetime, function()
        self._vp:set_active(false)
    end)

	ElementSoraCinematicCamera.super.on_executed(self, instigator)
end

function ElementSoraCinematicCamera:on_script_activated()
    self._mission_script:add_save_state_cb(self._id)
end

function ElementSoraCinematicCamera:save(data)
    data.save_me = true
    data.enabled = self._values.enabled
end

function ElementSoraCinematicCamera:load(data)
    self:set_enabled(data.enabled)
end
