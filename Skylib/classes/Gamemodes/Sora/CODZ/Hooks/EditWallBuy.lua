EditWallBuy = EditWallBuy or class(EditUnit)

local Utils = SkyLib.Utils

--idk what this does tbh.
function EditWallBuy:editable(unit)
    local weapons = unit:unit_data().name == "units/pd2_mod_zombies/props/zm_wallbuy_dummy/zm_wallbuy_dummy"
    return weapons
end

function EditWallBuy:build_menu()
    local main = self._menu:GetItem("Main")
    main:combobox("WeaponId", ClassClbk(self._parent, "set_unit_data"), {}, 1, {help = "Select an Weapon ID, Refer to the MWS wiki for names.", free_typing = true})
end

function EditWallBuy:set_unit_data(weapon_id)
    local unit = self:selected_unit()
    local ud = unit:unit_data()
    ud.weapon_id = weapon_id or self._menu:GetItem("WeaponId"):SelectedItem()
    --despawn/spawn weapon on weapon change
    unit:base():despawn_weapon()
    unit:base():spawn_weapon()
end

--Adds weapon ids to the menu
function EditWallBuy:set_menu_unit(unit)
    local weaponid = self._menu:GetItem("WeaponId")
    local weaponids = SkyLib.CODZ.WeaponHelper:map_weapon_ids()
    local selectedItem = Utils:index_from_value(weaponids, unit:unit_data().weapon_id)

    weaponid:SetVisible(weaponids and unit:unit_data().name == "units/pd2_mod_zombies/props/zm_wallbuy_dummy/zm_wallbuy_dummy")
    weaponid:SetItems(weaponids)
    weaponid:SetSelectedItem(selectedItem or "")
end

--Adds weapon_id menu to the editor menu
SkyHook:Post(StaticEditor, "build_extension_items", function(self)
    self._editors.wallbuy = EditWallBuy:new():is_editable(self)
end)