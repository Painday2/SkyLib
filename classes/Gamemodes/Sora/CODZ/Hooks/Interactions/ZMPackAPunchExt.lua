ZMPackAPunchBase = ZMPackAPunchBase or class(UnitBase)
ZMPackAPunchBase.unit_list = {}
function ZMPackAPunchBase:init(unit)
	UnitBase.init(self, unit, false)

    self._unit = unit
    self._weapon_spawned = false
    --insert so we can access the units for sync reasons
    table.insert(ZMPackAPunchBase.unit_list, unit)
end


function ZMPackAPunchBase:interacted(player)
    if player then
        self._unit:damage():run_sequence_simple("interact")
    end
end

--send unit id and cost for sync
function ZMPackAPunchBase:sync_data(unit)
    local uid = unit:id()
    local cost = unit:unit_data().cost or 5000
    local data = {uid, cost}
    SkyLib.Network:_send("ZMPaPData", data)
end

--recieve pap data (unit id and cost) from host and spawn unit
function ZMPackAPunchBase:sync_spawn(data)
    if data then
        for _, unit in ipairs(ZMPackAPunchBase.unit_list) do
            if unit:id() == tonumber(data["1"]) then
                unit:unit_data().cost = tonumber(data["2"])
                table.remove(ZMPackAPunchBase.unit_list, data["1"])
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

--Hook to send pap data on spawn, due to unit networking not being setup til around then. 
SkyHook:Post(CriminalsManager, "add_character", function(self, _, peer_id)
    --ran per player, make sure it only runs once
    self.pap_sync_setup = self.pap_sync_setup or nil
    if Network:is_server() and not self.pap_sync_setup then
        for _, unit in ipairs(ZMPackAPunchBase.unit_list) do
            unit:base():sync_data(unit)
            self.pap_sync_setup = true
        end
    end
end)

ZMPackAPunchExt = ZMPackAPunchExt or class(UseInteractionExt)

function ZMPackAPunchExt:selected(player, locator, hand_id)
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
	local cost

	--Is a Zombie Mode Interaction?
	if self._tweak_data.zm_interaction then
		cost = self._unit:unit_data().cost or self._tweak_data.points_cost or 0
		text = "Hold " .. managers.localization:btn_macro("interact") .. " to buy"

		if self._tweak_data.pack_a_punch then
			text = "Hold " .. managers.localization:btn_macro("interact") .. " to upgrade your weapon"

			if current_money >= cost then
				text = text .. " [Cost : " .. cost .. "]"
			else
				local points_needed = cost - current_money
				text = "You need " .. points_needed .. " more points to upgrade your weapon"
			end
		end
    end
	managers.hud:show_interact({
		text = text,
		icon = icon
	})

	return true
end

function ZMPackAPunchExt:interact(player)
    if player then
        SkyLib.CODZ.WeaponHelper:_perform_weapon_switch(false, player, false, false, true)
        
        if self._unit:damage() then
            self._unit:damage():run_sequence_simple("interact", {unit = player})
        end
    end
end