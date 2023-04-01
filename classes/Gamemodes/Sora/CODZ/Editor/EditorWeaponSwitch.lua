EditorWeaponSwitch = EditorWeaponSwitch or class(MissionScriptEditor)
function EditorWeaponSwitch:create_element()
	self.super.create_element(self)
	self._element.class = "ElementWeaponSwitch"
end

function EditorWeaponSwitch:_build_panel()
	self:_create_panel()
	self:StringCtrl("weapon_id")
    self:BooleanCtrl("force_secondary")
    self:BooleanCtrl("force_primary")
	self:StringCtrl("skin_id")
	self:BooleanCtrl("is_pap_engine")
	self:BooleanCtrl("is_mystery_box")
	self:BooleanCtrl("is_grenade_spot")
end
