-- server sync
basync = GetScriptNetworkTable()
shared = GetScriptSharedTable(true)

-- config
SYNC_ENTITIES = string.lower(GetConfigString(GetScriptConfig(),"sync_entities","off"))
if SYNC_ENTITIES ~= "off" and SYNC_ENTITIES ~= "full" and SYNC_ENTITIES ~= "partial" then
	PrintError("bad config: sync_entities = \""..SYNC_ENTITIES.."\" (expected \"off\", \"full\", or \"partial\")")
	error(nil)
end

-- globals
gPlayers = {} -- players have a list of net ids they need to tell us they deleted before we can re-use the id
gNetIds = {} -- 0 is an invalid id

-- shared api
function basync.is_player_connected(player)
	if gPlayers[player] and IsPlayerValid(player) then
		return true
	end
	return false
end

-- network ids
function shared.generate_net_id(object)
	local id = 1
	while gNetIds[id] or is_id_busy(id) do
		id = id + 1
	end
	gNetIds[id] = object
	return id
end
function shared.release_net_id(id) -- the id INSTANTLY becomes unsafe to use on the server
	if gNetIds[id] then
		for player,waiting in pairs(gPlayers) do
			if IsPlayerValid(player) then -- net id can be released in a drop event so we check
				SendNetworkEvent(player,"basync:_networkId",id)
				waiting[id] = true
			end
		end
		gNetIds[id] = nil
	end
end
function shared.get_net_id(id)
	return gNetIds[id]
end
function is_id_busy(id)
	for _,waiting in pairs(gPlayers) do
		if waiting[id] then
			return true
		end
	end
	return false
end

-- player events
RegisterLocalEventHandler("PlayerDropped",function(player)
	if gPlayers[player] then
		gPlayers[player] = nil
	end
end)
RegisterNetworkEventHandler("basync:_initPlayer",function(player)
	gPlayers[player] = {}
	SendNetworkEvent(player,"basync:_setRate",GetServerHz())
	RunLocalEvent("basync:_initPlayer",player) -- internal use only
	RunLocalEvent("basync:initPlayer",player)
end)
RegisterNetworkEventHandler("basync:_networkId",function(player,id)
	local waiting = gPlayers[player]
	if waiting then
		waiting[id] = nil
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

-- cleanup
RegisterLocalEventHandler("ScriptShutdown",function(script)
	if script == GetCurrentScript() then
		gNetIds = {}
	end
end)

-- permissions
RegisterLocalEventHandler("basync:_initPlayer",function(player)
	if net.admin and net.admin.is_player_mod(player) then
		SendNetworkEvent(player,"basync:_allowCommands",player,true)
	end
end)
RegisterLocalEventHandler("admin:playerUpdated",function(player)
	if net.admin and net.admin.is_player_mod(player) then
		SendNetworkEvent(player,"basync:_allowCommands",player,true)
	else
		SendNetworkEvent(player,"basync:_allowCommands",player)
	end
end)
