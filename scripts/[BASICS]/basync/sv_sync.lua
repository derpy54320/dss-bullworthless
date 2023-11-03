-- server sync
basync = GetScriptNetworkTable()

-- globals
gPlayers = {}
gNetIds = {}

-- player check
function basync.is_player_connected(player)
	if gPlayers[player] then
		return true
	end
	return false
end

-- network id functions
function basync.generate_net_id(object)
	local id = table.getn(gNetIds) + 1
	gNetIds[id] = object
	return id
end
function basync.ping_net_id(id) -- call after sending the net id to clients to make them respond to the new net id before they can use it
	for player,unknown in pairs(gPlayers) do
		SendNetworkEvent(player,"basync:_networkId",id)
		unknown[id] = true
	end
end
function basync.get_net_id(player,id)
	local unknown = gPlayers[player]
	if unknown and not unknown[id] then
		return gNetIds[id]
	end
end
function basync.release_net_id(id)
	for _,unknown in pairs(gPlayers) do
		unknown[id] = nil
	end
	gNetIds[id] = nil
end

-- player network events
RegisterNetworkEventHandler("basync:_initPlayer",function(player)
	gPlayers[player] = {}
	SendNetworkEvent(player,"basync:_setRate",GetServerHz())
	RunLocalEvent("basync:_initPlayer",player) -- internal use only
	RunLocalEvent("basync:initPlayer",player)
end)
RegisterNetworkEventHandler("basync:_networkId",function(player,id)
	local unknown = gPlayers[player]
	if unknown then
		unknown[id] = nil
	end
end)
RegisterNetworkEventHandler("basync:_kickMe",function(player,reason)
	if gPlayers[player] then
		if type(reason) == "string" then
			return KickPlayer(player,"your script misbehaved ("..reason..")")
		end
		return KickPlayer(player,"your script misbehaved (?)")
	end
end)
RegisterLocalEventHandler("PlayerDropped",function(player)
	if gPlayers[player] then
		gPlayers[player] = nil
	end
end)
