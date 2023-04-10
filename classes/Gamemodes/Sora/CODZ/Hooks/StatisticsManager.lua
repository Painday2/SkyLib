Hooks:PostHook(StatisticsManager, "init", "zm_init_vars_stats", function(self)
    self._session_player_revives = 0
end)

Hooks:PostHook(StatisticsManager, "killed", "zm_init_add_zmpoints", function(self, data)

    local double_point_effect = SkyLib.CODZ:_is_event_active("double_points") and 2 or 1
    local peer_id = SkyLib.Network:_my_peer_id()
	local by_melee = data.variant == "melee" or data.weapon_id and tweak_data.blackmarket.melee_weapons[data.weapon_id]
    local points_to_add = 0
    local category

    if by_melee then
        category = "on_melee_kill"
        points_to_add = SkyLib.CODZ:_get_points_amount(category) * double_point_effect

        SkyLib.CODZ:_money_change(points_to_add, peer_id)

    else
        category = "on_kill"
        points_to_add = SkyLib.CODZ:_get_points_amount(category, data.name) + (data.head_shot and SkyLib.CODZ:_get_points_amount("on_headshot") or 0) * double_point_effect

        SkyLib.CODZ:_money_change(points_to_add, peer_id)
    end

    if alive(managers.player:player_unit()) then
        local random = math.random(0, 100)

        if random <= 1 then
            managers.player:player_unit():sound():say("v46", true, true)
        end
    end
end)

function StatisticsManager:send_zm_stats()
	local total_kills = self:session_total_kills()
    local total_specials_kills = self:session_total_specials_kills()
    local total_kills_combined = total_kills + total_specials_kills
	local downs = self:total_downed()
    local revives = self._session_player_revives

    local tbl = {
        kills = total_kills_combined,
        downs = downs,
        revives = revives,
        total_score = SkyLib.CODZ._players[SkyLib.Network:_my_peer_id()].codz_score
    }

    local panel_endgame = managers.hud._zm_result_panel[SkyLib.Network:_my_peer_id()]
    local kills_text = panel_endgame:child("total_kills")
    local downs_text = panel_endgame:child("total_downs")
    local revives_text = panel_endgame:child("total_revives")
    kills_text:set_text(tostring(tbl.kills))
    downs_text:set_text(tostring(tbl.downs))
    revives_text:set_text(tostring(tbl.revives))

    if not managers.network:session() then
		return
	end

    SkyLib.Network:_send("ZMStatsEndGame", data)
end

Hooks:PostHook(StatisticsManager, "revived", "zm_count_revives", function(self, data)
    if not data.reviving_unit or data.reviving_unit ~= managers.player:player_unit() then
		return
    end
    
    self._session_player_revives = self._session_player_revives + 1
end)