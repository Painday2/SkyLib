EditWallBuy = EditWallBuy or class(EditUnit)

local Utils = SkyLib.Utils
--local amounts = {"0", "500", "1000", "1500", "2000", "2500", "3000", "3500", "4500", "5000"}
local amounts = {0, 500, 1000, 1500, 2000, 2500, 3000, 3500, 4500, 5000}
--idk what this does tbh.
function EditWallBuy:editable(unit)
    local weapons = unit:unit_data().name == "units/pd2_mod_zombies/props/zm_wallbuy_dummy/zm_wallbuy_dummy"
    return weapons
end

function EditWallBuy:build_menu(units)
    local main = self._menu:group("Wall Buy")
    main:combobox("WeaponId", ClassClbk(self._parent, "set_unit_data"), {}, 1, {help = "Select an Weapon ID, Refer to the MWS wiki for names.", free_typing = true})
    main:combobox("Cost", ClassClbk(self._parent, "set_unit_data"), {}, 1, {help = "Cost of buying the weapon, You can enter a custom number. Try to make it a multiple of 10 that is divisable by 2 or you'll get some weird rounding", min = 0, free_typing = true})
end

function EditWallBuy:set_unit_data(weapon_id, cost)
    local unit = self:selected_unit()
    local ud = unit:unit_data()
    ud.weapon_id = weapon_id or self._menu:GetItem("WeaponId"):SelectedItem()
    ud.cost = cost or amounts[self._menu:GetItem("Cost"):Value()]
    --despawn/spawn weapon on weapon change
    unit:base():despawn_weapon()
    unit:base():spawn_weapon()
end

--Adds weapon ids to the menu
function EditWallBuy:set_menu_unit(unit)
    local weaponid = self._menu:GetItem("WeaponId")
    local weaponids = SkyLib.CODZ.WeaponHelper:map_weapon_ids()
    local selectedItem = Utils:index_from_value(weaponids, unit:unit_data().weapon_id) or 1

    weaponid:SetVisible(weaponids and unit:unit_data().name == "units/pd2_mod_zombies/props/zm_wallbuy_dummy/zm_wallbuy_dummy")
    weaponid:SetItems(weaponids)
    weaponid:SetSelectedItem(selectedItem or "")

    local cost = self._menu:GetItem("Cost")
    local selectedItem2 = Utils:index_from_value(amounts, unit:unit_data().cost) or 1

    cost:SetVisible(unit:unit_data().name == "units/pd2_mod_zombies/props/zm_wallbuy_dummy/zm_wallbuy_dummy")
    cost:SetItems(amounts)
    cost:SetSelectedItem(selectedItem2)
end

--Adds weapon_id menu to the editor menu
SkyHook:Post(StaticEditor, "build_extension_items", function(self)
    self._editors.wallbuy = EditWallBuy:new():is_editable(self)
end)