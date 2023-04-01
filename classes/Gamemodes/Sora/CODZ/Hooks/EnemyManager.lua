SkyHook:Post(EnemyManager, "register_enemy", function(self, enemy)
    managers.player:_update_cops_alive(1)
end)

SkyHook:Post(EnemyManager, "on_enemy_unregistered", function(self, unit)
    managers.player:_update_cops_alive(-1)
end)