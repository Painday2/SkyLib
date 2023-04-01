--Loads sounds via breadlib for perk machines and weapons, kinda jank but it works
--this is done by loading an extra mod which just contains all of the sounds for this specific mode
--again, this is disgusting but it's the best i can do until gamemode module exists
if BeardLib then
    local current_level = BeardLib.current_level or ""
    if current_level == "" and not current_level._mod then
        return
    elseif current_level._mod and current_level._mod.global then
        SkyLib:log("Loading Sounds: CODZ General")
        ModCore:new("mods/SkyLib/assets_zm/ZMSounds.xml", true, true)
    end
end