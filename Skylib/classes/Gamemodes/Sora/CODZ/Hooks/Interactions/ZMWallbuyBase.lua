ZMWallbuyBase = ZMWallbuyBase or class(UnitBase)

function ZMWallbuyBase:init(unit)
	UnitBase.init(self, unit, false)

    self._unit = unit
    self._weapon_spawned = false
end


function ZMWallbuyBase:interacted(player)
    if player then        
        SkyLib.CODZ.WeaponHelper:_perform_weapon_switch(self._weapon_id, player)
        self._unit:damage():run_sequence_simple("interact")
    end
end

function ZMWallbuyBase:spawn_weapon()
    self._weapon_id = self._unit:unit_data().weapon_id or "amcar"
    local factory_id = managers.weapon_factory:get_factory_id_by_weapon_id(self._weapon_id) or managers.weapon_factory:get_factory_id_by_weapon_id("amcar")
    local blueprint = managers.weapon_factory:get_default_blueprint_by_factory_id(factory_id)
    local cosmetics =  {id = "nil", quality = 1, bonus = 0}
    local unit_name = tweak_data.weapon.factory[factory_id].unit
    log(tostring(factory_id))
    if not managers.dyn_resource:is_resource_ready(Idstring("unit"), unit_name, managers.dyn_resource.DYN_RESOURCES_PACKAGE) then
        managers.dyn_resource:load(Idstring("unit"), Idstring(unit_name), DynamicResourceManager.DYN_RESOURCES_PACKAGE, false)
    end

    self._weapon_unit = World:spawn_unit(Idstring(unit_name), self._unit:position(), Rotation())
    self._parts = managers.weapon_factory:assemble_from_blueprint(factory_id, self._weapon_unit, blueprint, true, true, callback(self, self, "_assemble_completed"))
    --if akimbo, spawn a second weapon
    --log(tostring(self._weapon_unit:base()._setup))
    --PrintTable(self._weapon_unit:base())
    if self._weapon_unit:base().AKIMBO and not self._second_unit then
		self._second_unit = World:spawn_unit(Idstring(unit_name), self._weapon_unit:position(), self._weapon_unit:rotation())
        self._second_parts = managers.weapon_factory:assemble_from_blueprint(factory_id, self._second_unit, blueprint, true, true, callback(self, self, "_assemble_completed"))
	end
    self._weapon_spawned = true
end

function ZMWallbuyBase:despawn_weapon()
	if alive(self._weapon_unit) then
		for part_id, data in pairs(self._parts) do
			if alive(data.unit) then
				World:delete_unit(data.unit)
			end
		end

		self._weapon_unit:base():set_slot(self._weapon_unit, 0)
        World:delete_unit(self._weapon_unit)
        self._weapon_unit = nil
	end
    if alive(self._second_unit) then
		for part_id, data in pairs(self._second_parts) do
			if alive(data.unit) then
				World:delete_unit(data.unit)
			end
		end

		self._second_unit:base():set_slot(self._second_unit, 0)
        World:delete_unit(self._second_unit)
        self._second_unit = nil
	end
end

function ZMWallbuyBase:_assemble_completed()
    --have to manually set position/rotation for them to update correctly
    self._unit:link(Idstring("sp_weapon"), self._weapon_unit, self._weapon_unit:orientation_object():name())
    --position weapon to not be in the wall, works for most AR/SG/SNP, LMGs will probably clip no matter what
    self._weapon_unit:set_position(self._unit:position() + self._unit:rotation():x() * 4)
    --position second weapon
    if self._second_unit then
        self._weapon_unit:set_position(self._unit:position() + self._unit:rotation():x() * 5)
        local rotation = self._weapon_unit:rotation()
        self._weapon_unit:link(self._weapon_unit:orientation_object():name(), self._second_unit)
        self._second_unit:set_position(self._weapon_unit:position() + rotation:x() * -5 + rotation:z() * 7 + rotation:y() * 1)
        self._second_unit:set_rotation(self._weapon_unit:rotation() * Rotation(0, 8, 0))
    end
end

ZMWallbuyInteractionExt = ZMWallbuyInteractionExt or class(UseInteractionExt)

function ZMWallbuyInteractionExt:interact(player)
	ZMWallbuyInteractionExt.super.interact(self, player)
	self._unit:base():interacted(player)
end