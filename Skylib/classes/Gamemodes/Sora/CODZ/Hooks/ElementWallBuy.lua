core:import("CoreMissionScriptElement")
core:import("CoreUnit")
ElementWallBuy = ElementWallBuy or class(CoreMissionScriptElement.MissionScriptElement)
local function remove_from_table_with_ending(tabley, ending)
    local output_table = {}

    for index, value in pairs(tabley) do
        if ( not (ending == "" or value:sub(-#ending) == ending) ) then
            table.insert(output_table, value)
        end
    end

    return output_table
end

ElementWallBuy.weapon_ids = table.map_keys(tweak_data.weapon)
local removethese = {"_npc","_crew","_secondary","module","mk2","range","idle","m203","trip_mines","_melee","stats","factory"}
for k, v in pairs(removethese) do
    ElementWallBuy.weapon_ids = remove_from_table_with_ending(ElementWallBuy.weapon_ids, v)
end
local element = managers.mission:get_element_by_id(self._element.id)
function ElementWallBuy:init(...)
    ElementWallBuy.super.init(self, ...)
    
    if Network:is_server() then
		local host_only = self:value("host_only")

		if host_only then
			self._unit = CoreUnit.safe_spawn_unit("units/dev_tools/mission_elements/point_interaction/interaction_dummy_nosync", self._values.position, self._values.rotation)
		else
			self._unit = CoreUnit.safe_spawn_unit("units/dev_tools/mission_elements/point_interaction/interaction_dummy", self._values.position, self._values.rotation)
		end

		if self._unit then
			self._unit:interaction():set_host_only(host_only)
			self._unit:interaction():set_active(false)
			self._unit:interaction():set_mission_element(self)
			self._unit:interaction():set_tweak_data(self._values.tweak_data_id)

			if self._values.override_timer ~= -1 then
				self._unit:interaction():set_override_timer_value(self._values.override_timer)
			end
		end
	end
end

function ElementWallBuy:client_on_executed(...)
    self:on_executed(...)
end

function ElementWallBuy:on_executed(instigator, ...)
    if not self._values.enabled then
		self._mission_script:debug_output("Element '" .. self._editor_name .. "' not enabled. Skip.", Color(1, 1, 0, 0))
		return
    end   

    -- Random factory weapon if the interaction is on a mystery box
    if self._values.weapon_id then
        self._weapon_id = self._values.weapon_id
        log(self._weapon_id)
        local factory_id = managers.weapon_factory:get_factory_id_by_weapon_id(self._weapon_id)
        local blueprint = managers.weapon_factory:get_default_blueprint_by_factory_id(factory_id)
        log("Factory ID:" .. factory_id)
	    local unit_name = tweak_data.weapon.factory[factory_id].unit
	    if not managers.dyn_resource:is_resource_ready(Idstring("unit"), unit_name, managers.dyn_resource.DYN_RESOURCES_PACKAGE) then
	    	managers.dyn_resource:load(Idstring("unit"), Idstring(unit_name), DynamicResourceManager.DYN_RESOURCES_PACKAGE, false)
        end
	    self._weapon_unit = World:spawn_unit(Idstring(unit_name), self._values.position, self._values.rotation)
        self._parts = managers.weapon_factory:assemble_from_blueprint(factory_id, self._weapon_unit, blueprint, true, true, callback(self, self, "_assemble_completed"))
    end

    ElementWallBuy.super.on_executed(self, instigator, ...)
end

function ElementWallBuy:_assemble_completed(parts, blueprint)
    self._unit:link(Idstring("root_point"), self._weapon_unit, self._weapon_unit:orientation_object():name())
end

function ElementWallBuy:on_script_activated()
    if alive(self._unit) and self._values.enabled then
        self._unit:interaction():set_active(self._values.enabled, true)
    end
end

function ElementWallBuy:set_enabled(enabled)
	ElementWallBuy.super.set_enabled(self, enabled)

	if alive(self._unit) then
		self._unit:interaction():set_active(enabled, true)
	end
end

function ElementWallBuy:stop_simulation(...)
	ElementWallBuy.super.stop_simulation(self, ...)

	if alive(self._unit) then
		World:delete_unit(self._unit)
	end
end

