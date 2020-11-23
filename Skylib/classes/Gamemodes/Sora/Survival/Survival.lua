SkyLib.Survival = SkyLib.Survival or class()

function SkyLib.Survival:init(custom_rules)

    local rules = {
        starting_money = custom_rules.starting_money or 0,
        sale_chance = custom_rules.sale_chance or 8,
        sale_discounts = custom_rules.sale_discounts or {
            5,
            10,
            15,
            25,
            35,
            50,
            75,
            90
        },
        skip_first_wave_sale = custom_rules.skip_first_wave_sale or true,
        kill_reward = custom_rules.kill_reward or 100,
        disable_stock_rebalance = custom_rules.disable_stock_rebalance or false,
        gameplay = {
            first_wave_enemies = 12,
            increase_by_wave = 2
        }
    }

    self:_init_hooks()
    self:_init_rules(rules)

    self._devs = {
        76561198045788203,
        76561198070435501,
        76561197973590540,
        76561198043882024
    }

    self._helpers = {

    }

    SkyLib.Sound:init()
    SkyLib.Network:_init_survival_network()
    SkyLib.Survival.WeaponHelper:init()
    SkyLib.Survival.Profile:init()
    SkyLib.SGM:init(rules)
    log("[Survival] Gamemode fully initialized.")
end

function SkyLib.Survival:_init_rules(rules)
    self._economy = {
        sale_chance = rules.sale_chance,
        sale_discounts = rules.sale_discounts,
        skip_first_wave_sale = rules.skip_first_wave_sale,
        kill_reward = rules.kill_reward
    }

    self._weapons = {}
    self._sales = {}
end

function SkyLib.Survival:_init_hooks()
    log("[Survival] Init Hooks.")

    local mod_path = SkyLib.ModPath

    self._hooks = {
        "classes/Gamemodes/Sora/Survival/Hooks/HUDMissionBriefing",
        "classes/Gamemodes/Sora/Survival/Hooks/PlayerManager",
        --[["classes/Gamemodes/Sora/CODZ/CODZ_HUDManager",
        "classes/Gamemodes/Sora/CODZ/CODZ_HUDManagerPD2",
        "classes/Gamemodes/Sora/CODZ/CODZ_HUDMissionBriefing",
        "classes/Gamemodes/Sora/CODZ/CODZ_PlayerManager",
        "classes/Gamemodes/Sora/CODZ/CODZ_CopDamage",--]]
    }

    for _, hook in pairs(self._hooks) do
        dofile(mod_path .. hook .. ".lua")
        log("[SkyLib] Included script ", hook)
    end
end

function SkyLib.Survival:_get_weapon_price(wpn_id, wpn_tweak)
    for _, sales in pairs(self._sales) do
        if wpn_id == sales.weapon_id and sales.sale_status == true then
            local usual_price = wpn_tweak.survival_cost
            local discount = sales.sale_discount
            local deduction = usual_price * discount / 100
            local new_price = usual_price - deduction

            return math.floor(new_price)
        end
    end

    return math.floor(wpn_tweak.survival_cost)
end

function SkyLib.Survival:_perform_weapon_switch(weapon_id)
    local factory_id = managers.weapon_factory:get_factory_id_by_weapon_id(weapon_id)
    local blueprint = managers.weapon_factory:get_default_blueprint_by_factory_id(factory_id)
    local current_index_equipped = managers.player:player_unit():inventory():equipped_selection()
    local equip_index = current_index_equipped == 1 and true or false
    local idx_weapon_tweak = tweak_data.weapon[weapon_id].use_data.selection_index
    local cosmetics = {
        id = "nil",
        quality = 1,
        bonus = 0
    }

    managers.player:player_unit():inventory():add_unit_by_factory_name(factory_id, equip_index, false, blueprint, cosmetics)
        
    if managers.player:player_unit():movement().sync_equip_weapon then
        managers.player:player_unit():movement():sync_equip_weapon()
    end
    if  managers.player:player_unit():inventory().equip_selection then
        managers.player:player_unit():inventory():equip_selection(current_index_equipped, false)
    end

    self:_perform_hand_out_in(idx_weapon_tweak)
end

function SkyLib.Survival:_perform_hand_out_in(idx)
    local player = managers.player:player_unit()
    local current_index_equipped = managers.player:player_unit():inventory():equipped_selection()

    player:movement():current_state():_start_action_unequip_weapon(managers.player:player_timer():time(), {
        selection_wanted = idx
    })
end

function SkyLib.Survival:_get_current_sales()
    return self._sales
end

function SkyLib.Survival:_generate_sales(force_reset)
    if force_reset then
        for _, weapon_sale_data in pairs(self._sales) do
            weapon_sale_data.sale_status = false
            weapon_sale_data.sale_discount = 0
        end
    end

    --log("length of sale table: ", #self._sales)

    for _, weapon_sale_data in pairs(self._sales) do
        -- Assuming our weapon_sale_data is a table: Wpn ID, On Sale Status, Percent Reduction:

        local rand = math.random(0, 100)
        --log("random being: ", rand)
        local sale_chance = rand < self._economy.sale_chance

        if sale_chance then
            local sale_discount = self._economy.sale_discounts[math.random(#self._economy.sale_discounts)]

            if sale_discount > 100 then
                sale_discount = 100
            end

            weapon_sale_data.sale_status = true
            weapon_sale_data.sale_discount = sale_discount

            --log("sale! for weapon id: ", weapon_sale_data.weapon_id)
            --log("discount: ", sale_discount)
        end
    end
end