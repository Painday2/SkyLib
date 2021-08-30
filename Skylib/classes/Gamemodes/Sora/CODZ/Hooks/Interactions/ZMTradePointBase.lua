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

    self:_init_bg()
    self:_init_header()
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
    self.GameInfo = self._menu:Holder({
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
    --Create a seperate panel for each player
    for peer_id, player_info in ipairs(SkyLib.CODZ:_get_connected_players()) do
        self.PlayerPanels[peer_id] = self.PlayerInfo:Menu({
            name = "PlayerPanel_" .. peer_id,
            background_color = Color(0, 0, 0):with_alpha(0.55),
            h = 64,
            scrollbar = false,
            align_method = "grid"
        })
        self.PlayerInfo:Panel():set_h(self.PlayerPanels[peer_id]:Panel():bottom() - 4)

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
            max_height = 28,
            w = 99,
            background_color = Color(0, 0, 0):with_alpha(0.55),
            foreground = SkyLib.Network:_get_tweak_color_by_peer_id(peer_id),
            text_vertical = "center"
        })
        -- thanks luffy :angryboye:
        --set the wrap so long names will get cut and not distort the menu
        self.PlayerPanels[peer_id]:GetItem("player_name_" .. peer_id).title:set_wrap(false)

        self.PlayerPanels[peer_id]:Divider({
            name = "player_balance_" .. peer_id,
            text = "$" .. SkyLib.CODZ:_get_money_by_peer(peer_id),
            font = Font,
            w = 80,
            size = 20,
            visible = tonumber(player_info.steam_id) > 0 and true or false,
            background_color = Color(0, 0, 0):with_alpha(0.55),
            foreground = Color(0, 1, 0),
            text_vertical = "center",
            text_align = "right"
        })
        --if not current player, add the buttons, else remove the button's space
        if peer_id ~= SkyLib.Network:_my_peer_id() then
            self.PlayerPanels[peer_id]:Button({
                name = "player_send_500_" .. peer_id,
                text = "$500",
                font = Font,
                w = 45,
                size = 20,
                size_by_text = true,
                text_vertical = "center",
                visible = tonumber(player_info.steam_id) > 0 and true or false,
                background_color = Color(50, 50, 50):with_alpha(0.15),
                foreground = self:set_color(500),
                on_callback = ClassClbk(self, "check_money", 500, peer_id)
            })
            self.PlayerPanels[peer_id]:Button({
                name = "player_send_1000_" .. peer_id,
                text = "$1000",
                font = Font,
                w = 50,
                size = 20,
                text_vertical = "center",
                visible = tonumber(player_info.steam_id) > 0 and true or false,
                background_color = Color(50, 50, 50):with_alpha(0.15),
                foreground = self:set_color(1000),
                on_callback = ClassClbk(self, "check_money", 1000, peer_id)
            })
            self.PlayerPanels[peer_id]:Button({
                name = "player_send_2500_" .. peer_id,
                text = "$2500",
                font = Font,
                w = 55,
                size = 20,
                text_vertical = "center",
                visible = tonumber(player_info.steam_id) > 0 and true or false,
                background_color = Color(50, 50, 50):with_alpha(0.15),
                foreground = self:set_color(2500),
                on_callback = ClassClbk(self, "check_money", 2500, peer_id)
            })
            self.PlayerPanels[peer_id]:Button({
                name = "player_send_5000_" .. peer_id,
                text = "$5000",
                font = Font,
                w = 55,
                size = 20,
                text_vertical = "center",
                visible = tonumber(player_info.steam_id) > 0 and true or false,
                background_color = Color(50, 50, 50):with_alpha(0.15),
                foreground = self:set_color(5000),
                on_callback = ClassClbk(self, "check_money", 5000, peer_id)
            })
        else
            self.PlayerPanels[peer_id]:Panel():set_h(self.PlayerPanels[peer_id]:Panel():bottom() - 32)
        end
        self.GameInfo:Panel():set_h(self.PlayerPanels[peer_id]:Panel():bottom() + 5)
	end
end
--updates the panel data, duh
function TradeMenu:update_panel_data()
    for peer_id, _ in ipairs(SkyLib.CODZ:_get_connected_players()) do
        local playerbal = self.PlayerPanels[peer_id]:GetItem("player_balance_" .. peer_id)
        if playerbal then
            playerbal:SetText("$" .. SkyLib.CODZ:_get_money_by_peer(peer_id))
            --have to cut the player's panel down again, because yes.
            if peer_id == SkyLib.Network:_my_peer_id() then
                self.PlayerPanels[peer_id]:Panel():set_h(self.PlayerPanels[peer_id]:Panel():bottom() - 32)
            end
        end
        --Setting buttons to red if you don't have enough
        local playerbuttons = self.PlayerPanels[peer_id]:Items()
        if playerbuttons then
            for i, v in pairs(playerbuttons) do
                --remove dollar sign to use as amount
                local amount = playerbuttons[i].text:gsub("%$", "")
                if playerbuttons[i].name == "player_send_"..amount.."_" .. peer_id then
                    amount = tonumber(amount)
                    local color = self:set_color(amount)
                    playerbuttons[i].title:set_color(color)
                    playerbuttons[i].foreground = color
                end
            end
        end
    end
end

function TradeMenu:toggle()
    self._menu:SetEnabled(true)
    TradeMenu:update_panel_data()
end

function TradeMenu:send_money(amount_to_deduct, peer_id)
    --Add to player, and remove from sender
    local data = {amount = amount_to_deduct, peer_id = peer_id}
    LuaNetworking:SendToPeers( "ShareCashTo", LuaNetworking:TableToString(data) )
    SkyLib.CODZ:_money_change(amount_to_deduct, peer_id)
    SkyLib.CODZ:_money_change(0 - amount_to_deduct, SkyLib.Network:_my_peer_id())
    self:update_panel_data()
end

function TradeMenu:check_money(amount_to_deduct, peer_id)
    local current_money = SkyLib.CODZ:_get_own_money()

    if not SkyLib.CODZ:_player_connected(peer_id) then
        return
    end

    if peer_id == SkyLib.Network:_my_peer_id() then
        return
    end

    if current_money < amount_to_deduct then
        return
    end

    self:send_money(amount_to_deduct, peer_id)
end
--Sets color based on if player has enough to send
function TradeMenu:set_color(amount)
    local current_money = SkyLib.CODZ:_get_own_money()
    amount = amount - 1
    if current_money > amount then
        return Color(0, 1, 0)
    else
        return Color(1, 0, 0)
    end
end

ZMTradePointBase = ZMTradePointBase or class(UnitBase)

function ZMTradePointBase:init(unit)
	UnitBase.init(self, unit, false)

    self._unit = unit

    --yes i stole the missionelement base. no i won't say sorry.
    --Add a element icon/text to display location and info
    if Global.editor_mode then
        local iconsize = EditorPart:Val("ElementsSize") or 32
        local root = self._unit:get_objects_by_type(Idstring("object3d"))[1]
        if root == nil then
            return
        end

        self._gui = World:newgui()
        local pos = root:position() - Vector3(iconsize / 2, iconsize / 2, 0)
        self._ws = self._gui:create_linked_workspace(iconsize / 2, iconsize / 2, root, pos, Vector3(iconsize, 0, 0), Vector3(0, iconsize, 0))
        self._ws:set_billboard(self._ws.BILLBOARD_BOTH)
        local colors = {
            Color("ffffff"),
            Color("0d449c"),
            Color("16b329"),
            Color("eec022"),
            Color("9519ca"),
            Color("d31f07"),
            Color("555555"),
            Color("ea34ca"),
            Color("179d9b"),
            Color("0c243e"),
            Color("2c2c2c"),
            Color("5fc16f"),
        }

        self._color = EditorPart:Val("RandomizedElementsColor") and colors[math.random(1, #colors)] or EditorPart:Val("ElementsColor")
        local texture, rect = "textures/editor_icons_df", {225, 1, 62, 62}
        local size = iconsize / 4
        local font_size = iconsize / 8
        self._icon = self._ws:panel():bitmap({
            texture = texture,
            texture_rect = rect,
            render_template = "OverlayVertexColorTextured",
            color = self._color,
            rotation = 360,
            y = font_size,
            x = font_size,
            w = size,
            h = size,
        }) 
        self._text = self._ws:panel():text({
            render_template = "OverlayVertexColorTextured",
            font = "fonts/font_large_mf",
            font_size = font_size,
            w = iconsize / 2,
            h = font_size,
            rotation = 360,
            align = "center",
            color = self._color,
            text = "SkyLib (Unit) - zm_tradepoint",
        })
        self._enabled = true
        self._visible = true
        self._text:set_bottom(self._icon:top() - font_size)
    end
end

function ZMTradePointBase:interacted(player)
    if player then
        if not SkyLib.CODZ.TradeMenu._menu then
            SkyLib.CODZ.TradeMenu:init()
        end
        SkyLib.CODZ.TradeMenu:toggle()
        self._unit:damage():run_sequence_simple("interact")
    end
end

function ZMTradePointBase:destroy()
	if Global.editor_mode then
        self._gui:destroy_workspace(self._ws)
    end
end

ZMTradePointInteractionExt = ZMTradePointInteractionExt or class(UseInteractionExt)
function ZMTradePointInteractionExt:interact(player)
    if not SkyLib.Network:_is_solo() and SkyLib.CODZ:_get_connected_players() then
        self._unit:base():interacted(player)
    end

	self:_post_event(player, "sound_done")
end

function ZMTradePointInteractionExt:selected(player, locator, hand_id)
	if not self:can_select(player) then
		return
	end

	self._hand_id = hand_id
	self._is_selected = true
	local string_macros = {}

	self:_add_string_macros(string_macros)

	local text = ""
	local icon = ""

	text = "Press " .. managers.localization:btn_macro("interact") .. " to open the menu"

	managers.hud:show_interact({
		text = text,
		icon = icon
	})

	return true
end

function ZMTradePointInteractionExt:can_select(player)
    if SkyLib.Network:_is_solo() then
        return false
    end
	return MisterySafeInteractionExt.super.can_select(self, player)
end