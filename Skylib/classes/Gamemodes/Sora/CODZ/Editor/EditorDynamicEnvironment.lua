EditorDynamicEnvironment = EditorDynamicEnvironment or class(MissionScriptEditor)
function EditorDynamicEnvironment:create_element()
	self.super.create_element(self)
	self._element.class = "ElementDynamicEnvironment"
end

function EditorDynamicEnvironment:_build_panel()
	self:_create_panel()
	self:StringCtrl("environment_path")
	self:NumberCtrl("blend_time")
end
