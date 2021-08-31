ZMPackAPunchBase = ZMPackAPunchBase or class(UnitBase)
ZMPackAPunchBase.unit_list = {}
ZMPackAPunchBase.prop_list = {"units/pd2_mod_zombies/equipment/zom_pack_a_punch/zom_pack_a_punch"}
function ZMPackAPunchBase:init(unit)
	UnitBase.init(self, unit, false)

    self._unit = unit
    self._weapon_spawned = false
    --insert so we can access the units for sync reasons
    table.insert(ZMPackAPunchBase.unit_list, unit)
    ZMPackAPunchBase:fill_prop_list()
end

--if you make a custom unit, post hook this and insert your unit.
function ZMPackAPunchBase:fill_prop_list()
    --table.insert(ZMPackAPunchBase.prop_list, "units/pd2_mod_zombies/equipment/zom_pack_a_punch/zom_pack_a_punch")
end

function ZMPackAPunchBase:interacted(player)
    if player then
        self._unit:damage():run_sequence_simple("interact")
        SkyLib.CODZ.WeaponHelper:_perform_weapon_switch(false, player, false, false, true)
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

        if self._tweak_data.zm_interaction then

            if not self._unit:unit_data().cost then
                self._unit:unit_data().cost = self._tweak_data.points_cost or 0
            end

            local amount_to_deduct = 0 - self._unit:unit_data().cost

            if self._tweak_data.wallbuy and not self._tweak_data.grenade_spot then
                local weapon_id = self._unit:base()._weapon_id or "amcar"
                local current_state = managers.player:get_current_state()
                if current_state then
                    local current_weapon = current_state:get_equipped_weapon()
                    if current_weapon.name_id == weapon_id then
                        amount_to_deduct = math.round(amount_to_deduct / 2, 50)
                    end
                end
            end

            local peer_id = 1

            if managers and managers.network then
                local peer = managers.network:session():peer_by_unit(player)
                peer_id = peer:id()
            end

            if peer_id == SkyLib.Network:_my_peer_id() then
                SkyLib.CODZ:_money_change(amount_to_deduct, peer_id)
            end

            self._unit:base():interacted(player)
        end
    end
end