if not ModCore then
	log("[SkyLib] ERROR : ModCore from BeardLib is not present! Is BeardLib installed?")
	return
end

ModCore:new(ModPath .. "base.xml", true, true)