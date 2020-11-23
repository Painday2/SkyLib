SurvivalBuyMenuInteractionExt = SurvivalBuyMenuInteractionExt or class(UseInteractionExt)

function SurvivalBuyMenuInteractionExt:interact(player)
	SurvivalBuyMenuInteractionExt.super.super.interact(self, player)
    
    managers.menu:open_menu("NepgearsyHUDMenu")

	return true
end