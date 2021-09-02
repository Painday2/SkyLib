core:import("CoreMissionScriptElement")
ElementAnnouncerGift = ElementAnnouncerGift or class(CoreMissionScriptElement.MissionScriptElement)

function ElementAnnouncerGift:init(...)
	ElementAnnouncerGift.super.init(self, ...)
end
function ElementAnnouncerGift:client_on_executed(...)
	self:on_executed(...)
end

function ElementAnnouncerGift:on_executed(instigator)

	if not self._values.enabled then
		self._mission_script:debug_output("Element '" .. self._editor_name .. "' not enabled. Skip.", Color(1, 1, 0, 0))
		return
	end

    if self._values.gift_id == "max_ammo" then
        SkyLib.CODZ.PowerUpManager:execute_max_ammo()
    end

    if self._values.gift_id == "firesale" then
        SkyLib.CODZ.PowerUpManager:execute_firesale()
    end

    if self._values.gift_id == "firesale_first" then
    -- Scripted in game
    end

    if self._values.gift_id == "firesale_disable" then
        SkyLib.CODZ:_setup_event_state("firesale", false)
        managers.hud._hud_codz:_set_gift_visible("icon_firesale", false)
    end

    if self._values.gift_id == "double_points" then
        SkyLib.CODZ.PowerUpManager:execute_double_points()
    end

    if self._values.gift_id == "double_points_disable" then
        SkyLib.CODZ:_setup_event_state("double_points", false)
        managers.hud._hud_codz:_set_gift_visible("icon_double_points", false)    
    end

    if self._values.gift_id == "instakill" then
        SkyLib.CODZ.PowerUpManager:execute_instakill()
    end

    if self._values.gift_id == "instakill_disable" then
        SkyLib.CODZ:_setup_event_state("instakill", false)
        managers.hud._hud_codz:_set_gift_visible("icon_instakill", false)      
    end

    if self._values.gift_id == "kaboom" then
        log("kaboom")
        SkyLib.CODZ.PowerUpManager:execute_kaboom()
    end
	
	ElementAnnouncerGift.super.on_executed(self, instigator)
end

function ElementAnnouncerGift:on_script_activated()
    self._mission_script:add_save_state_cb(self._id)
end

function ElementAnnouncerGift:save(data)
    data.save_me = true
    data.enabled = self._values.enabled
end

function ElementAnnouncerGift:load(data)
    self:set_enabled(data.enabled)
end