local Font = "fonts/escom_outline"
local BaseLayer = 2500

SkyLib.Survival.BuyMenu = SkyLib.Survival.BuyMenu or class()
local BuyMenu = SkyLib.Survival.BuyMenu

function BuyMenu:init()
    self._menu = MenuUI:new({
        name = "SurvivalBuyMenu",
		layer = BaseLayer,
        use_default_close_key = true,
        disable_player_controls = true,
		background_color = Color(0,0,0, 0.5),
        animate_toggle = true
    })
    self._menu_panel = self._menu._panel

    self._current_category = "pistol"
    self._current_weapon_info = ""

    self:_init_tweakdata()
    self:_init_bg()
    self:_init_header()
    self:_init_game_info()
    self:_init_weapon_cat()
    self:_init_weapon_list()
    self:_init_weapon_details()
end

function BuyMenu:_init_tweakdata()
    self._weapons = SkyLib.Survival._weapons
end

function BuyMenu:_init_bg()
    self._menu_panel:bitmap({
        name = "bg_blur",
        w = self._menu_panel:w(),
        h = self._menu_panel:h(),
        texture = "guis/textures/test_blur_df",
        render_template = "VertexColorTexturedBlur3D",
        halign = "scale",
        valign = "scale"
    })

    self._menu_panel:rect({
        name = "bg",
		color = Color.black,
		alpha = 0.4,
		layer = -1,
		halign = "scale",
        valign = "scale"
    })
end

function BuyMenu:_init_header()
    self.TopBar = self._menu:Menu({
        name = "TopBar",
        background_color = Color(0.025, 0.025, 0.025),
		h = 35,
		text_offset = 0,
		align_method = "grid",
        w = self._menu_panel:w(),
        scrollbar = false,
        position = "Top"
    })

    self.Title = self.TopBar:Button({
		text = "CRIME.NET Weapon Supplier",
        font = Font,
		size = 29,
        border_left = false,
        size_by_text = true,
        color = Color(0.8, 0.8, 0.8),
        layer = BaseLayer,
        highlight_color = Color.transparent
    })

    self.Version = self.TopBar:Button({
        text = "Version " .. SkyLib.update_module_data.module.version,
        font = Font,
        size = 29,
        border_left = false,
        size_by_text = true,
        align = "right",
        position = "RightOffset-x",
        text_align = "right",
        foreground = Color(0.5, 0.5, 0.5),
        layer = BaseLayer,
        highlight_color = Color.transparent
    })

    --local my_steam_id = Steam:userid()
    --local my_steam_name = managers.network.account:username()

    --self.SteamAvatar = self.TopBar:ImageButton({
    --    name = "SteamAvatar",
    --    texture = "guis/textures/pd2/none_icon",
    --    w = 35,
    --    h = 35,
    --})

    --Steam:friend_avatar(1, my_steam_id, function (texture)
	--	local avatar = texture or "guis/textures/pd2/none_icon"
	--	self.SteamAvatar:SetImage(avatar)
    --end)

    --self.SteamName = self.TopBar:Button({
    --    text = "Connected as: " .. tostring(my_steam_name),
    --    highlight_color = Color.transparent,
   --     foreground = Color(0, 1, 0),
    --    font = Font,
  --      border_left = false,
--size_by_text = true,
    --    size = 25,
    --    text_vertical = "center",
    --    position = function(item)
    --        item:Panel():set_y(5)
    --    end
   -- })
end

function BuyMenu:_init_game_info()
    self.GameInfo = self._menu:Menu({
        name = "GameInfo",
        background_color = Color(0, 0, 0):with_alpha(0.35),
        h = 200,
        w = self._menu_panel:w() / 2,
        scrollbar = false,
		offset = 8,
        position = function(item)
            item:Panel():set_top(self.TopBar:Panel():bottom())
        end
    })

    self.CurrentWave = self.GameInfo:Divider({
        name = "CurrentWave",
        text = "Wave 0",
        font = Font,
        size = 40,
        text_align = "center"
    })

    self.PlayerInfo = self.GameInfo:Menu({
        name = "PlayerInfo",
        background_color = Color(0, 0, 0):with_alpha(0.55),
        h = 138,
        w = self._menu_panel:w() / 2,
        scrollbar = false,
        offset = 2
    })

    self.PlayerPanels = {}

    for peer_id, player_info in ipairs(SkyLib.SGM:_get_connected_players()) do
        self.PlayerPanels[peer_id] = self.PlayerInfo:Menu({
            name = "PlayerPanel_" .. peer_id,
            background_color = Color(0, 0, 0):with_alpha(0.55),
            h = 32,
            scrollbar = false,
            align_method = "grid"
        })

        local player_avatar = self.PlayerPanels[peer_id]:ImageButton({
            name = "SteamAvatar_" .. peer_id,
            texture = "guis/textures/pd2/none_icon",
            w = 28,
            h = 28,
        })

        if player_info.steam_id and tonumber(player_info.steam_id) > 0 then
            Steam:friend_avatar(1, player_info.steam_id, function (texture)
                local avatar = texture or "guis/textures/pd2/none_icon"
                player_avatar:SetImage(avatar)
            end)
        end

        self.PlayerPanels[peer_id]:Divider({
            name = "player_name_" .. peer_id,
            text = player_info.name,
            font = Font,
            size = 20,
            w = 320,
            foreground = SkyLib.Network:_get_tweak_color_by_peer_id(peer_id),
            text_vertical = "center"
        })

        self.PlayerPanels[peer_id]:Divider({
            name = "player_balance_" .. peer_id,
            text = "$" .. SkyLib.SGM:_get_money_by_peer(peer_id),
            font = Font,
            w = 120,
            size = 20,
            visible = tonumber(player_info.steam_id) > 0 and true or false,
            foreground = Color(0, 1, 0),
            text_vertical = "center"
        })
    end

    --self.Balance = self.GameInfo:Divider({
      --  name = "Balance",
        --text = "$".. SkyLib.SGM:_get_money(),
        --font = Font,
        --size = 18,
        --foreground = Color(0, 1, 0)
    --})
end

function BuyMenu:_init_weapon_cat()
    self.WeaponCatList = self._menu:Menu({
        name = "WeaponCatList",
        background_color = Color(0, 0, 0):with_alpha(0.85),
        h = 68,
        w = self._menu_panel:w() / 2,
        scrollbar = false,
        align_method = "grid",
		offset = 0,
        position = function(item)
            item:Panel():set_top(self.GameInfo:Panel():bottom())
        end
    })

    self.WeaponCatList:Button({
        name = "pistol_cat",
        text = "Pistols",
        font = Font,
        size = 24,
        border_bottom = true,
        border_left = false,
        size_by_text = true,
        offset = 8,
        color = Color(0.8, 0.8, 0.8),
        border_color = Color(0.25, 0.25, 0.25),
        layer = BaseLayer,
        on_callback = ClassClbk(self, "_on_category_changed", "pistol")
    })

    self.WeaponCatList:Button({
        name = "smg_cat",
        text = "SMGs",
        font = Font,
        size = 24,
        border_bottom = true,
        border_left = false,
        size_by_text = true,
        offset = 8,
        color = Color(0.8, 0.8, 0.8),
        border_color = Color(0.25, 0.25, 0.25),
        layer = BaseLayer,
        on_callback = ClassClbk(self, "_on_category_changed", "smg")
    })

    self.WeaponCatList:Button({
        name = "shot_cat",
        text = "Shotguns",
        font = Font,
        size = 24,
        border_bottom = true,
        border_left = false,
        size_by_text = true,
        offset = 8,
        color = Color(0.8, 0.8, 0.8),
        border_color = Color(0.25, 0.25, 0.25),
        layer = BaseLayer,
        on_callback = ClassClbk(self, "_on_category_changed", "shotgun")
    })

    self.WeaponCatList:Button({
        name = "ar_cat",
        text = "Assault Rifles",
        font = Font,
        size = 24,
        border_bottom = true,
        border_left = false,
        size_by_text = true,
        offset = 8,
        color = Color(0.8, 0.8, 0.8),
        border_color = Color(0.25, 0.25, 0.25),
        layer = BaseLayer,
        on_callback = ClassClbk(self, "_on_category_changed", "assault_rifle")
    })

    self.WeaponCatList:Button({
        name = "snp_cat",
        text = "Sniper Rifles",
        font = Font,
        size = 24,
        border_bottom = true,
        border_left = false,
        size_by_text = true,
        offset = 8,
        color = Color(0.8, 0.8, 0.8),
        border_color = Color(0.25, 0.25, 0.25),
        layer = BaseLayer,
        on_callback = ClassClbk(self, "_on_category_changed", "snp")
    })

    self.WeaponCatList:Button({
        name = "lmg_cat",
        text = "Light Machine Guns",
        font = Font,
        size = 24,
        border_bottom = true,
        border_left = false,
        size_by_text = true,
        offset = 8,
        color = Color(0.8, 0.8, 0.8),
        border_color = Color(0.25, 0.25, 0.25),
        layer = BaseLayer,
        on_callback = ClassClbk(self, "_on_category_changed", "lmg")
    })
end

function BuyMenu:_init_weapon_list()
    if not self.WeaponList then
        self.WeaponList = self._menu:Menu({
            name = "WeaponList",
            background_color = Color(0, 0, 0):with_alpha(0.55),
            h = self._menu_panel:h() - self.GameInfo:Panel():h() - self.TopBar:Panel():h() - self.WeaponCatList:Panel():h(),
            w = self._menu_panel:w() / 2,
            scrollbar = true,
            offset = 0,
            position = function(item)
                item:Panel():set_top(self.WeaponCatList:Panel():bottom())
            end
        })
    end

    self.WeaponPanels = {}

    for _, wpn_tbl in nb_pairs(self._weapons, function(t,a,b) return t[b][2] > t[a][2] end) do
        local wpn_data = wpn_tbl[1]
        local wpn_tweak = tweak_data.weapon[wpn_data]

        if wpn_tweak then
            for _, cat in ipairs(wpn_tweak.categories) do
                if cat == self._current_category then
                    local wpn_icon_path = managers.blackmarket:get_weapon_icon_path(wpn_data)
                    self.WeaponPanels[wpn_data] = self.WeaponList:Menu({
                        name = "WpnPanel_".. wpn_data,
                        background_color = Color(0, 0, 0):with_alpha(0.25),
                        h = 32,
                        align_method = "grid",
                        w = self.WeaponList:Panel():w(),
                        scrollbar = false,
                        border_bottom = true,
                        border_color = Color(1, 1, 1):with_alpha(0.15),
                    })

                    local wpn_icon = self.WeaponPanels[wpn_data]:ImageButton({
                        name = "wpn_icon_" .. wpn_data,
                        texture = wpn_icon_path,
                        h = 32,
                        w = 64,
                        highlight_color = Color.transparent
                    })

                    local wpn_name = self.WeaponPanels[wpn_data]:Button({
                        name = "wpn_name_" .. wpn_data,
                        text = managers.localization:text(wpn_tweak.name_id),
                        font = Font,
                        size = 26,
                        border_left = false,
                        w = 440,
                        color = Color(0.8, 0.8, 0.8),
                        layer = BaseLayer,
                        on_callback = ClassClbk(self, "_on_weapon_info_asked", wpn_data)
                    })

                    local missing_dlc = wpn_tweak.global_value and not managers.dlc:is_dlc_unlocked(wpn_tweak.global_value) and tweak_data.lootdrop.global_values[wpn_tweak.global_value].dlc
                    local sale_tbl = SkyLib.Survival._sales
                    local on_sale = false

                    if not missing_dlc then
                        for _, sales in pairs(sale_tbl) do
                            if sales.weapon_id == wpn_data then
                                if sales.sale_status == true then
                                    local wpn_sale = self.WeaponPanels[wpn_data]:Divider({
                                        name = "wpn_sale_" .. wpn_data,
                                        text = "SALE!!",
                                        font = "fonts/font_large_mf",
                                        text_align = "center",
                                        border_right = true,
                                        size = 13,
                                        w = 50,
                                        h = 16,
                                        border_left = false,
                                        color = Color(0.8, 0.8, 0.8),
                                        background_color = Color(0.75, 0.75, 0.1):with_alpha(0.3) ,
                                        highlight_color = Color(0.75, 0.75, 0.1):with_alpha(0.3),
                                        layer = BaseLayer
                                    })

                                    self.WeaponPanels[wpn_data]:Divider({
                                        name = "wpn_sale_" .. wpn_data .. "_discount",
                                        text = "-" .. sales.sale_discount .. "%",
                                        font = "fonts/font_large_mf",
                                        text_align = "center",
                                        border_right = true,
                                        size = 13,
                                        w = 50,
                                        h = 16,
                                        border_left = false,
                                        color = Color(0.8, 0.8, 0.8),
                                        background_color = Color(0.25, 1, 0.25):with_alpha(0.3) ,
                                        highlight_color = Color(0.25, 1, 0.25):with_alpha(0.3),
                                        layer = BaseLayer,
                                        position = function(item)
                                            item:Panel():set_top(wpn_sale:Panel():bottom())
                                            item:Panel():set_left(wpn_sale:Panel():left())
                                        end
                                    })

                                    on_sale = true
                                end
                            end
                        end
                    end

                    local weapon_price = SkyLib.Survival:_get_weapon_price(wpn_data, wpn_tweak)

                    local bg_price_color = {Color(0.1, 0.45, 0.1):with_alpha(0.3), Color(0.1, 0.45, 0.1):with_alpha(0.6)}
                    if weapon_price > SkyLib.SGM:_get_money() then
                        bg_price_color = {Color(0.45, 0.1, 0.1):with_alpha(0.3), Color(0.45, 0.1, 0.1):with_alpha(0.6)}
                    end

                    local wpn_price = self.WeaponPanels[wpn_data]:Button({
                        name = "wpn_price_" .. wpn_data,
                        text = "$".. weapon_price,
                        font = Font,
                        size = 26,
                        w = on_sale and 80 or 80 + 50,
                        text_align = "right",
                        --position = "RightOffset-x",
                        border_left = false,
                        foreground = not missing_dlc and Color(0.8, 0.8, 0.8) or Color.red,
                        background_color = not missing_dlc and bg_price_color[1] or Color.black,
                        highlight_color = not missing_dlc and bg_price_color[2] or Color.black,
                        layer = BaseLayer,
                        on_callback = ClassClbk(self, "_weapon_bought_callback", wpn_data)
                    })

                    if missing_dlc then
                        wpn_icon:Panel():set_alpha(0.15)
                        wpn_name:Panel():set_alpha(0.15)
                        wpn_price:SetText("Requires DLC")
                    end
                end
            end
        end
    end
end

function BuyMenu:_init_weapon_details(weapon_id)
    if weapon_id then
        self._current_weapon_info = weapon_id
    end
    
    if self._current_weapon_info == "" then
        return
    end

    if not self.WeaponDetails then
        self.WeaponDetails = self._menu:Menu({
            name = "WeaponDetails",
            background_color = Color(0, 0, 0):with_alpha(0.55),
            w = self._menu_panel:w() / 2,
            scrollbar = false,
            position = function(item)
                item:Panel():set_top(self.TopBar:Panel():bottom())
                item:Panel():set_left(self.GameInfo:Panel():right())
            end
        })
    end

    local weapon_tweak = tweak_data.weapon[weapon_id]

    if not weapon_tweak then
        return
    end

    local is_primary = weapon_tweak.use_data.selection_index == 2
    local slot_alert = "This will replace your secondary weapon slot!"

    if is_primary then
        slot_alert = "This will replace your primary weapon slot!"
    end

    self.WeaponName = self.WeaponDetails:Divider({
        name = "WeaponName",
        text = managers.localization:text(weapon_tweak.name_id),
        font = Font,
        border_left = false,
        background_color = Color(0, 0, 0):with_alpha(0.5),
        size = 24,
        text_vertical = "center",
        text_align = "center"
    })

    self.WeaponSlot = self.WeaponDetails:Divider({
        name = "WeaponSlot",
        text = slot_alert,
        font = Font,
        border_left = false,
        background_color = Color(1, 0, 0):with_alpha(0.25),
        size = 24,
        text_vertical = "center",
        text_align = "center"
    })

    local img_w = self._menu_panel:w() / 3
    local wpn_icon_path = managers.blackmarket:get_weapon_icon_path(weapon_id)

    self.WeaponImage = self.WeaponDetails:ImageButton({
        name = "WeaponImage",
        texture = wpn_icon_path,
        w = img_w,
        h = img_w / 2,
        position = function(item)
                item:Panel():set_world_center_x(self.WeaponDetails:Panel():world_center_x())
                item:Panel():set_y(item:Panel():y() + 5)
        end,
        layer = BaseLayer--,
        --foreground = Color(0.25, 0.75, 1):with_alpha(1)
    })

    BoxGuiObject:new(self.WeaponImage:Panel(), {
		sides = {
			1,
			1,
			1,
			1
		}
    })

    self.WeaponDetails:ImageButton({
        name = "WeaponImageEffect",
        texture = "guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_effect",
        w = img_w,
        h = img_w / 2,
        position = function(item)
            item:Panel():set_world_center_x(self.WeaponImage:Panel():world_center_x())
            item:Panel():set_world_center_y(self.WeaponImage:Panel():world_center_y())
            item:Panel():set_layer(BaseLayer + 1)
        end
    })

    self.WeaponStats = self.WeaponDetails:Menu({
        name = "WeaponStats",
        background_color = Color(0, 0, 0):with_alpha(0.55),
        w = self._menu_panel:w() / 2,
        h = 300,
        scrollbar = false,
        position = function(item)
            item:Panel():set_y(item:Panel():y() + 225)
        end
    })

    self.TableStatsHeader = self.WeaponStats:Divider({
        name = "TableStatsHeader",
        text = "Weapon Stats",
        font = Font,
        border_left = false,
        background_color = Color(0, 0, 0):with_alpha(0.5),
        size = 24,
        text_vertical = "center",
        text_align = "center"
    })

    self.WeaponStatsTable = {}

    self.WeaponStatsTable["damage_label"] = self.WeaponStats:Divider({
        name = "WeaponStatsTable_damage_label",
        text = "Damage",
        font = Font,
        border_left = false,
        background_color = Color(0, 0, 0):with_alpha(0.5),
        size = 24,
        align_method = "grid",
        w = 200,
        text_vertical = "center"
    })

    local wpn_damage_base = weapon_tweak.stats.damage

    if weapon_tweak.stats_modifiers and weapon_tweak.stats_modifiers.damage then
        wpn_damage_base = wpn_damage_base * weapon_tweak.stats_modifiers.damage
    end

    self.WeaponStatsTable["damage_bar"] = self.WeaponStats:ImageButton({
        name = "damage_bar",
        texture = "ui/survival/stat_bar_empty",
        w = 330,
        background_color = Color(0, 0, 0):with_alpha(0.5),
        position = function(item)
            item:Panel():set_left(self.WeaponStatsTable["damage_label"]:Panel():right())
            item:Panel():set_top(self.WeaponStatsTable["damage_label"]:Panel():top())
        end,
        highlight_color = Color(0, 0, 0):with_alpha(0.5),
        h = 28
    })

    self.WeaponStatsTable["damage_bar_f"] = self.WeaponStats:ImageButton({
        name = "damage_bar_f",
        texture = "ui/survival/stat_bar_fill",
        w = self:_calc_stat_bar_width("damage", wpn_damage_base, self._current_category),
        background_color = Color(0, 0, 0):with_alpha(0),
        foreground = Color(0.75, 0.25, 0.25),
        position = function(item)
            item:Panel():set_left(self.WeaponStatsTable["damage_label"]:Panel():right())
            item:Panel():set_top(self.WeaponStatsTable["damage_label"]:Panel():top())
            item:Panel():set_layer(BaseLayer + 1)
        end,
        highlight_color = Color(0, 0, 0):with_alpha(0),
        h = 28
    })

    self.WeaponStatsTable["damage"] = self.WeaponStats:Divider({
        name = "WeaponStatsTable_damage",
        text = wpn_damage_base,
        font = Font,
        border_left = false,
        background_color = Color(0, 0, 0):with_alpha(0.5),
        size = 24,
        w = 100,
        position = function(item)
            item:Panel():set_left(self.WeaponStatsTable["damage_bar"]:Panel():right())
            item:Panel():set_top(self.WeaponStatsTable["damage_bar"]:Panel():top())
        end,
        text_vertical = "center",
        text_align = "right"
    })

    self.WeaponStatsTable["accuracy_label"] = self.WeaponStats:Divider({
        name = "WeaponStatsTable_accuracy_label",
        text = "Accuracy",
        font = Font,
        border_left = false,
        background_color = Color(0, 0, 0):with_alpha(0.5),
        size = 24,
        align_method = "grid",
        w = 200,
        text_vertical = "center"
    })

    self.WeaponStatsTable["accuracy_bar"] = self.WeaponStats:ImageButton({
        name = "accuracy_bar",
        texture = "ui/survival/stat_bar_empty",
        w = 330,
        background_color = Color(0, 0, 0):with_alpha(0.5),
        position = function(item)
            item:Panel():set_left(self.WeaponStatsTable["accuracy_label"]:Panel():right())
            item:Panel():set_top(self.WeaponStatsTable["accuracy_label"]:Panel():top())
        end,
        highlight_color = Color(0, 0, 0):with_alpha(0.5),
        h = 28
    })

    self.WeaponStatsTable["accuracy_bar_f"] = self.WeaponStats:ImageButton({
        name = "accuracy_bar_f",
        texture = "ui/survival/stat_bar_fill",
        w = self:_calc_stat_bar_width("spread", self:_calc_stab_acc_stats(weapon_tweak.stats.spread)),
        background_color = Color(0, 0, 0):with_alpha(0),
        foreground = Color(0.25, 0.25, 0.75),
        position = function(item)
            item:Panel():set_left(self.WeaponStatsTable["accuracy_label"]:Panel():right())
            item:Panel():set_top(self.WeaponStatsTable["accuracy_label"]:Panel():top())
            item:Panel():set_layer(BaseLayer + 1)
        end,
        highlight_color = Color(0, 0, 0):with_alpha(0),
        h = 28
    })

    self.WeaponStatsTable["accuracy"] = self.WeaponStats:Divider({
        name = "WeaponStatsTable_accuracy",
        text = self:_calc_stab_acc_stats(weapon_tweak.stats.spread),
        font = Font,
        border_left = false,
        background_color = Color(0, 0, 0):with_alpha(0.5),
        size = 24,
        w = 100,
        position = function(item)
            item:Panel():set_left(self.WeaponStatsTable["accuracy_bar"]:Panel():right())
            item:Panel():set_top(self.WeaponStatsTable["accuracy_bar"]:Panel():top())
        end,
        text_vertical = "center",
        text_align = "right"
    })

    self.WeaponStatsTable["stability_label"] = self.WeaponStats:Divider({
        name = "WeaponStatsTable_stability_label",
        text = "Stability",
        font = Font,
        border_left = false,
        background_color = Color(0, 0, 0):with_alpha(0.5),
        size = 24,
        align_method = "grid",
        w = 200,
        text_vertical = "center"
    })

    self.WeaponStatsTable["stab_bar"] = self.WeaponStats:ImageButton({
        name = "stab_bar",
        texture = "ui/survival/stat_bar_empty",
        w = 330,
        background_color = Color(0, 0, 0):with_alpha(0.5),
        position = function(item)
            item:Panel():set_left(self.WeaponStatsTable["stability_label"]:Panel():right())
            item:Panel():set_top(self.WeaponStatsTable["stability_label"]:Panel():top())
        end,
        highlight_color = Color(0, 0, 0):with_alpha(0.5),
        h = 28
    })

    self.WeaponStatsTable["stab_bar_f"] = self.WeaponStats:ImageButton({
        name = "stab_bar_f",
        texture = "ui/survival/stat_bar_fill",
        w = self:_calc_stat_bar_width("recoil", self:_calc_stab_acc_stats(weapon_tweak.stats.recoil)),
        background_color = Color(0, 0, 0):with_alpha(0),
        foreground = Color(0.25, 0.75, 0.25),
        position = function(item)
            item:Panel():set_left(self.WeaponStatsTable["stability_label"]:Panel():right())
            item:Panel():set_top(self.WeaponStatsTable["stability_label"]:Panel():top())
            item:Panel():set_layer(BaseLayer + 1)
        end,
        highlight_color = Color(0, 0, 0):with_alpha(0),
        h = 28
    })

    self.WeaponStatsTable["stability"] = self.WeaponStats:Divider({
        name = "WeaponStatsTable_stability",
        text = self:_calc_stab_acc_stats(weapon_tweak.stats.recoil),
        font = Font,
        border_left = false,
        background_color = Color(0, 0, 0):with_alpha(0.5),
        size = 24,
        w = 100,
        position = function(item)
            item:Panel():set_left(self.WeaponStatsTable["stab_bar"]:Panel():right())
            item:Panel():set_top(self.WeaponStatsTable["stab_bar"]:Panel():top())
        end,
        text_vertical = "center",
        text_align = "right"
    })

    self.WeaponStatsTable["rof_label"] = self.WeaponStats:Divider({
        name = "WeaponStatsTable_rof_label",
        text = "Rate of Fire",
        font = Font,
        border_left = false,
        background_color = Color(0, 0, 0):with_alpha(0.5),
        size = 24,
        align_method = "grid",
        w = 200,
        text_vertical = "center"
    })

    self.WeaponStatsTable["rof_bar"] = self.WeaponStats:ImageButton({
        name = "rof_bar",
        texture = "ui/survival/stat_bar_empty",
        w = 330,
        background_color = Color(0, 0, 0):with_alpha(0.5),
        position = function(item)
            item:Panel():set_left(self.WeaponStatsTable["rof_label"]:Panel():right())
            item:Panel():set_top(self.WeaponStatsTable["rof_label"]:Panel():top())
        end,
        highlight_color = Color(0, 0, 0):with_alpha(0.5),
        h = 28
    })

    self.WeaponStatsTable["rof_bar_f"] = self.WeaponStats:ImageButton({
        name = "rof_bar_f",
        texture = "ui/survival/stat_bar_fill",
        w = self:_calc_stat_bar_width("rof", self:_calc_rof_stats(weapon_tweak.fire_mode_data.fire_rate)),
        background_color = Color(0, 0, 0):with_alpha(0),
        foreground = Color(1, 0.75, 0.25),
        position = function(item)
            item:Panel():set_left(self.WeaponStatsTable["rof_label"]:Panel():right())
            item:Panel():set_top(self.WeaponStatsTable["rof_label"]:Panel():top())
            item:Panel():set_layer(BaseLayer + 1)
        end,
        highlight_color = Color(0, 0, 0):with_alpha(0),
        h = 28
    })

    self.WeaponStatsTable["rof"] = self.WeaponStats:Divider({
        name = "WeaponStatsTable_rof",
        text = self:_calc_rof_stats(weapon_tweak.fire_mode_data.fire_rate),
        font = Font,
        border_left = false,
        background_color = Color(0, 0, 0):with_alpha(0.5),
        size = 24,
        w = 100,
        position = function(item)
            item:Panel():set_left(self.WeaponStatsTable["rof_bar"]:Panel():right())
            item:Panel():set_top(self.WeaponStatsTable["rof_bar"]:Panel():top())
        end,
        text_vertical = "center",
        text_align = "right"
    })

    self.WeaponStatsTable["ammo_label"] = self.WeaponStats:Divider({
        name = "WeaponStatsTable_ammo_label",
        text = "Ammunition",
        font = Font,
        border_left = false,
        background_color = Color(0, 0, 0):with_alpha(0.5),
        size = 24,
        align_method = "grid",
        w = self.WeaponStats:Panel():w() / 2,
        text_vertical = "center"
    })

    self.WeaponStatsTable["ammo"] = self.WeaponStats:Divider({
        name = "WeaponStatsTable_ammo",
        text = weapon_tweak.CLIP_AMMO_MAX .. " / " .. (weapon_tweak.CLIP_AMMO_MAX * weapon_tweak.NR_CLIPS_MAX),
        font = Font,
        border_left = false,
        background_color = Color(0, 0, 0):with_alpha(0.5),
        size = 24,
        w = self.WeaponStats:Panel():w() / 2,
        position = function(item)
            item:Panel():set_left(self.WeaponStatsTable["ammo_label"]:Panel():right())
            item:Panel():set_top(self.WeaponStatsTable["ammo_label"]:Panel():top())
        end,
        text_vertical = "center",
        text_align = "right"
    })

    self.WeaponStatsTable["price_label"] = self.WeaponStats:Divider({
        name = "WeaponStatsTable_price_label",
        text = "Price",
        font = Font,
        border_left = false,
        background_color = Color(0, 0, 0):with_alpha(0.5),
        size = 24,
        align_method = "grid",
        w = self.WeaponStats:Panel():w() / 2,
        text_vertical = "center"
    })

    local weapon_price = SkyLib.Survival:_get_weapon_price(weapon_id, weapon_tweak)
    self.WeaponStatsTable["price"] = self.WeaponStats:Divider({
        name = "WeaponStatsTable_price",
        text = "$".. weapon_price,
        font = Font,
        border_left = false,
        foreground = Color.green,
        background_color = Color(0, 0, 0):with_alpha(0.5),
        size = 24,
        w = self.WeaponStats:Panel():w() / 2,
        position = function(item)
            item:Panel():set_left(self.WeaponStatsTable["price_label"]:Panel():right())
            item:Panel():set_top(self.WeaponStatsTable["price_label"]:Panel():top())
        end,
        text_vertical = "center",
        text_align = "right"
    })

    local bg_price_color = {Color(0.1, 0.45, 0.1):with_alpha(0.3), Color(0.1, 0.45, 0.1):with_alpha(0.6)}
    if weapon_price > SkyLib.SGM:_get_money() then
        bg_price_color = {Color(0.45, 0.1, 0.1):with_alpha(0.3), Color(0.45, 0.1, 0.1):with_alpha(0.6)}
    end

    self.BuyButton = self.WeaponStats:Button({
        name = "BuyButton",
        text = "Buy",
        font = Font,
        size = 40,
        w = self.WeaponStats:Panel():w(),
        h = 50,
        border_bottom = true,
        border_left = false,
        offset = 8,
        color = Color(0.8, 0.8, 0.8),
        background_color = bg_price_color[1],
        highlight_color = bg_price_color[2],
        text_align = "center",
        text_vertical = "center",
        border_color = Color(0.25, 0.25, 0.25),
        layer = BaseLayer,
        on_callback = ClassClbk(self, "_weapon_bought_callback", weapon_id)
    })

    if weapon_price > SkyLib.SGM:_get_money() then
        self.BuyButton:SetText("Not enough money")
    end
end

function BuyMenu:_calc_stab_acc_stats(nb)
    return (nb * 4) - 4 -- I think??
end

function BuyMenu:_calc_rof_stats(nb)
    return math.floor(60 / nb)
end

function BuyMenu:_calc_stat_bar_width(statistic, nb, cat)
    local toppers = {
        damage = 100,
        recoil = 100,
        spread = 100,
        rof = 1000
    }

    local top_by_cat = {
        pistol = 180,
        assault_rifle = 200,
        smg = 150,
        snp = 850,
        shotgun = 180,
        lmg = 150
    }

    if cat then
        for k_cat, damage_top in pairs(top_by_cat) do
            if k_cat == cat then
                toppers.damage = damage_top
                break
            end
        end
    end

-- 250 * 100 / 400 = 62.5 AKA dmg * percent / top
-- 
-- then percentage / 100 : 0.625 * bar length (330)

    for stat_top, top in pairs(toppers) do
        if statistic == stat_top then
            local damage_percent = nb * 100 / top
            local percent_divided = damage_percent / 100
            local result = percent_divided * 330

            if result > 330 then return 330 end

            return result 
        end
    end
end

function BuyMenu:toggle()
    self._menu:SetEnabled(true)
end

function BuyMenu:_weapon_bought_callback(weapon_id)
    local tweak = tweak_data.weapon[weapon_id]
    local price = SkyLib.Survival:_get_weapon_price(weapon_id, tweak)

    if tweak.global_value and not managers.dlc:is_dlc_unlocked(tweak.global_value) and tweak_data.lootdrop.global_values[tweak.global_value].dlc then
        return false
    end

    if price > SkyLib.SGM:_get_money() then
        return false
    end

    SkyLib.Survival:_perform_weapon_switch(weapon_id)
end

function BuyMenu:_on_category_changed(new_cat)
    if self._current_category == new_cat then
        return
    end

    self.WeaponList:ClearItems()
    self._current_category = new_cat

    self:_init_weapon_list()
end

function BuyMenu:_on_weapon_info_asked(weapon_id)
    if tweak_data.weapon[weapon_id].global_value and not managers.dlc:is_dlc_unlocked(tweak_data.weapon[weapon_id].global_value) and tweak_data.lootdrop.global_values[tweak_data.weapon[weapon_id].global_value].dlc then
        return false
    end

    if self.WeaponDetails then
        self.WeaponDetails:ClearItems()
    end

    self:_init_weapon_details(weapon_id)
end