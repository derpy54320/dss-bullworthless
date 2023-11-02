-- derpy's script server: admin utilities - derpy54320
api = GetScriptNetworkTable()

-- globals
gAdmin = LoadConfigFile("admin.txt")
gBanned = {} -- temporarily banned IPs
gPlayers = {} -- these players have some admin level
gPromoted = {} -- manually promoted players
gLevels = {"admin","mod"} -- lower index is a better rank

-- api
function api.is_player_admin(player)
	local level = gPlayers[player]
	if level then
		return level == 1 -- if you change level meanings, make sure to change the client API functions too
	end
	return false
end
function api.is_player_mod(player)
	local level = gPlayers[player]
	if level then
		return level <= 2 -- admins also count as mods
	end
	return false
end
function api.update_player(player)
	if not IsPlayerValid(player) then
		error("invalid player",2)
	end
	F_RefreshPermissions(player)
end

-- local player events
RegisterLocalEventHandler("PlayerConnecting",function(player)
	if gBanned[GetPlayerIp(player)] then
		KickPlayer(player,"You are temporarily banned.")
	end
end)
RegisterLocalEventHandler("PlayerConnected",function(player)
	for p in pairs(gPlayers) do
		F_UpdatePlayers(p)
	end
end)
RegisterLocalEventHandler("PlayerDropped",function(player)
	gPlayers[player] = nil
	gPromoted[player] = nil
	for p in pairs(gPlayers) do
		F_UpdatePlayers(p)
	end
end)

-- refresh permissions
function F_RefreshPermissions(player)
	local level = gPromoted[player] or F_GetLevel(player)
	if not level then
		SendNetworkEvent(player,"admin:setPermissions",{}) -- empty list since this player is not special
	elseif level == 1 then
		SendNetworkEvent(player,"admin:setPermissions") -- no list means give them everything
		F_UpdatePlayers(player)
	elseif level == 2 then
		F_SetMod(player) -- give a specific list of commands
		F_UpdatePlayers(player)
	end
	SendNetworkEvent(player,"admin:setLevel",level or 0)
	gPlayers[player] = level
	RunLocalEvent("admin:playerUpdated",player)
end
function F_GetLevel(player)
	local player_ip = GetPlayerIp(player)
	local use_accounts = GetConfigBoolean(GetScriptConfig(),"use_account_system") and net.account
	for level,name in ipairs(gLevels) do
		for ip in AllConfigStrings(gAdmin,name.."_ip") do
			if ip == player_ip then
				return level
			end
		end
		if use_accounts then
			for role in AllConfigStrings(gAdmin,name.."_role") do
				if net.account.is_player_role(player,role) then
					return level
				end
			end
		end
	end
end
function F_SetMod(player)
	local list = {}
	for cmd in AllConfigStrings(gAdmin,"mod_cmd") do
		table.insert(list,cmd)
	end
	SendNetworkEvent(player,"admin:setPermissions",list)
end

-- player utility
function F_CanPlayer(player,cmd)
	local level = gPlayers[player]
	if level then
		if level == 1 then
			return true
		elseif level == 2 then
			for v in AllConfigStrings(gAdmin,"mod_cmd") do
				if v == cmd then
					return true
				end
			end
		end
	end
	return false
end
function F_CheckPlayer(player,cmd)
	if F_CanPlayer(player,cmd) then
		if GetConfigBoolean(GetScriptConfig(),"log_actions") then
			PrintOutput("\""..GetPlayerName(player).."\" (id: "..player..", ip: "..GetPlayerIp(player)..") is using /"..cmd..".")
		end
		return true
	end
	return false
end
function F_UpdatePlayers(player) -- tell admins / mods what players there are
	local players = {}
	for id in AllPlayers() do
		players[id] = GetPlayerName(id)
	end
	SendNetworkEvent(player,"admin:setPlayers",players)
end

-- permission events
if GetConfigBoolean(GetScriptConfig(),"use_account_system") then
	RegisterLocalEventHandler("account:playerUpdatedRoles",F_RefreshPermissions)
end
RegisterNetworkEventHandler("admin:requestPermissions",F_RefreshPermissions)

-- cleanup
RegisterLocalEventHandler("ScriptShutdown",function(script)
	if script == GetCurrentScript() then
		for p in pairs(gPlayers) do
			gPlayers[p] = nil
			RunLocalEvent("admin:playerUpdated",p)
		end
	end
end)

-- /ban
RegisterNetworkEventHandler("admin:banPlayer",function(player,target,reason)
	if F_CheckPlayer(player,"ban") and type(target) == "number" and (reason == nil or type(reason) == "string") then
		if IsPlayerValid(target) then
			local ip = GetPlayerIp(target)
			local name = GetPlayerName(target)
			gBanned[ip] = true
			if reason then
				KickPlayer(target,reason)
			else
				KickPlayer(target)
			end
			if player ~= target then
				SendNetworkEvent(player,"admin:bannedPlayer",target,name)
			end
		else
			SendNetworkEvent(player,"admin:bannedPlayer")
		end
	end
end)

-- /kick
RegisterNetworkEventHandler("admin:kickPlayer",function(player,target,reason)
	if F_CheckPlayer(player,"kick") and type(target) == "number" and (reason == nil or type(reason) == "string") then
		if IsPlayerValid(target) then
			local name = GetPlayerName(target)
			if reason then
				KickPlayer(target,reason)
			else
				KickPlayer(target)
			end
			if player ~= target then
				SendNetworkEvent(player,"admin:kickedPlayer",target,name)
			end
		else
			SendNetworkEvent(player,"admin:kickedPlayer")
		end
	end
end)

-- /players
RegisterNetworkEventHandler("admin:requestPlayers",function(player)
	if F_CheckPlayer(player,"players") then
		local n,list = 0,{}
		local use_accounts = GetConfigBoolean(GetScriptConfig(),"use_account_system") and net.account
		for id in AllPlayers() do
			local level = gPlayers[id]
			n = n + 1
			list[n] = {id,"\""..GetPlayerName(id).."\""}
			if use_accounts then
				local username = net.account.get_player_username(id)
				if username then
					list[n][2] = list[n][2].." / user: \""..username.."\""
				end
			end
			if level then
				list[n][2] = list[n][2].." / rank: "..gLevels[level]
			end
		end
		table.sort(list,function(a,b)
			return a[1] < b[1]
		end)
		for i,v in ipairs(list) do
			list[i] = "("..v[1]..") "..v[2]
		end
		if n == 1 then
			SendNetworkEvent(player,"admin:listPlayers","There is 1 player in the server.\n\t"..list[1])
		elseif n > 1 then
			SendNetworkEvent(player,"admin:listPlayers","There are "..n.." players in the server.\n\t"..table.concat(list,"\n\t"))
		end
	end
end)

-- /promote
RegisterNetworkEventHandler("admin:promotePlayer",function(player,target,rank)
	if F_CheckPlayer(player,"promote") and type(target) == "number" and type(rank) == "string" then
		if IsPlayerValid(target) then
			for i,v in ipairs(gLevels) do
				if v == rank then
					gPromoted[target] = i
					F_RefreshPermissions(target)
					SendNetworkEvent(player,"admin:promotedPlayer",true)
					return
				end
			end
			if v == "none" then
				gPromoted[target] = nil
				F_RefreshPermissions(target)
				SendNetworkEvent(player,"admin:promotedPlayer",true)
				return
			end
		end
		SendNetworkEvent(player,"admin:promotedPlayer")
	end
end)

-- /server
RegisterNetworkEventHandler("admin:runServer",function(player,cmdline)
	if F_CheckPlayer(player,"server") and type(cmdline) == "string" then
		local output = {}
		local ev = RegisterLocalEventHandler("ScriptPrinted",function(s,t)
			table.insert(output,{t,s})
		end)
		if not RunCommand(cmdline) then
			table.insert(output,{"error","command does not exist"})
		end
		RemoveEventHandler(ev)
		if output[1] then
			SendNetworkEvent(player,"admin:ranServer",output)
		else
			SendNetworkEvent(player,"admin:ranServer")
		end
	end
end)
