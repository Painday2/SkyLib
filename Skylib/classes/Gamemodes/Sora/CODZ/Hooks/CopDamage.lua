local CopDmg_damage_bullet_oworiginal = CopDamage.damage_bullet

function CopDamage:damage_bullet(attack_data, ...)
	if self._dead or self._invulnerable then
		return
	end

	if (attack_data.knock_down and "knock_down") then
		return
	end

    if SkyLib.CODZ:_is_event_active("instakill") then
        self._health = 1
    end

    if attack_data.attacker_unit == managers.player:player_unit() and not attack_data.knock_down or attack_data.stagger then
        local peer_id = SkyLib.Network:_my_peer_id()
        local hit_points = SkyLib.CODZ:_is_event_active("double_points") and SkyLib.CODZ._economy.on_hit * 2 or SkyLib.CODZ._economy.on_hit

        SkyLib.CODZ:_money_change(hit_points, peer_id)
    end

    CopDmg_damage_bullet_oworiginal(self, attack_data, ...)
end

function CopDamage:zm_instakill_check(attack_data)
	if self._dead or self._invulnerable then
		return
	end

    if SkyLib.CODZ:_is_event_active("instakill") then
        self._health = 1
    end

    if attack_data.attacker_unit == managers.player:player_unit() then
        local peer_id = SkyLib.Network:_my_peer_id()
        local hit_points = SkyLib.CODZ:_is_event_active("double_points") and SkyLib.CODZ._economy.on_hit * 2 or SkyLib.CODZ._economy.on_hit

        SkyLib.CODZ:_money_change(hit_points, peer_id)
    end
end
--All of the below prehooks are for instakill checks
SkyHook:Pre(CopDamage, "damage_explosion", function(self, attack_data)
    self:zm_instakill_check(attack_data)
end)

SkyHook:Pre(CopDamage, "damage_fire", function(self, attack_data)
    self:zm_instakill_check(attack_data)
end)

SkyHook:Pre(CopDamage, "damage_tase", function(self, attack_data)
    self:zm_instakill_check(attack_data)
end)

SkyHook:Pre(CopDamage, "damage_simple", function(self, attack_data)
	if (attack_data.knock_down and "knock_down") then
		return
	end

    self:zm_instakill_check(attack_data)
end)

SkyHook:Pre(CopDamage, "damage_melee", function(self, attack_data)
	if attack_data.shield_knock and self._char_tweak.damage.shield_knocked and "shield_knock" or attack_data.variant == "counter_tased" and "counter_tased" or attack_data.variant == "taser_tased" and "taser_tased" or attack_data.variant == "counter_spooc" and "expl_hurt" or "fire_hurt" then
		return
	end

    self:zm_instakill_check(attack_data)
end)

function CopDamage:_dismember_condition(attack_data)
	if alive(attack_data.col_ray.unit) and attack_data.col_ray.unit:base() then
		target_is_shadow_spooc = attack_data.col_ray.unit:base()._tweak_table == "shadow_spooc"
	end

	if target_is_shadow_spooc then
		return false
	end

	return true
end

function CopDamage:_sync_dismember(attacker_unit)
	return true
end

function CopDamage:_check_special_death_conditions(variant, body, attacker_unit, weapon_unit)
	local special_deaths = self._unit:base():char_tweak().special_deaths

	if not special_deaths or not special_deaths[variant] then
		return
	end

	local body_data = special_deaths[variant][body:name():key()]

	if not body_data then
		return
	end

    if self._unit:damage():has_sequence(body_data.sequence) then
        self._unit:damage():run_sequence_simple(body_data.sequence)
    end

    if body_data.special_comment and attacker_unit == managers.player:player_unit() then
        return body_data.special_comment
    end
end
--[[function CopDamage:drop_pickup(extra)
	if self._pickup then
		local tracker = self._unit:movement():nav_tracker()
		local position = tracker:lost() and tracker:field_position() or tracker:position()
		local rotation = self._unit:rotation()

		mvector3.set(mvec_1, position)

		managers.game_play_central:spawn_pickup({
			name = self._pickup,
			position = mvec_1,
			rotation = rotation
		})

		SkyLib.Sound:play({
			name = "zm_pwrup_float_spawn",
			file_name = "zm_pwrup_float_spawn.ogg",
			custom_package = "assets_zm",
			custom_dir = "units/pd2_mod_zombies/sounds/zm_power_ups",
			sound_type = "sfx",
			is_relative = false,
			is_loop = false,
			is_3d = true,
			position = position,
			use_velocity = false
		})
	end
end]]

SkyHook:Post(CopDamage, "init", function(self, unit)
    self._pickup = nil
end)

function CopDamage:_spawn_head_gadget(params)
	if not self._head_gear then
		return
	end

	if self._head_gear_object then
		if self._head_gear_decal_mesh then
			local mesh_name_idstr = Idstring(self._head_gear_decal_mesh)

			self._unit:decal_surface(mesh_name_idstr):set_mesh_material(mesh_name_idstr, Idstring("flesh"))
		end
    end

	self._head_gear = false
end

function CopDamage:chk_killshot(attacker_unit, variant, headshot, weapon_id)
    if headshot then
        local table_sound_headshots = {
            "zm_hs_1",
            "zm_hs_2",
            "zm_hs_3"
        }

        local hs_sound = SoundDevice:create_source("boom_headshot")
        hs_sound:set_position(self._unit:position())
        hs_sound:post_event(table_sound_headshots[math.random(#table_sound_headshots)])
    end

	if attacker_unit and attacker_unit == managers.player:player_unit() then
		managers.player:on_killshot(self._unit, variant, headshot, weapon_id)
	end
end

SkyHook:Post(CopDamage, "die", function(self)
	if Network:is_server() then
		self._unit:contour():remove("highlight_character", true)
	end

	if alive(self._unit:base()._headwear_unit) then
		self._unit:base()._headwear_unit:set_slot(0)
	end
end)