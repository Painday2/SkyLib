EditorWave = EditorWave or class(MissionScriptEditor)

function EditorWave:create_element()
	self.super.create_element(self)
	self._element.class = "ElementWave"
end

function EditorWave:_build_panel()
    self:_create_panel()
	self:BooleanCtrl("increase_kill", {help = "Bind this to EnemyDummyTrigger on death."})
	self:BooleanCtrl("is_special_wave", {help = "This will cause the next wave to be a Special Wave."})
end



EditorWaveOperator = EditorWaveOperator or class(MissionScriptEditor)

function EditorWaveOperator:create_element()
	EditorWaveOperator.super.create_element(self)
	self._element.class = "ElementWaveOperator"
	self._element.values.operation = "none"
	self._element.values.elements = {}
end

function EditorWaveOperator:_build_panel()
	self:_create_panel()
	self:BuildElementsManage("elements", nil, {"ElementWave"})
	self:ComboCtrl("operation", {"none","pause","stop","reset","resume"}, {help = "Select an operation for the selected elements"})
	self:Text("This element can modify the Wave elements.")
end



EditorWaveTrigger = EditorWaveTrigger or class(MissionScriptEditor)

function EditorWaveTrigger:create_element()
	EditorWaveTrigger.super.create_element(self)
    self._element.class = "ElementWaveTrigger" 
end

function EditorWaveTrigger:_build_panel()
	self:_create_panel()
	self:ComboCtrl("trigger", {"is_special_wave","first_zombie_killed","last_zombie_killed","half_killed"})
end