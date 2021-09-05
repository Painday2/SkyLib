SkyLib.CODZ.PerkManager = SkyLib.CODZ.PerkManager or class()

local Utils = SkyLib.Utils

function SkyLib.CODZ.PerkManager:init()
    SkyLib:log("[CODZ.PerkManager] Initd")
end

function SkyLib.CODZ.PerkManager:do_flopper_explosion()
    local player_unit = managers.player:player_unit()

	if not alive(player_unit) then
		return
	end

	local pos = player_unit:position()
    local rot = player_unit:rotation()
    local damage = 5000
    local range = 250
    managers.explosion:spawn_sound_and_effects(pos, rot:z(), range, "effects/particles/explosions/explosion_grenade_launcher", "trip_mine_explode")
    managers.explosion:detect_and_give_dmg({
        curve_pow = 5,
        player_damage = 0,
        hit_pos = pos,
        range = range,
        collision_slotmask = managers.slot:get_mask("explosion_targets"),
        damage = damage,
        no_raycast_check_characters = false
    })
    managers.network:session():send_to_peers_synched("sync_explosion_to_client", player_unit, pos, rot:z(), damage, range, 5)
end