SkyLib.Survival.WeaponHelper = SkyLib.Survival.WeaponHelper or class()

function SkyLib.Survival.WeaponHelper:init()
    log("[SkyLib.Survival.WeaponHelper] Initd")
end

function SkyLib.Survival.WeaponHelper:_add_new_weapon(data)
    local tweak = tweak_data.weapon

    --[[
        All weapons added are allowed for sale by default.

        data = {
            { weapon_id = "ak74", price = 3000 },
            { weapon_id = "new_m4", price = 9000, disable_sales = true },
            { weapon_id = "usp", price = 100 },
            ...
        }
    ]]

    for i, weapon_data in ipairs(data) do
        if tweak[weapon_data.weapon_id] then
            tweak[weapon_data.weapon_id].survival_cost = tonumber(weapon_data.price)
            SkyLib.Survival._weapons[i] = { weapon_data.weapon_id, weapon_data.price }
            
            if not weapon_data.disable_sales then
                SkyLib.Survival._sales[i] = { 
                    weapon_id = weapon_data.weapon_id, 
                    sale_status = false, 
                    sale_discount = 0 
                }
            end
        else
            log("[ERROR-WeaponHelper._add_new_weapon] Weapon id doesn't exist!", weapon_id)
        end
    end
end

function SkyLib.Survival.WeaponHelper:_change_stats_of(weapon_id, tbl_new_stats)
    -- Provide stats in a normal way, as in stability 88 WILL mean 84 in game 
    -- (you remove -4 due to some obscure reason for recoil and spread)
    -- Same for rof, I do the maths for you
    -- Due to damage caps, please use damage_mul with a low damage value. (10 damage with 100 mul = 10*100 = 1000.)

    -- SkyLib.Survival.WeaponHelper:_change_stats_of( "usp" , { rof = 600, damage = 100 } )
    -- SkyLib.Survival.WeaponHelper:_change_stats_of( "new_m4" , { rof = 900, damage = 60, damage_mul = 3, total_clips = 4 } )
    -- SkyLib.Survival.WeaponHelper:_change_stats_of( "ak74" , { cost = 2000, stability = 80, accuracy = 60 } )

    if not tweak_data.weapon[weapon_id] then log("[ERROR-WeaponHelper._change_stats_of] Weapon id doesn't exist!", weapon_id) return end

    local stats = {
        damage = tbl_new_stats.damage or nil,
        damage_mul = tbl_new_stats.damage_mul or nil,
        stability = tbl_new_stats.stability or nil,
        accuracy = tbl_new_stats.accuracy or nil,
        rof = tbl_new_stats.rof or nil,
        cost = tbl_new_stats.cost or nil,
        allow_sale = tbl_new_stats.allow_sale or nil,
        clip_ammo = tbl_new_stats.clip_ammo or nil,
        total_clips = tbl_new_stats.total_clips or nil
    }

    for stat, value in pairs(stats) do
        if stat == "damage" then tweak_data.weapon[weapon_id].stats.damage = value end
        if stat == "damage_mul" then
            if tweak_data.weapon[weapon_id].stats_modifiers then
                tweak_data.weapon[weapon_id].stats_modifiers.damage = value
            else
                tweak_data.weapon[weapon_id].stats_modifiers = {}
                tweak_data.weapon[weapon_id].stats_modifiers.damage = value
            end
        end
        if stat == "stability" then tweak_data.weapon[weapon_id].stats.recoil = (value / 4) end
        if stat == "accuracy" then tweak_data.weapon[weapon_id].stats.spread = (value / 4) end
        if stat == "rof" then tweak_data.weapon[weapon_id].fire_mode_data.fire_rate = (60 / value) end
        if stat == "cost" then tweak_data.weapon[weapon_id].survival_cost = value end
        if stat == "allow_sale" then tweak_data.weapon[weapon_id].allowed_for_sale = value end
        if stat == "clip_ammo" then tweak_data.weapon[weapon_id].CLIP_AMMO_MAX = value end
        if stat == "total_clips" then tweak_data.weapon[weapon_id].NR_CLIPS_MAX = value end

        if stat == "clip_ammo" or stat == "total_clips" then
            tweak_data.weapon[weapon_id].AMMO_MAX = tweak_data.weapon[weapon_id].CLIP_AMMO_MAX * tweak_data.weapon[weapon_id].NR_CLIPS_MAX
        end
    end
end

function SkyLib.Survival.WeaponHelper:_add_mod_to_weapon(equipped_unit, part_id)
    local factory_id = equipped_unit:base()._factory_id
    local weapon_id = managers.weapon_factory:get_weapon_id_by_factory_id(factory_id)
    local blueprint = equipped_unit:base()._blueprint

    if not self:_weapon_has_part(weapon_id, part_id) then
        SkyLib:log("[SkyLib.Survival.WeaponHelper:_add_mod_to_weapon] Error! Part <".. tostring(part_id) .."> do not exist for the weapon <".. tostring(weapon_id) .."> (".. tostring(factory_id) .. ")")
        return blueprint
    end

    table.insert(blueprint, part_id)

    local new_blueprint = managers.weapon_factory:get_assembled_blueprint(factory_id, blueprint)

    return new_blueprint
end

function SkyLib.Survival.WeaponHelper:_current_equipped_weapon()
    return managers.player:player_unit():inventory():equipped_unit()
end

function SkyLib.Survival.WeaponHelper:_weapon_has_part(weapon_id, part_id)
    local uses_parts = managers.weapon_factory:get_parts_from_weapon_id(weapon_id)

    for type, parts in pairs(uses_parts) do
        for _, part in ipairs(parts) do
            if part == part_id then
                return true
            end
        end
    end

    return false
end