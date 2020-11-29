Hooks:PostHook(EnemyManager, "register_enemy", "zm_antiblock2", function(self, enemy)
    managers.player:_update_cops_alive(1)
end)

Hooks:PostHook(EnemyManager, "on_enemy_unregistered", "zm_antiblock1", function(self, unit)
    managers.player:_update_cops_alive(-1)
end)