EditorPlayEnd = EditorPlayEnd or class(MissionScriptEditor)
function EditorPlayEnd:create_element()
	self.super.create_element(self)
	self._element.class = "ElementPlayEnd"
end

function EditorPlayEnd:_build_panel()
	self:_create_panel()
end