EditWallBuy = EditWallBuy or class(EditUnit)

local Utils = SkyLib.Utils

function EditWallBuy:editable(unit)
    local weapons = unit:unit_data().name == "units/pd2_mod_zombies/props/zm_wallbuy_dummy/zm_wallbuy_dummy"
    return weapons
end

function EditWallBuy:build_menu(units)
    local main = self._menu:GetItem("Main")
    main:combobox("WeaponId", ClassClbk(self._parent, "set_unit_data"), {}, 1, {help = "Select an Weapon ID, Refer to the MWS wiki for names.",free_typing = true})
end

function EditWallBuy:set_unit_data(weapon_id)
    local unit = self:selected_unit()
    local ud = unit:unit_data()
    ud.weapon_id = weapon_id or self._menu:GetItem("WeaponId"):SelectedItem()
    unit:base():despawn_weapon()
    unit:base():spawn_weapon()
end

function EditWallBuy:set_menu_unit(unit)
    local material = self._menu:GetItem("WeaponId")
    local materials = SkyLib.CODZ.WeaponHelper:map_weapon_ids()
    local selectedItem = Utils:index_from_value(materials, unit:unit_data().weapon_id)

    material:SetVisible(materials and unit:unit_data().name == "units/pd2_mod_zombies/props/zm_wallbuy_dummy/zm_wallbuy_dummy")
    material:SetItems(materials)
    material:SetSelectedItem(selectedItem or "")
end

--Adds weapon_id menu to the editor menu
SkyHook:Post(StaticEditor, "build_extension_items", function(self)
    self._editors.wallbuy = EditWallBuy:new():is_editable(self)
end)

--Required to have the current weapon_id show in editor after restarting
SkyHook:Post(WorldDefinition, "assign_unit_data", function(self, unit, data)
    if not data.weapon_id then
		return
	end

	unit:unit_data().weapon_id = data.weapon_id
end)