function HUDManager:start_assault(assault_number)
	self._hud.in_assault = true
	managers.network:session():send_to_peers_synched("sync_start_assault", math.min(assault_number, HUDManager.ASSAULTS_MAX))
end