-- SYNC: server debug
s = GetScriptSharedTable()

-- invalid report:
RegisterNetworkEventHandler("sync:reportInvalid",function(player,ped)
	PrintWarning(GetPlayerName(player).." reported an invalid ped ("..tostring(ped)..")")
end)

-- warp to leader:
RegisterNetworkEventHandler("sync:requestLeaderWarp",function(player)
	if not s.players[player] then
		return
	end
	if s.leader ~= -1 then
		for _,ped in pairs(s.peds) do
			if ped.type == "player" and ped.owner == s.leader then
				SendNetworkEvent(player,"sync:approveLeaderWarp",ped.state.area,unpack(ped.state.pos))
				return
			end
		end
	end
end)
