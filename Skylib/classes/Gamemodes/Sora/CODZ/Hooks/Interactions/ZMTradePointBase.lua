--I Hate Every Bit Of This.
local Font = "fonts/escom_outline"
local BaseLayer = 2500

SkyLib.CODZ.TradeMenu = SkyLib.CODZ.TradeMenu or class()
local TradeMenu = SkyLib.CODZ.TradeMenu

function TradeMenu:init()
    self._menu = MenuUI:new({
        name = "ZMPointTradeMenu",
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
end

function TradeMenu:_init_tweakdata()

end

function TradeMenu:_init_bg()
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

function TradeMenu:_init_header()
    self.GameInfo = self._menu:Menu({
        name = "GameInfo",
        background_color = Color(0, 0, 0):with_alpha(0.35),
        h = self._menu_panel:h() / 2.25,
        w = self._menu_panel:w() / 4,
        min_height = 64,
        max_height = 270,
        max_width = 224,
        scrollbar = false,
		offset = 8,
        position = function(item)
            item:SetPosition(self._menu_panel:w() / 2 - item.w / 2 , self._menu_panel:h() / 2 - item.h / 2)
        end
    })
    --self.GameInfo:SetPosition(self._menu_panel:w() / 2 - self.GameInfo.w / 2 , self._menu_panel:h() / 2 - self.GameInfo.h / 2)

    self.PlayerInfo = self.GameInfo:Menu({
        name = "PlayerInfo",
        background_color = Color(0, 0, 0):with_alpha(0.55),
        h = self.GameInfo.h,
        w = self.GameInfo.w,
        min_height = 64,
        max_height = 270,
        max_width = 220,
        scrollbar = false,
        offset = 2
    })

    self.PlayerPanels = {}

    for peer_id, player_info in ipairs(SkyLib.CODZ:_get_connected_players()) do
        if peer_id == 4 then
            --self.PlayerInfo:Panel():set_bottom(self.PlayerInfo.h + 64)
            return
        end
        self.PlayerPanels[peer_id] = self.PlayerInfo:Menu({
            name = "PlayerPanel_" .. peer_id,
            background_color = Color(0, 0, 0):with_alpha(0.55),
            h = 64,
            scrollbar = false,
            align_method = "grid"
        })
        log(tostring(self.PlayerPanels[peer_id]:Panel():h()))
        self.PlayerInfo:Panel():set_h(self.PlayerPanels[peer_id]:Panel():h())
        self.GameInfo:Panel():set_h(self.PlayerPanels[peer_id]:Panel():h())
        log(tostring(self.GameInfo.h))

        --[[local player_avatar = self.PlayerPanels[peer_id]:ImageButton({
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
        end]]

        self.PlayerPanels[peer_id]:Divider({
            name = "player_name_" .. peer_id,
            text = player_info.name,
            font = Font,
            size = 20,
            w = 109,
            foreground = SkyLib.Network:_get_tweak_color_by_peer_id(peer_id),
            text_vertical = "center"
        })

        --[[self.PlayerPanels[peer_id]:Divider({
            name = "player_balance_" .. peer_id,
            text = "$" .. SkyLib.CODZ:_get_money_by_peer(peer_id),
            font = Font,
            w = 70,
            size = 20,
            visible = tonumber(player_info.steam_id) > 0 and true or false,
            background_color = Color(0, 0, 0):with_alpha(0.55),
            foreground = Color(0, 1, 0),
            text_vertical = "center"
        })
        self.PlayerPanels[peer_id]:Button({
            name = "player_send_500" .. peer_id,
            text = "$500",
            font = Font,
            w = 45,
            size = 20,
            visible = tonumber(player_info.steam_id) > 0 and true or false,
            background_color = Color(50, 50, 50):with_alpha(0.15),
            foreground = Color(0, 1, 0),
            text_vertical = "center"
        })
        self.PlayerPanels[peer_id]:Button({
            name = "player_send_1000" .. peer_id,
            text = "$1000",
            font = Font,
            w = 50,
            size = 20,
            visible = tonumber(player_info.steam_id) > 0 and true or false,
            background_color = Color(50, 50, 50):with_alpha(0.15),
            foreground = Color(0, 1, 0),
            text_vertical = "center"
        })
        self.PlayerPanels[peer_id]:Button({
            name = "player_send_2500" .. peer_id,
            text = "$2500",
            font = Font,
            w = 55,
            size = 20,
            visible = tonumber(player_info.steam_id) > 0 and true or false,
            background_color = Color(50, 50, 50):with_alpha(0.15),
            foreground = Color(0, 1, 0),
            text_vertical = "center"
        })
        self.PlayerPanels[peer_id]:Button({
            name = "player_send_5000" .. peer_id,
            text = "$5000",
            font = Font,
            w = 55,
            size = 20,
            visible = tonumber(player_info.steam_id) > 0 and true or false,
            background_color = Color(50, 50, 50):with_alpha(0.15),
            foreground = Color(0, 1, 0),
            text_vertical = "center"
        })]]
    end
end

function TradeMenu:_init_game_info()
    
end


function TradeMenu:toggle()
    self._menu:SetEnabled(true)
end