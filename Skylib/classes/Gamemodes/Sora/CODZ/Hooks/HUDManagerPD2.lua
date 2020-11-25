SkyHook:Post(HUDManager, "_setup_player_info_hud_pd2", function(self)
    self:hide_panels("assault_panel", "custody_panel", "hostages_panel", "heist_timer_panel")
    self:_setup_codz_hud()
end)

function HUDManager:_setup_codz_hud()
	local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
    self._hud_codz = HUDCODZ:new(hud.panel)
end

HUDCODZ = HUDCODZ or class()
HUDCODZ.DEFAULT_FONT = "fonts/font_large_mf"
HUDCODZ.DEFAULT_SHADOW_FONT = "fonts/font_medium_shadow_mf"

function HUDCODZ:init(parent)
    self:_init_waves(parent)
    self:_init_points(parent)
    self:_create_gift_hud(parent)
end

function HUDCODZ:_init_waves(parent)
    self._codz_wave_panel = parent:panel({
        name = "codz_wave_panel",
        h = 42,
        w = 128
    })

    self._codz_wave_number = self._codz_wave_panel:text({
        name = "codz_wave_number",
        font = HUDCODZ.DEFAULT_FONT,
        font_size = 42,
        color = Color(1, 0.6, 0, 0),
        text = utf8.to_upper("Wave 0")
    })
end

function HUDCODZ:_update_wave_font(new_font)
    self._codz_wave_number:set_font(Idstring(new_font))
    self._codz_wave_number:set_font_size(42)
end

function HUDCODZ:_wave_change(wave_nb)

end

function HUDCODZ:_wave_change_anim(new_wave)
    local function switch_anim(o)      
        o:set_color(Color(1, 1, 1, 1))

        over(0.5, function (p)
            o:set_color(o:color():with_alpha(1 - p))
        end)
        over(0.5, function (p)
            o:set_color(o:color():with_alpha(p))
        end)
        over(0.5, function (p)
            o:set_color(o:color():with_alpha(1 - p))
        end)
        over(0.5, function (p)
            o:set_color(o:color():with_alpha(p))
        end)
        over(0.5, function (p)
            o:set_color(o:color():with_alpha(1 - p))
        end)
        over(0.5, function (p)
            o:set_color(o:color():with_alpha(p))
        end)
        over(0.5, function (p)
            o:set_color(o:color():with_alpha(1 - p))
        end)
        over(0.5, function (p)
            o:set_color(o:color():with_alpha(p))
        end)
        over(0.5, function (p)
            o:set_color(o:color():with_alpha(1 - p))
        end)
        over(0.5, function (p)
            o:set_color(o:color():with_alpha(p))
        end)
        over(0.5, function (p)
            o:set_color(o:color():with_alpha(1 - p))
        end)
        over(0.5, function (p)
            o:set_color(o:color():with_alpha(p))
        end)
        over(0.5, function (p)
            o:set_color(o:color():with_alpha(1 - p))
        end)
        over(0.5, function (p)
            o:set_color(o:color():with_alpha(p))
        end)
        over(1, function (p)
            o:set_color(o:color():with_alpha(1 - p))
        end)

        o:set_text(new_wave)

        wait(1)

        local from = Color(0, 1, 1, 1)
        local to = Color(1, 1, 1, 1)
        local t = 0

        o:set_color(from)

        while t < 1 do
            local dt = coroutine.yield()
            t = t + dt

            o:set_color(from * (1 - t) + to * t)
        end

        o:set_color(to)

        from = Color(1, 1, 1, 1)
        to = Color(1, 0.6, 0, 0)
        t = 0

        o:set_color(from)

        while t < 1 do
            local dt = coroutine.yield()
            t = t + dt

            o:set_color(from * (1 - t) + to * t)
        end

        o:set_color(to)
    end

    self._codz_wave_number:animate(switch_anim)
end

function HUDCODZ:_init_points(parent)
    self._points_panel = parent:panel({
        name = "points_panel",
        h = 64 * #SkyLib.CODZ._players + (5 * #SkyLib.CODZ._players),
        w = 400
    })
    self._points_panel:set_top(self._codz_wave_panel:bottom())

    for player_id, player_data in ipairs(SkyLib.CODZ._players) do
        local player_panel = self._points_panel:panel({
            name = "player_panel_" .. player_id,
            h = 64,
            visible = false
        })

        if player_id > 1 then
            local prev_panel_id = player_id - 1
            self._points_panel:child("player_panel_" .. player_id):set_top(self._points_panel:child("player_panel_" .. prev_panel_id):bottom())
        end

        local player_avatar = player_panel:bitmap({
            name = "player_avatar_" .. player_id,
            texture = "guis/textures/pd2/none_icon",
            h = 64,
            w = 64
        })

        local player_bg_points = player_panel:bitmap({
            name = "player_bg_points_" .. player_id,
            layer = -1,
            texture = "ui/bloodtrail",
            h = 32,
            w = 128
        })

        player_bg_points:set_left(player_avatar:right() + 5)
        player_bg_points:set_world_center_y(player_avatar:world_center_y())

        local player_points = player_panel:text({
            name = "player_points_" .. player_id,
            font = HUDCODZ.DEFAULT_FONT,
            font_size = 26,
            text = "9999999",
            color = tweak_data.chat_colors[player_id]
        })
        managers.hud:make_fine_text(player_points)

        player_points:set_left(player_avatar:right() + 20)
        player_points:set_world_center_y(player_avatar:world_center_y())
    end
end

function HUDCODZ:_create_gift_hud(parent)
    local is_firesale = false
    local is_instakill = false
    local is_double_points = false
    local is_zombie_blood = false

    local gift_panel = parent:panel({
        name = "gift_panel",
        w = parent:w(),
        h = 64
    })
    gift_panel:set_y(parent:bottom() - 200)

    self.gift_panel = gift_panel

    local weapon_name_bottom_right = gift_panel:text({
        font = "units/pd2_mod_zombies/fonts/escom_outline",
        font_size = 18,
        color = Color(0.8, 0.8, 0.8),
        text = "",
        align = "right",
        vertical = "bottom",
        valign = "bottom",
        y = -16
    })
    weapon_name_bottom_right:set_center_x(parent:center_x())
    weapon_name_bottom_right:set_text(managers.localization:text("wpn_m1911_name"))

    self.weapon_name_bottom_right = weapon_name_bottom_right

    local icon_instakill = gift_panel:bitmap({
        name = "icon_instakill",
        texture = "units/pd2_mod_zombies/guis/power_ups/power_instakill",
        w = 64,
        h = 64,
        visible = is_instakill
    })
    icon_instakill:set_center_x(parent:center_x())

    local icon_firesale = gift_panel:bitmap({
        name = "icon_firesale",
        texture = "units/pd2_mod_zombies/guis/power_ups/power_fire_sale",
        w = 64,
        h = 64,
        visible = is_firesale
    })
    icon_firesale:set_right(icon_instakill:left())

    local icon_double_points = gift_panel:bitmap({
        name = "icon_double_points",
        texture = "units/pd2_mod_zombies/guis/power_ups/power_double_points",
        w = 64,
        h = 64,
        visible = is_double_points
    })
    icon_double_points:set_left(icon_instakill:right())

    local icon_zombie_blood = gift_panel:bitmap({
        name = "icon_zombie_blood",
        texture = "units/pd2_mod_zombies/guis/power_ups/power_zombie_blood",
        w = 64,
        h = 64,
        visible = is_zombie_blood
    })

    icon_zombie_blood:set_left(icon_double_points:right())
end

function HUDCODZ:_set_gift_visible(gift, visible)
    local texture = self.gift_panel:child(gift)
    texture:set_visible(visible)

    local function animate_icon_lifetime(o)
        o:stop()

        local from = 1
        local to = 0
        local t = 0

        o:set_alpha(from)
        wait(18)
        
        o:set_alpha(to)
        wait(0.25)
        o:set_alpha(from)
        wait(0.25)
        o:set_alpha(to)
        wait(0.25)
        o:set_alpha(from)
        wait(0.25)
        o:set_alpha(to)
        wait(0.25)
        o:set_alpha(from)
        wait(0.25)
        o:set_alpha(to)
        wait(0.25)
        o:set_alpha(from)
        wait(0.25)
        o:set_alpha(to)
        wait(0.25)
        o:set_alpha(from)
        wait(0.25)
        o:set_alpha(to)
        wait(0.25)
        o:set_alpha(from)
        wait(0.25)
        o:set_alpha(to)
        wait(0.25)
        o:set_alpha(from)
        wait(0.25)
        o:set_alpha(to)
        wait(0.25)
        o:set_alpha(from)
        wait(0.25)
        o:set_alpha(to)
        wait(0.25)
        o:set_alpha(from)
        wait(0.25)
        o:set_alpha(to)
        wait(0.25)
        o:set_alpha(from)
        wait(0.25)
        o:set_alpha(to)
        wait(0.25)
        o:set_alpha(from)
        wait(0.25)
        o:set_alpha(to)
        wait(0.25)
        o:set_alpha(from)
        wait(0.25)
        o:set_alpha(to)
        wait(0.25)
        o:set_alpha(from)
        wait(0.25)
        o:set_alpha(to)
        wait(0.25)
        o:set_alpha(from)
        wait(0.25)

        o:set_alpha(to)
        wait(0.1)
        o:set_alpha(from)
        wait(0.1)
        o:set_alpha(to)
        wait(0.1)
        o:set_alpha(from)
        wait(0.1)
        o:set_alpha(to)
        wait(0.1)
        o:set_alpha(from)
        wait(0.1)
        o:set_alpha(to)
        wait(0.1)
        o:set_alpha(from)
        wait(0.1)
        o:set_alpha(to)
        wait(0.1)
        o:set_alpha(from)
        wait(0.1)

        o:set_alpha(to)
        wait(0.1)
        o:set_alpha(from)
        wait(0.1)
        o:set_alpha(to)
        wait(0.1)
        o:set_alpha(from)
        wait(0.1)
        o:set_alpha(to)
        wait(0.1)
        o:set_alpha(from)
        wait(0.1)
        o:set_alpha(to)
        wait(0.1)
        o:set_alpha(from)
        wait(0.1)
        o:set_alpha(to)
        wait(0.1)
        o:set_alpha(from)
        wait(0.1)

        o:set_alpha(to)
        wait(0.1)
        o:set_alpha(from)
        wait(0.1)
        o:set_alpha(to)
        wait(0.1)
        o:set_alpha(from)
        wait(0.1)
        o:set_alpha(to)
        wait(0.1)
        o:set_alpha(from)
        wait(0.1)
        o:set_alpha(to)
        wait(0.1)
        o:set_alpha(from)
        wait(0.1)
        o:set_alpha(to)
        wait(0.1)
        o:set_alpha(from)
        wait(0.1)

        o:set_alpha(to)
        wait(0.1)
        o:set_alpha(from)
        wait(0.1)
        o:set_alpha(to)
        wait(0.1)
        o:set_alpha(from)
        wait(0.1)
        o:set_alpha(to)
        wait(0.1)
        o:set_alpha(from)
        wait(0.1)
        o:set_alpha(to)
        wait(0.1)
        o:set_alpha(from)
        wait(0.1)
        o:set_alpha(to)
        wait(0.1)
        o:set_alpha(from)
        wait(0.1)

        o:set_alpha(to)
        wait(0.1)
        o:set_alpha(from)
        wait(0.1)
        o:set_alpha(to)
        wait(0.1)
        o:set_alpha(from)
        wait(0.1)
        o:set_alpha(to)
        wait(0.1)
        o:set_alpha(from)
        wait(0.1)
        o:set_alpha(to)
        wait(0.1)
        o:set_alpha(from)
        wait(0.1)
        o:set_alpha(to)
        wait(0.1)
        o:set_alpha(from)
        wait(0.1)

        o:set_alpha(to)
        wait(0.1)
        o:set_alpha(from)
        wait(0.1)
        o:set_alpha(to)
        wait(0.1)
        o:set_alpha(from)
        wait(0.1)
        o:set_alpha(to)
        wait(0.1)
        o:set_alpha(from)
        wait(0.1)
        o:set_alpha(to)
        wait(0.1)
        o:set_alpha(from)
        wait(0.1)
        o:set_alpha(to)
        wait(0.1)
        o:set_alpha(from)
        wait(0.1)

        o:set_alpha(to)
		
		--But why...
        
    end

    texture:animate(animate_icon_lifetime)
end