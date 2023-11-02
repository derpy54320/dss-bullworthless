-- derpy's script server: admin utilities - derpy54320
api = GetScriptNetworkTable()

-- globals
gCommands = {}
gPlayers = {}
gLevel = 0 -- zero = nothing, otherwise it corresponds to the server level

-- api
function api.is_admin()
	return gLevel == 1
end
function api.is_mod()
	return gLevel ~= 0 and gLevel <= 2
end

-- main
function main()
	SendNetworkEvent("admin:requestPermissions")
end
function F_Register(cmd,help,raw,func)
	gCommands[cmd] = {func,raw,help}
end
RegisterNetworkEventHandler("admin:setPermissions",function(list)
	for cmd in pairs(gCommands) do
		ClearCommand(cmd)
	end
	if list then
		for _,cmd in ipairs(list) do
			SetCommand(cmd,unpack(gCommands[cmd]))
		end
	else
		for cmd,data in pairs(gCommands) do
			SetCommand(cmd,unpack(data))
		end
	end
end)
RegisterNetworkEventHandler("admin:setPlayers",function(players)
	gPlayers = players
end)
RegisterNetworkEventHandler("admin:setLevel",function(level)
	gLevel = level
end)

-- utility
function F_AppendReason(reason,arg)
	for _,v in ipairs(arg) do
		reason = reason.." "..v
	end
	return reason
end
function F_GetPlayerId(id,warn)
	id = tonumber(id)
	if gPlayers[id] then
		return id
	elseif warn then
		if DoesCommandExist("players") then
			PrintError("Invalid player ID given. Try using /players to list all players.")
		else
			PrintError("Invalid player ID given.")
		end
	end
end

-- /ban
F_Register("ban","Usage: ban <id> [reason]\nTemporarily ban a player (by IP) given a player ID.",false,function(player,reason,...)
	local id = F_GetPlayerId(player,true)
	if id then
		if reason then
			SendNetworkEvent("admin:banPlayer",id,F_AppendReason(reason,arg))
		else
			SendNetworkEvent("admin:banPlayer",id)
		end
	end
end)
RegisterNetworkEventHandler("admin:bannedPlayer",function(player,name)
	if player then
		PrintOutput("Kicked and temporarily banned "..name.." ("..player..").")
	else
		PrintError("Failed to ban player.")
	end
end)

-- /kick
F_Register("kick","Usage: kick <id> [reason]\nKick a player given a player ID.",false,function(player,reason,...)
	local id = F_GetPlayerId(player,true)
	if id then
		if reason then
			SendNetworkEvent("admin:kickPlayer",id,F_AppendReason(reason,arg))
		else
			SendNetworkEvent("admin:kickPlayer",id)
		end
	end
end)
RegisterNetworkEventHandler("admin:kickedPlayer",function(player,name)
	if player then
		PrintOutput("Kicked "..name.." ("..player..").")
	else
		PrintError("Failed to kick player.")
	end
end)

-- /players
F_Register("players","Usage: players\nList all players in the server.",true,function()
	SendNetworkEvent("admin:requestPlayers")
end)
RegisterNetworkEventHandler("admin:listPlayers",function(output)
	PrintOutput(output)
end)

-- /promote
F_Register("promote","Usage: promote <id> <rank>\nTemporarily promote a player to a certain rank.",false,function(player,rank)
	local id = F_GetPlayerId(player,true)
	if id then
		if rank then
			SendNetworkEvent("admin:promotePlayer",id,string.lower(rank))
		else
			PrintError("Rank expected.")
		end
	end
end)
RegisterNetworkEventHandler("admin:promotedPlayer",function(success)
	if success then
		PrintOutput("Promoted player.")
	else
		PrintError("Failed to promote player.")
	end
end)

-- /server
F_Register("server","Usage: server\nRun a server command.",true,function(cmdline)
	if cmdline then
		SendNetworkEvent("admin:runServer",cmdline)
	else
		PrintError("expected command")
	end
end)
RegisterNetworkEventHandler("admin:ranServer",function(output)
	if output then
		local func = {output = PrintOutput,error = PrintError,warning = PrintWarning,special = PrintSpecial}
		for _,v in ipairs(output) do
			(func[v[1]] or print)(v[2])
		end
	else
		PrintOutput("ran command successfully")
	end
end)
