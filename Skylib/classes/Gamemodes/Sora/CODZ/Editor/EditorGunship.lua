EditorGunship = EditorGunship or class(MissionScriptEditor)
function EditorGunship:create_element()
	self.super.create_element(self)
	self._element.class = "ElementGunship"
end

function EditorGunship:_build_panel()
	self:_create_panel()
end
