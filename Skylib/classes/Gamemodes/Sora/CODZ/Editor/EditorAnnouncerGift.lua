EditorAnnouncerGift = EditorAnnouncerGift or class(MissionScriptEditor)
function EditorAnnouncerGift:create_element()
	self.super.create_element(self)
	self._element.class = "ElementAnnouncerGift"
end

function EditorAnnouncerGift:_build_panel()
	self:_create_panel()
	self:ComboCtrl("gift_id", {"max_ammo", "instakill", "instakill_disable", "double_points", "double_points_disable", "firesale", "firesale_first", "firesale_disable", "present", "kaboom"})
end
