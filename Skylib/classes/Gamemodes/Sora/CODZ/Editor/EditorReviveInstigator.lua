EditorReviveInstigator = EditorReviveInstigator or class(MissionScriptEditor)
function EditorReviveInstigator:create_element()
	self.super.create_element(self)
	self._element.class = "ElementReviveInstigator"
end

function EditorReviveInstigator:_build_panel()
	self:_create_panel()
end