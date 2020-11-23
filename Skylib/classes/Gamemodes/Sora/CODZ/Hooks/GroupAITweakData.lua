Hooks:PostHook(GroupAITweakData, "_init_unit_categories", "zm_allow_clk_dozers", function(self, difficulty_index)
    self.special_unit_spawn_limits = {
        shield = 4,
        medic = 3,
        taser = 2,
        tank = 6,
        spooc = 4
    }
end)

Hooks:PostHook(GroupAITweakData, "_init_task_data", "zm_init_task_data", function(self)
    self.besiege.assault.force = {
        56,
        64,
        70
    }

    self.besiege.assault.force_balance_mul = {
        1,
        1,
        1,
        1
    }
end)