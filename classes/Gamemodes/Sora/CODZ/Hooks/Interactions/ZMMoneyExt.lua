ZMMoneyExt = ZMMoneyExt or class(UseInteractionExt)

function ZMMoneyExt:interact(player)
    ZMMoneyExt.super.super.interact(self, player)

    local peer_id = SkyLib.Network:_my_peer_id()
    local amount = self.amount

    if amount < 0 then
        if SkyLib.CODZ:_has_enough_money(amount, peer_id) then
            SkyLib.CODZ:_money_change(amount, peer_id)
            return true
        else
            return false
        end
    end

    SkyLib.CODZ:_money_change(amount, peer_id)
    return true
end