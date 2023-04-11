SkyLib:set_mod_key(ZM_BANK) -- The Global Key you specified in the main.xml is now a Global variable, do not use quotes!
-- Final Init
SkyLib:init_by_gamemode("codzm")
SkyLib.CODZ.WeaponHelper:_setup_box_weapons()
--SkyLib.CODZ:LoadSounds()