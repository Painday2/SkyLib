EditorPlayVideo = EditorPlayVideo or class(MissionScriptEditor)
function EditorPlayVideo:create_element()
	self.super.create_element(self)
	self._element.class = "ElementPlayVideo"
end

function EditorPlayVideo:_build_panel()
	self:_create_panel()
end
