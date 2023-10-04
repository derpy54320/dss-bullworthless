-- SYNC: server players
s = GetScriptSharedTable()

-- shared:
s.players = {}
s.leader = -1

-- events:
RegisterNetworkEventHandler("sync:connectPlayer",function(player,h,x,y,z)
	if s.players[player] then
		PrintWarning(GetPlayerName(player).." double connected")
		F_CleanPlayer(player)
	end
	for id in pairs(s.players) do
		SendNetworkEvent(player,"sync:addPlayer",id,GetPlayerName(id))
		SendNetworkEvent(id,"sync:addPlayer",player,GetPlayerName(player))
	end
	SendNetworkEvent(player,"sync:addPlayer",player)
	s.players[player] = {}
	if s.leader ~= -1 or not F_SetLeader(player) then
		SendNetworkEvent(player,"sync:setLeader",s.leader)
	end
	RunLocalEvent("sync:initPlayer",player,x,y,z,h)
	SendNetworkEvent(player,"sync:setRefresh",GetServerHz())
end)
RegisterLocalEventHandler("PlayerDropped",function(player)
	if s.players[player] then
		F_CleanPlayer(player)
		RunLocalEvent("sync:playerDropped",player)
	end
end)

-- shared utility:
function s.unexpected(player,reason)
	if reason ~= nil then
		KickPlayer(player,"A sync error occurred ("..tostring(reason)..").")
	else
		KickPlayer(player,"A sync error occurred.")
	end
end

-- utility:
function F_CleanPlayer(player)
	s.players[player] = nil
	for id in pairs(s.players) do
		SendNetworkEvent(id,"sync:removePlayer",player)
	end
	if s.leader == player then
		local id = next(s.players)
		if not id or not F_SetLeader(id) then
			s.leader = -1
		end
	end
end
function F_SetLeader(player)
	local name = GetConfigString(GetScriptConfig(),"dbg_leader")
	if name and GetPlayerName(player) ~= name then
		return false
	end
	s.leader = player
	RunLocalEvent("sync:setLeader",player)
	for id in pairs(s.players) do
		SendNetworkEvent(id,"sync:setLeader",player)
	end
	return true
end
