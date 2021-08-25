EditPath = EditPath or class(EditUnit)

local Utils = SkyLib.Utils

--idk what this does tbh.
function EditPath:editable(unit)
    local weapons = unit:unit_data().name == "units/pd2_mod_zombies/props/zm_buy_marker/zm_buy_marker" or unit:unit_data().name == "units/pd2_mod_zombies/props/zm_buy_marker/zm_buy_marker_double"
    return weapons
end

function EditPath:build_menu(units)
    local main = self._menu:group("Path")
    main:combobox("Cost", ClassClbk(self._parent, "set_unit_data"), {}, 1, {help = "Cost of buying the weapon, You can enter a custom number. Try to make it a multiple of 10 that is divisable by 2 or you'll get some weird rounding", min = 0, free_typing = true})
end

function EditPath:set_unit_data(cost)
    local unit = self:selected_unit()
    local ud = unit:unit_data()
    ud.cost = cost or self._menu:GetItem("Cost"):SelectedItem()
end

--Adds weapon ids to the menu
function EditPath:set_menu_unit(unit)
    local cost = self._menu:GetItem("Cost")
    local amounts = {0, 500, 1000, 1500, 2000, 2500, 3000, 3500, 4500, 5000}
    local selectedItem2 = Utils:index_from_value(amounts, unit:unit_data().cost) or 1

    cost:SetVisible(unit:unit_data().name == "units/pd2_mod_zombies/props/zm_buy_marker/zm_buy_marker" or unit:unit_data().name == "units/pd2_mod_zombies/props/zm_buy_marker/zm_buy_marker_double")
    cost:SetItems(amounts)
    cost:SetSelectedItem(selectedItem2)
end

--Adds weapon_id menu to the editor menu
SkyHook:Post(StaticEditor, "build_extension_items", function(self)
    self._editors.path = EditPath:new():is_editable(self)
end)