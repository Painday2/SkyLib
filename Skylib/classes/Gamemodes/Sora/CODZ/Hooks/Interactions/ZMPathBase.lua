ZMPathBase = ZMPathBase or class(UnitBase)
ZMPathBase.unit_list = {}
function ZMPathBase:init(unit)
	UnitBase.init(self, unit, false)

    self._unit = unit
    self._weapon_spawned = false
    --insert so we can access the units for sync reasons
    table.insert(ZMPathBase.unit_list, unit)
end


function ZMPathBase:interacted(player)
    if player then
        self._unit:damage():run_sequence_simple("interact")
    end
end

--send unit id and cost for sync
function ZMPathBase:sync_data(unit)
    local uid = unit:id()
    local cost = unit:unit_data().cost or 5000
    local data = {uid, cost}
    SkyLib.Network:_send("ZMPathData", data)
end

--recieve path data (unit id and cost) from host and spawn unit
function ZMPathBase:sync_spawn(data)
    if data then
        for _, unit in ipairs(ZMPathBase.unit_list) do
            if unit:id() == tonumber(data["1"]) then
                unit:unit_data().cost = tonumber(data["2"])
                table.remove(ZMPathBase.unit_list, data["1"])
                break
            end
        end
    end
end

--Needed to load the unit data correctly, i guess?
SkyHook:Post(WorldDefinition, "assign_unit_data", function(self, unit, data)
    if data.cost then
        unit:unit_data().cost = data.cost
	end
end)

--Hook to send path data on spawn, due to unit networking not being setup til around then. 
SkyHook:Post(CriminalsManager, "add_character", function(self, _, peer_id)
    --ran per player, make sure it only runs once
    self.path_sync_setup = self.path_sync_setup or nil
    if Network:is_server() and not self.path_sync_setup then
        for _, unit in ipairs(ZMPathBase.unit_list) do
            unit:base():sync_data(unit)
            self.path_sync_setup = true
        end
    end
end)


ZMPathExt = ZMPathExt or class(UseInteractionExt)

function ZMPathExt:selected(player, locator, hand_id)
	if not self:can_select(player) then
		return
	end

	self._hand_id = hand_id
	self._is_selected = true
	local string_macros = {}

	self:_add_string_macros(string_macros)

	local text = ""
	local icon = ""
	local current_money = SkyLib.CODZ:_get_own_money()
	local cost = self._tweak_data.points_cost or 0

	--Is a Zombie Mode Interaction?
	if self._tweak_data.zm_interaction then
		if self._unit:unit_data() and self._unit:unit_data().cost then
			cost = self._unit:unit_data().cost
		end
		text = "Hold " .. managers.localization:btn_macro("interact") .. " to buy"

		--Is a ZM Obstacle Interaction?
		--Has a base, left in for interaction element.
		if self._tweak_data.path then
			text = "Hold " .. managers.localization:btn_macro("interact") .. " to open "
			local path_type = "the path"

			if self._tweak_data.custom_path then
				path_type = self._tweak_data.custom_path
			end

			if current_money >= cost then
				text = text .. path_type
				text = text .. " [Cost : " .. cost .. "]"
			else
				local points_needed = cost - current_money
				text = "You need " .. points_needed .. " more points to open " .. path_type
			end
		end
	else
		local text_id = self._tweak_data.text_id or alive(self._unit) and self._unit:base().interaction_text_id and self._unit:base():interaction_text_id()
		text = managers.localization:text(text_id, string_macros)
		local icon = self._tweak_data.icon

		if self._tweak_data.special_equipment and not managers.player:has_special_equipment(self._tweak_data.special_equipment) then
			local has_special_equipment = false
	
			if self._tweak_data.possible_special_equipment then
				for i, special_equipment in ipairs(self._tweak_data.possible_special_equipment) do
					if managers.player:has_special_equipment(special_equipment) then
						has_special_equipment = true
	
						break
					end
				end
			end
	
			if not has_special_equipment then
				text = managers.localization:text(self._tweak_data.equipment_text_id, string_macros)
				icon = self.no_equipment_icon or self._tweak_data.no_equipment_icon or icon
			end
		end
	
		if self._tweak_data.contour_preset or self._tweak_data.contour_preset_selected then
			if not self._selected_contour_id and self._tweak_data.contour_preset_selected and self._tweak_data.contour_preset ~= self._tweak_data.contour_preset_selected then
				self._selected_contour_id = self._unit:contour():add(self._tweak_data.contour_preset_selected)
			end
		else
			self:set_contour("selected_color")
		end
	end

	managers.hud:show_interact({
		text = text,
		icon = icon
	})

	return true
end