core:import("CoreMissionScriptElement")
ElementReviveInstigator = ElementReviveInstigator or class(CoreMissionScriptElement.MissionScriptElement)

function ElementReviveInstigator:init(...)
	ElementReviveInstigator.super.init(self, ...)
end
function ElementReviveInstigator:client_on_executed(...)
	self:on_executed(...)
end

function ElementReviveInstigator:on_executed(instigator)

	if not self._values.enabled then
		self._mission_script:debug_output("Element '" .. self._editor_name .. "' not enabled. Skip.", Color(1, 1, 0, 0))
		return
    end
    
    if instigator then
        if instigator == managers.player:player_unit() then
            instigator:character_damage():revive(true)
        end
    end

	ElementReviveInstigator.super.on_executed(self, instigator)
end

function ElementReviveInstigator:on_script_activated()
    self._mission_script:add_save_state_cb(self._id)
end

function ElementReviveInstigator:save(data)
    data.save_me = true
    data.enabled = self._values.enabled
end

function ElementReviveInstigator:load(data)
    self:set_enabled(data.enabled)
end
