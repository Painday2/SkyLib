SkyLib.CODZ.WeaponHelper = SkyLib.CODZ.WeaponHelper or class()

function SkyLib.CODZ.WeaponHelper:init()
    log("[SkyLib.CODZ.WeaponHelper] Initd")
end

function SkyLib.CODZ.WeaponHelper:_create_new_weapon(data)

    --[[
        Parameters:

        {
            weapon_id = "xxx"                                           -- ID Used in weapontweakdata
            factory_id = "wpn_fps_smg_xxx"                              -- ID Used in weaponfactorytweakdata
            based_on = {                                                -- IDs about the base weapon.
                weapon_id = "based_on_id",
                factory_id = "wpn_fps_smg_based_on"
            }
            generate_stances = true/false ; default: false              -- Automatically generate stances
            custom_factory_unit = "path_to_unit"                        -- Defines a new unit. If nothing defined, use the one from based_on.
            custom_blueprint = {                                        -- Weapon mod IDs for the new blueprint. If nothing defined, use the one from based_on.
                <blueprint data>
            }
            custom_stats = {                                            -- Stats as they would be defined in weapontweakdata. If nothing defined, use the one from based_on.
                <custom stats>
            },
            custom_ammo_clip = 30                                       -- How much bullets in mag. If nothing defined, use the one from based_on.
            custom_ammo_clips_max = 5                                   -- How much mags (Ammo clip * Clip Max). If nothing defined, use the one from based_on.
            custom_animation = {                                        -- Sometimes you have to define these, to make animations working. If nothing defined, use the one from based_on.
                hold = "anim",
                reload = "anim"
            }
        }

        weapon name string ID is defined:           wpn_<weapon_id>_name
    ]]

    local weapon_data = {
        weapon_id = data.weapon_id,
        factory_id = data.factory_id,
        based_on = data.based_on,
        generate_stances = data.generate_stances or false,
        custom_factory_unit = data.custom_factory_unit or nil,
        custom_blueprint = data.custom_blueprint or nil,
        custom_stats = data.custom_stats or nil,
        custom_ammo_clip = data.custom_ammo_clip or nil,
        custom_ammo_clips_max = data.custom_ammo_clips_max or nil,
        custom_animation = data.custom_animation or nil
    }

end

local debug
function SkyLib.CODZ.WeaponHelper:_get_random_weapon()
    --PrintTable(SkyLib.CODZ._weapons.mystery_box)
    debug = tostring(SkyLib.CODZ._weapons.mystery_box[math.random(#SkyLib.CODZ._weapons.mystery_box)])
    log(debug)
    SkyLib.CODZ.WeaponHelper:_perform_weapon_switch(debug)
end

function SkyLib.CODZ.WeaponHelper:_perform_weapon_switch(weapon_id, instigator, force_secondary, force_primary, pap, skin)
    local factory_id
    local blueprint
    local current_index_equipped
    local cosmetics = skin or {
        id = "nil",
        quality = 1,
        bonus = 0
    }

    if weapon_id then
        --log(tostring(weapon_id))
        factory_id = managers.weapon_factory:get_factory_id_by_weapon_id(tostring(weapon_id))
        --log(tostring(factory_id))
        blueprint = managers.weapon_factory:get_default_blueprint_by_factory_id(factory_id)
        current_index_equipped = managers.player:player_unit():inventory():equipped_selection()
    elseif pap then
        local current_peer_weapon = managers.player:player_unit():inventory():equipped_unit()
        factory_id = current_peer_weapon:base()._factory_id
        weapon_id = managers.weapon_factory:get_weapon_id_by_factory_id(factory_id)
        current_index_equipped = managers.player:player_unit():inventory():equipped_selection()
        local primary_category = current_peer_weapon:base():weapon_tweak_data().categories and current_peer_weapon:base():weapon_tweak_data().categories[1]
        if current_peer_weapon:base():get_cosmetics_id() == "pap3" then
            cosmetics = {id = "pap3", quality = 5, bonus = 0 }
            blueprint = current_peer_weapon:base()._blueprint
        elseif current_peer_weapon:base():get_cosmetics_id() == "pap2" then
            cosmetics = {id = "pap3", quality = 5, bonus = 0 }
            self._change_stats_of(nil, weapon_id, {damage_mul = 8})
            blueprint = current_peer_weapon:base()._blueprint
        elseif current_peer_weapon:base():get_cosmetics_id() == "pap1" then
            cosmetics = {id = "pap2", quality = 5, bonus = 0 }
            self._change_stats_of(nil, weapon_id, {damage_mul = 4})
            blueprint = current_peer_weapon:base()._blueprint
        elseif current_peer_weapon:base():get_cosmetics_id() == "nil" then
            cosmetics = {id = "pap1", quality = 5, bonus = 0 }
            self._change_stats_of(nil, weapon_id, {damage_mul = 2})
            blueprint = tweak_data.weapon.factory:_assemble_random_blueprint(factory_id, primary_category)
        end
    else
        log("[SkyLib] Error: Weapon Switch")
    end
    if force_secondary then
        managers.player:player_unit():inventory():add_unit_by_factory_name_selection_index(factory_id, 1, false, blueprint, cosmetics, false, 1)
    elseif force_primary then
        managers.player:player_unit():inventory():add_unit_by_factory_name_selection_index(factory_id, 2, false, blueprint, cosmetics, false, 2)
    elseif instigator == managers.player:player_unit() then
        managers.player:player_unit():inventory():add_unit_by_factory_name_selection_index(factory_id, current_index_equipped, false, blueprint, cosmetics, false, current_index_equipped)
    end
    if managers.player:player_unit():movement().sync_equip_weapon then
        managers.player:player_unit():movement():sync_equip_weapon()
    end
    if  managers.player:player_unit():inventory().equip_selection then
        managers.player:player_unit():inventory():equip_selection(current_index_equipped, false)
    end

end

function SkyLib.CODZ.WeaponHelper:_setup_box_weapons(custom_data)
    local tweak = tweak_data.weapon
    local data = custom_data or nil
    --[[
        All weapons added are allowed for sale by default.

        data = {
            { weapon_id = "ak74", price = 3000 },
            { weapon_id = "new_m4", price = 9000, disable_sales = true },
            { weapon_id = "usp", price = 100 },
            ...
        }
    ]]
    local function remove_from_table(tabley, ending)
        local output_table = {}

        for index, value in pairs(tabley) do
            if ( not (ending == "" or value:match(ending) == ending) ) then
                table.insert(output_table, value)
            end
        end

        return output_table
    end

    local weapon_ids = table.map_keys(tweak_data.weapon)
    local removethese = {"_npc","_crew","_secondary","module","mk2","range","idle","m203","trip_mines","_melee","stats","factory"}
    for k, v in pairs(removethese) do
        weapon_ids = SkyLib.Utils:remove_from_table_with_ending(weapon_ids, v)
    end
    weapon_ids = remove_from_table(weapon_ids, "sentry")
    weapon_ids = remove_from_table(weapon_ids, "nil")


    if data then
        for i, weapon_data in ipairs(data) do
            if tweak[weapon_data.weapon_id] then
                local weapon = tweak[weapon_data].global_value and not managers.dlc:is_dlc_unlocked(tweak[weapon_data].global_value) and tweak_data.lootdrop.global_values[tweak[weapon_data].global_value].dlc
                if not weapon then
                    table.insert(SkyLib.CODZ._weapons.mystery_box, tostring(weapon_data.weapon_id))
                end
            end
        end
    else
        if Network:is_server() then
            for i, weapon_id in pairs(weapon_ids) do
                if tweak[weapon_id] then
                        local weapon = tweak[weapon_id].global_value and not managers.dlc:is_dlc_unlocked(tweak[weapon_id].global_value) and tweak_data.lootdrop.global_values[tweak[weapon_id].global_value].dlc
                        if not weapon then
                            --log(tostring(weapon_id))
                            table.insert(SkyLib.CODZ._weapons.mystery_box, tostring(weapon_id))
                        end
                else
                    log("[ERROR-WeaponHelper._add_new_weapon] Weapon id doesn't exist!", weapon_id)
                end
            end
        end
    end
end

function SkyLib.CODZ.WeaponHelper:_change_stats_of(weapon_id, tbl_new_stats)
    -- Provide stats in a normal way, as in stability 88 WILL mean 84 in game
    -- (you remove -4 due to some obscure reason for recoil and spread)
    -- Same for rof, I do the maths for you
    -- Due to damage caps, please use damage_mul with a low damage value. (10 damage with 100 mul = 10*100 = 1000.)

    -- SkyLib.CODZ.WeaponHelper:_change_stats_of( "usp" , { rof = 600, damage = 100 } )
    -- SkyLib.CODZ.WeaponHelper:_change_stats_of( "new_m4" , { rof = 900, damage = 60, damage_mul = 3, total_clips = 4 } )
    -- SkyLib.CODZ.WeaponHelper:_change_stats_of( "ak74" , { cost = 2000, stability = 80, accuracy = 60 } )

    if not tweak_data.weapon[weapon_id] then log("[ERROR-WeaponHelper._change_stats_of] Weapon id doesn't exist!", tostring(weapon_id)) return end

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
        if stat == "cost" then tweak_data.weapon[weapon_id].CODZ_cost = value end
        if stat == "allow_sale" then tweak_data.weapon[weapon_id].allowed_for_sale = value end
        if stat == "clip_ammo" then tweak_data.weapon[weapon_id].CLIP_AMMO_MAX = value end
        if stat == "total_clips" then tweak_data.weapon[weapon_id].NR_CLIPS_MAX = value end

        if stat == "clip_ammo" or stat == "total_clips" then
            tweak_data.weapon[weapon_id].AMMO_MAX = tweak_data.weapon[weapon_id].CLIP_AMMO_MAX * tweak_data.weapon[weapon_id].NR_CLIPS_MAX
        end
    end
end

function SkyLib.CODZ.WeaponHelper:_current_equipped_weapon()
end

function SkyLib.CODZ.WeaponHelper:_weapon_has_part(weapon_id, part_id)
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