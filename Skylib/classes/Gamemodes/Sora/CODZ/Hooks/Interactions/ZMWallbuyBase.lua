ZMWallbuyBase = ZMWallbuyBase or class(UnitBase)

function ZMWallbuyBase:init(unit)
	UnitBase.init(self, unit, false)

    self._unit = unit
    self._weapon_spawned = false
end


function ZMWallbuyBase:interacted(player)
    if self._weapon_spawned and player and player ==  self._weapon_owner then
        local factory_id = managers.weapon_factory:get_factory_id_by_weapon_id(self._weapon_id)
        local current_index_equipped = player:inventory():equipped_selection()
        local blueprint = managers.weapon_factory:get_default_blueprint_by_factory_id(factory_id)
        local cosmetics =  {
            id = "nil",
            quality = 1,
            bonus = 0
        }

        SkyLib.CODZ.WeaponHelper:_perform_weapon_switch(self._weapon_id)
        managers.player:player_unit():inventory():add_unit_by_factory_name_selection_index(factory_id, current_index_equipped, false, blueprint, cosmetics, false, current_index_equipped)

        if player:movement().sync_equip_weapon then
            player:movement():sync_equip_weapon()
        end
        if player:inventory().equip_selection then
            player:inventory():equip_selection(current_index_equipped, false)
		end
    end
    self:set_state(not self._weapon_spawned, player)
end

function ZMWallbuyBase:set_state(state, player)
    if self._weapon_unit then
        self:despawn_weapon()
    end

    if state and player then
        self._weapon_spawned = true
        self._weapon_owner = player
        self._unit:damage():run_sequence_simple("anim_open_door")

        self._weapon_id = self:_get_random_weapon()
        log(self._weapon_id)
        local factory_id = managers.weapon_factory:get_factory_id_by_weapon_id(self._weapon_id)
        local blueprint = managers.weapon_factory:get_default_blueprint_by_factory_id(factory_id)
        log("Factory ID:" .. factory_id)
	    local unit_name = tweak_data.weapon.factory[factory_id].unit
	    if not managers.dyn_resource:is_resource_ready(Idstring("unit"), unit_name, managers.dyn_resource.DYN_RESOURCES_PACKAGE) then
	    	managers.dyn_resource:load(Idstring("unit"), Idstring(unit_name), DynamicResourceManager.DYN_RESOURCES_PACKAGE, false)
        end
	    self._weapon_unit = World:spawn_unit(Idstring(unit_name), self._unit:position(), Rotation())
        self._parts = managers.weapon_factory:assemble_from_blueprint(factory_id, self._weapon_unit, blueprint, true, true, callback(self, self, "_assemble_completed"))
    else
        self._weapon_spawned = false
        self._weapon_owner = nil
        self._weapon_id = nil
        if player then
            self._unit:damage():run_sequence_simple("anim_close_door")
        end
    end
end

function ZMWallbuyBase:_assemble_completed(parts, blueprint)
    self._unit:link(Idstring("sp_weapon"), self._weapon_unit, self._weapon_unit:orientation_object():name())
end

ZMWallbuyInteractionExt = ZMWallbuyInteractionExt or class(UseInteractionExt)

function ZMWallbuyInteractionExt:interact(player)
	ZMWallbuyInteractionExt.super.interact(self, player)
	self._unit:base():interacted(player)
end