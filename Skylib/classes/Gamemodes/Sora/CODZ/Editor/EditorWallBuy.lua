EditorWallBuy = EditorWallBuy or class(MissionScriptEditor)
function EditorWallBuy:init(...)
	local unit = "units/pd2_mod_zombies/props/zm_wallbuy_dummy/zm_wallbuy_dummy"
	local assets = self:GetPart("world")._assets_manager
	if not PackageManager:has(Idstring("unit"), Idstring(unit)) and assets then
		BeardLibEditor.Utils:QuickDialog({title = "An error appears!", message = "This element requires the interaction dummy unit to be loaded or else it won't work!"}, {{"Load it", function()
            assets:find_package(unit, "unit", true)
		end}})
		return
	end
	return EditorWallBuy.super.init(self, ...)
end

function EditorWallBuy:create_element()
	self.super.create_element(self)
    self._element.class = "ElementWallBuy"
    self._element.values.tweak_data_id = "none"
    self._element.values.override_timer = -1 
end

function EditorWallBuy:update_interaction_unit(pos, rot)
	local element = managers.mission:get_element_by_id(self._element.id)
	if alive(self._last_alert) then
		self._last_alert:Destroy()
	end
	if element then
		if tweak_data.interaction[self._element.values.tweak_data_id] then
			if not alive(element._unit) then
				element._unit = CoreUnit.safe_spawn_unit("units/pd2_mod_zombies/props/zm_wallbuy_dummy/zm_wallbuy_dummy", self._element.values.position, self._element.values.rotation)
				element._unit:interaction():set_mission_element(element)
			end
			element._unit:interaction():set_tweak_data(self._element.values.tweak_data_id)
		else
			local msg = "Current tweak data ID does not exist"
			if self._element.values.tweak_data_id == "none" then
				msg = "No interaction tweak data ID set"
			end
			self._last_alert = self:Alert(msg..". \nThe element will not work.")
		end
		if alive(element._unit) then
			element._unit:set_position(self._element.values.position)
			element._unit:set_rotation(self._element.values.rotation)
			element._unit:set_moving()
			element._unit:interaction():set_override_timer_value(self._element.values.override_timer ~= -1 and self._element.values.override_timer or nil)
		end
	end
end

function EditorWallBuy:set_element_data(...)
	EditorWallBuy.super.set_element_data(self, ...)
	self:update_interaction_unit()
end

function EditorWallBuy:update_positions(...)
	EditorWallBuy.super.update_positions(self, ...)
	self:update_interaction_unit()
end

function EditorWallBuy:_build_panel()
	self:_create_panel()
    self:ComboCtrl("weapon_id", ElementWallBuy.weapon_ids, {help = "Select an Weapon ID, Refer to the MWS wiki for names."})
    self:ComboCtrl("tweak_data_id", table.list_add({"none"}, table.map_keys(tweak_data.interaction)))
    self:update_interaction_unit()
end
