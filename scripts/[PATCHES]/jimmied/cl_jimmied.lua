RegisterLocalEventHandler("PlayerBuilding",function(is_player,is_cutscene)
	if is_player and not is_cutscene and not PedIsModel(gPlayer,0) then
		return true -- don't rebuild the player's model when not using "player" model
	end
end)
