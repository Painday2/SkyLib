--TODO: set this up with an element
function GroupAIStateBase:begin_gameover_fadeout()
    managers.hud:init_ending_screen()
   SkyLib:wait(2, function()
       managers.statistics:send_zm_stats()
   end)
	-- ALL DIED EXECUTE FAIL ELEMENT
    local element = managers.mission:get_mission_element_by_name("revive")
    element:on_executed()
end