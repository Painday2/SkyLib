EditorPointChecker = EditorPointChecker or class(MissionScriptEditor)
function EditorPointChecker:create_element()
	self.super.create_element(self)
	self._element.class = "ElementPointChecker"
end

function EditorPointChecker:_build_panel()
	self:_create_panel()
	self:StringCtrl("cost")
end
