local CopDmg_damage_bullet_oworiginal = CopDamage.damage_bullet

function CopDamage:damage_bullet(attack_data, ...)
	if self._dead or self._invulnerable then
		return
	end
	
	if (attack_data.knock_down and "knock_down") then
		return
	end
--[[
    if managers.wdu:_is_event_active("instakill") then
        self._health = 1
    end
--]]
    if attack_data.attacker_unit == managers.player:player_unit() and not attack_data.knock_down or attack_data.stagger then
        local peer_id = SkyLib.Network:_my_peer_id()
        local hit_points = SkyLib.CODZ._economy.on_hit

        SkyLib.CODZ:_money_change(hit_points, peer_id)
    end

    CopDmg_damage_bullet_oworiginal(self, attack_data, ...) 
end

SkyHook:Post(CopDamage, "die", function(self)
	if Network:is_server() then
		self._unit:contour():remove("highlight_character", true)
	end
	
	if alive(self._unit:base()._headwear_unit) then
		self._unit:base()._headwear_unit:set_slot(0)
	end
end)