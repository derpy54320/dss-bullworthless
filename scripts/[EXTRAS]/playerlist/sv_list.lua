gPlayers = {}

RegisterLocalEventHandler("PlayerDropped",function(player)
	gPlayers[player] = nil
	for other in pairs(gPlayers) do
		SendNetworkEvent(other,"playerlist:set",player) -- no name sent, so it clears this player id for clients
	end
end)
RegisterNetworkEventHandler("playerlist:get",function(player)
	gPlayers[player] = GetPlayerName(player)
	for other,name in pairs(gPlayers) do
		if other ~= player then
			SendNetworkEvent(other,"playerlist:set",player,gPlayers[player])
		end
		SendNetworkEvent(player,"playerlist:set",other,name)
	end
end)
