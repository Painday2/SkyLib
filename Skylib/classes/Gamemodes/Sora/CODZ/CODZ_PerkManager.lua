SkyLib.CODZ.PerkManager = SkyLib.CODZ.PerkManager or class()

local Utils = SkyLib.Utils

function SkyLib.CODZ.PerkManager:init()
    SkyLib:log("[CODZ.PerkManager] Initd")
    self.flopper_cooldown = 1
    self.cherry_cooldown = 1
end

function SkyLib.CODZ.PerkManager:update(t, dt)
    self.flopper_cooldown = self.flopper_cooldown - dt
    self.cherry_cooldown = self.cherry_cooldown - dt
end

function SkyLib.CODZ.PerkManager:do_flopper_explosion()
    if self.flopper_cooldown > 0 then
        return
    end

    self.flopper_cooldown = 30

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
    managers.network:session():send_to_peers_synched("element_explode_on_client", pos, rot:z(), damage, range, 5)

    local data = {
        range = tostring(range),
        x = tostring(pos.x),
        y = tostring(pos.y),
        z = tostring(pos.z),
        effect_index = "0",
        sound_event = "trip_mine_explode"
    }
    SkyLib.Network:_send("ZMSendEffect", data)
end

function SkyLib.CODZ.PerkManager:do_cherry_tase()
    --If cooldown isn't done, don't execute
    if self.cherry_cooldown > 0 then
        return
    end
    --Set player's cooldown on using the tase effect
    self.cherry_cooldown = 30

    local player_unit = managers.player:player_unit()

    if not alive(player_unit) then
        return
    end

    local current_weapon = managers.player:get_current_state():get_equipped_weapon()
    local max_clip, ammo_left_in_clip = current_weapon._unit:base():ammo_info()
    --log(tostring(max_clip), " ", tostring(ammo_left_in_clip))
    local pos = player_unit:position()
    local normal = math.UP
    local range = 100

    --math shit, someone else wants to do smarter math you're welcome to.
    if ammo_left_in_clip == 0 then
        range = 750
    else
        range = math.clamp(math.floor(max_clip * 2 / ammo_left_in_clip * 75), 100, 500)
    end

    managers.explosion:play_sound_and_effects(pos, normal, range, {effect = "effects/particles/explosions/electric_grenade", sound_event = "tasered_shock"})

    managers.explosion:detect_and_tase({
        player_damage = 0,
        tase_strength = "heavy",
        hit_pos = pos,
        range = range,
        collision_slotmask = managers.slot:get_mask("explosion_targets"),
        curve_pow = 5,
        damage = 2500,
        ignore_unit = player_unit,
        alert_radius = 0,
        user = player_unit,
    })
    local data = {
        range = tostring(range),
        x = tostring(pos.x),
        y = tostring(pos.y),
        z = tostring(pos.z),
        effect_index = "1",
        sound_event = "tasered_shock"
    }
    SkyLib.Network:_send("ZMSendEffect", data)
end

function SkyLib.CODZ.PerkManager:do_effect(pos, range, effect, sound_event)
    local normal = math.UP

    managers.explosion:play_sound_and_effects(pos, normal, range, {effect = effect, sound_event = sound_event})
end

SkyHook:Post(PlayerStandard, "_start_action_reload", function (self, t)
    local weapon = self._equipped_unit:base()
	if weapon and weapon:can_reload() then
	    if managers.player:has_special_equipment("perk_cherry") then
		    SkyLib.CODZ.PerkManager:do_cherry_tase()
	    end
    end
end)

SkyHook:Post(PlayerManager, "update", function(self, t, dt)
    SkyLib.CODZ.PerkManager:update(t, dt)
end)