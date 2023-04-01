EditorSoraCinematicCamera = EditorSoraCinematicCamera or class(MissionScriptEditor)
function EditorSoraCinematicCamera:create_element()
	self.super.create_element(self)
	self._element.class = "ElementSoraCinematicCamera"
end

function EditorSoraCinematicCamera:_build_panel()
	self:_create_panel()
	self:Text("Create a camera to element's position/rotation.")
end

function EditorSoraCinematicCamera:update_selected(time, rel_time)
    local brush = Draw:brush(Color.white:with_alpha((1 - (math.sin(time * 100) + 1) / 2) * 0.15))
	local len = (math.sin(time * 100) + 1) / 2 * 3000

    brush:cone(self._unit:position(), self._unit:position() + self._unit:rotation():y() * len, len)
    brush:set_color(Color.white:with_alpha(0.15))
    brush:cone(self._unit:position(), self._unit:position() + self._unit:rotation():y() * 3000, 85)
    Application:draw_cone(
        self._unit:position(),
        self._unit:position() + self._unit:rotation():y() * 3000,
        3000,
        0.75,
        0.75,
        0.75,
        0.1
    )
end