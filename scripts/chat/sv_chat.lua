-- derpy's script server: chat - derpy54320 & SWEGTA
api = GetScriptSharedTable()

-- globals
gPlayers = {} -- players signed into chat system

-- api
function api.notify(target,message,r,g,b)
	local args
	if r then
		if type(r) ~= "number" or type(g) ~= "number" or type(b) ~= "number" then
			error("bad color arguments",2)
		end
		args = {message,r,g,b}
	else
		args = {message}
	end
	if target ~= -1 then
		if not IsPlayerValid(target) then
			error("invalid player",2)
		end
		SendNetworkEvent(player,"chat:serverMessage",unpack(args))
		return
	end
	for p in pairs(gPlayers) do
		SendNetworkEvent(p,"chat:serverMessage",unpack(args))
	end
end
function api.say(target,name,message,r,g,b)
	local args
	if r then
		if type(r) ~= "number" or type(g) ~= "number" or type(b) ~= "number" then
			error("bad color arguments",2)
		end
		args = {name,message,r,g,b}
	else
		args = {name,message,255,213,3}
	end
	if target ~= -1 then
		if not IsPlayerValid(target) then
			error("invalid player",2)
		end
		SendNetworkEvent(player,"chat:playerMessage",unpack(args))
		return
	end
	for p in pairs(gPlayers) do
		SendNetworkEvent(p,"chat:playerMessage",unpack(args))
	end
end

-- command
SetCommand("say",function(message)
	if not message then
		PrintError("expected chat message")
		return
	end
	for p in pairs(gPlayers) do
		SendNetworkEvent(p,"chat:serverMessage",message)
	end
end,true)

-- player joining (normal)
function CB_PlayerConnected(player)
	gPlayers[player] = F_InitPlayerData(false,player,GetPlayerName(player))
	F_UpdatePlayerRank(player)
	F_NotifyJoined(player)
end
function CB_PlayerDropped(player)
	local data = gPlayers[player]
	if data then -- make sure the player was actually joined before showing the leave message
		gPlayers[player] = nil
		F_NotifyLeft(player,data.name)
	end
end

-- player joining (account system)
function CB_PlayerSignedIn(player,username)
	gPlayers[player] = F_InitPlayerData(false,player,username)
	F_UpdatePlayerRank(player)
	F_NotifyJoined(player)
end
function CB_PlayerSignedOut(player)
	local data = gPlayers[player]
	if data then
		gPlayers[player] = nil
		F_NotifyLeft(player,data.name)
	end
end
function CB_AccountScriptStopping()
	for p in pairs(gPlayers) do
		gPlayers[p] = nil
	end
end

-- player update (admin system)
function CB_PlayerUpdatedAdmin(player)
	local data = gPlayers[player]
	if data then
		data.moderator = F_IsPlayerModerator(player)
	end
end

-- server messages
function F_NotifyJoined(player)
	local name = gPlayers[player].name
	for p,d in pairs(gPlayers) do
		if d.moderator then
			SendNetworkEvent(p,"chat:playerJoined","["..player.."] "..name)
		else
			SendNetworkEvent(p,"chat:playerJoined",name)
		end
	end
end
function F_NotifyLeft(player,name)
	for p,d in pairs(gPlayers) do
		if d.moderator then
			SendNetworkEvent(p,"chat:playerLeft","["..player.."] "..name)
		else
			SendNetworkEvent(p,"chat:playerLeft",name)
		end
	end
end

-- player messages
RegisterNetworkEventHandler("chat:sendMessage",function(player,message)
	local data = gPlayers[player]
	if data then
		if type(message) ~= "string" or not string.find(message,"%S") or string.len(message) > GetConfigNumber(GetScriptConfig(),"max_message_length",100) then
			KickPlayer(player,"bad chat message") -- their scripts shouldn't have allowed this
		elseif F_CheckMessage(player,message) then
			F_SendMessage(player,data,message)
		end
	end
end)
function F_CheckMessage(player,message)
	local profanity = GetConfigNumber(GetScriptConfig(),"use_profanity_filter")
	if profanity then
		if not dsl.profanity then
			PrintWarning("Failed to send player message because \"profanity\" scripts are not running.")
			return false
		elseif dsl.profanity.is_dirty_str(message,profanity) then
			KickPlayer(player,"bad chat message") -- their script shouldn't have allowed this
			return false
		end
	end
	return true
end
function F_SendMessage(player,data,message)
	local msg = {
		name = data.name,
		message = message,
		moderator = data.moderator,
		color = {255,213,3},
	}
	if RunLocalEvent("chat:playerMessage",player,msg) then
		if GetConfigBoolean(GetScriptConfig(),"log_chat_messages") then
			PrintOutput(msg.name..": "..msg.message)
		end
		for p,d in pairs(gPlayers) do
			if d.moderator then
				SendNetworkEvent(p,"chat:playerMessage","["..player.."] "..msg.name,msg.message,unpack(msg.color))
			else
				SendNetworkEvent(p,"chat:playerMessage",msg.name,msg.message,unpack(msg.color))
			end
		end
	end
end

-- player utility
function F_InitPlayerData(modcheck,player,name)
	local data = {name = name,moderator = false}
	if modcheck then
		data.moderator = F_IsPlayerModerator(player)
	end
	return data
end
function F_UpdatePlayerRank(player)
	if GetConfigBoolean(GetScriptConfig(),"use_admin_system") and dsl.admin then
		dsl.admin.update_player(player) -- needed during PlayerConnected and PlayerSignedIn events since they're when admin updates too (and admin might be late)
	end
end
function F_IsPlayerModerator(player)
	if GetConfigBoolean(GetScriptConfig(),"use_admin_system") and dsl.admin then
		return dsl.admin.is_player_mod(player)
	end
	return false
end

-- main
function main()
	if GetConfigBoolean(GetScriptConfig(),"use_admin_system") then
		RegisterLocalEventHandler("admin:playerUpdated",CB_PlayerUpdatedAdmin)
	end
	if not GetConfigBoolean(GetScriptConfig(),"use_account_system") then
		for player in AllPlayers() do
			gPlayers[player] = F_InitPlayerData(true,player,GetPlayerName(player))
		end
		RegisterLocalEventHandler("PlayerConnected",CB_PlayerConnected)
		RegisterLocalEventHandler("PlayerDropped",CB_PlayerDropped)
	elseif dsl.account then
		for player,username in dsl.account.all_players() do
			gPlayers[player] = F_InitPlayerData(true,player,username)
		end
		RegisterLocalEventHandler("account:playerSignedIn",CB_PlayerSignedIn)
		RegisterLocalEventHandler("account:playerSignedOut",CB_PlayerSignedOut)
		RegisterLocalEventHandler("account:scriptStopping",CB_AccountScriptStopping)
	else
		PrintError("Chat is configured to use \"account\" scripts, but they are not running.",0)
		StopCurrentScriptCollection()
	end
end
