SkyHook:Post(GroupAITweakData, "_init_unit_categories", function(self, difficulty_index)
    self.special_unit_spawn_limits = {
        shield = 4,
        medic = 3,
        taser = 2,
        tank = 6,
        spooc = 4
    }
end)

SkyHook:Post(GroupAITweakData, "_init_task_data", function(self)
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