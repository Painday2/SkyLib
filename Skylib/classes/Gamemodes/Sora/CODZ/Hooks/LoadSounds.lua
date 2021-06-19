--Loads sounds via breadlib for perk machines and weapons, kinda jank but it works
--this is done by loading an extra mod which just contains all of the sounds for this specific mode
if SkyLib.CODZ then
    log("[Skylib] Loading Sounds: CODZ General")
    ModCore:new("mods/SkyLib/assets_zm/ZMSounds.xml", true, true)
end