-- SYNC: server world
s = GetScriptSharedTable()

-- globals:
gSend = false
gWorld = {
	hour = 0,
	minute = 0,
	weather = 0,
	chapter = 0,
}
gUpdate = {} -- what gWorld fields are being "updated" by the server (and cannot be changed by player)
gClientWorld = {} -- client's representation of gWorld (so only changes are sent)
gClientUpdate = {} -- update counts that need to be sent to client

-- sync utility:
function sync.setClock(hour,minute)
	if not F_CheckValue("hour",hour) or not F_CheckValue("minute",minute) then
		error("bad arguments",2)
	end
	F_Set("hour",hour)
	F_Set("minute",minute)
	F_Send()
end
function sync.setWeather(weather)
	if not F_CheckValue("weather",weather) then
		error("bad argument",2)
	end
	F_Set("weather",weather)
	F_Send()
end
function sync.setChapter(chapter)
	if not F_CheckValue("chapter",chapter) then
		error("bad argument",2)
	end
	F_Set("chapter",chapter)
	F_Send()
end

-- utility:
function F_Set(key,value)
	gWorld[key] = value
	gUpdate[key] = (gUpdate[key] or 0) + 1
	gClientUpdate[key] = (gClientUpdate[key] or 0) + 1
end

-- player changes:
RegisterLocalEventHandler("sync:initPlayer",function(player)
	if s.players[player] then
		SendNetworkEvent(player,"sync:updateWorld",gWorld)
	end
end)
RegisterLocalEventHandler("sync:setLeader",function(player)
	gUpdate = {} -- reset gUpdate because the leader changed
	gClientUpdate = {}
end)

-- messages from player:
RegisterNetworkEventHandler("sync:updateWorld",function(player,changes)
	local correct = {}
	if not s.players[player] then
		return
	elseif player ~= s.leader then
		return s.unexpected(player,"not leader")
	elseif type(changes) ~= "table" then
		return s.unexpected(player,"bad world update")
	end
	for k,v in pairs(changes) do
		if not F_CheckValue(k,v) then
			return s.unexpected(player,"bad world update: "..tostring(k))
		elseif gUpdate[k] then
			gClientWorld[k] = nil -- mark this field for updating (bc we need to correct it)
		else
			gWorld[k] = v
		end
	end
	gSend = true
end)
RegisterNetworkEventHandler("sync:updatedWorld",function(player,updates)
	if not s.players[player] then
		return
	elseif player ~= s.leader then
		return s.unexpected(player,"not leader")
	elseif type(updates) ~= "table" then
		return s.unexpected(player,"bad world update response")
	end
	for k,v in pairs(updates) do
		if not gUpdate[k] or type(v) ~= "number" then
			return s.unexpected(player,"bad world update response: "..tostring(k))
		end
		gUpdate[k] = gUpdate[k] - v
		if gUpdate[k] <= 0 then
			if gUpdate[k] < 0 then
				return s.unexpected(player,"unexpected world update response: "..tostring(k))
			end
			gUpdate[k] = nil
		end
	end
end)
function F_CheckValue(k,v)
	if type(v) == "number" and math.floor(v) == v then
		if k == "hour" then
			return v >= 0 and v < 24
		elseif k == "minute" then
			return v >= 0 and v < 60
		elseif k == "weather" then
			return true
		elseif k == "chapter" then
			return v >= 0 and v <= 6
		end
	end
	return false
end

-- main:
function main()
	while true do
		if gSend then
			F_Send()
		end
		Wait(0)
	end
end
function F_Send()
	local changes = {}
	for k,v in pairs(gWorld) do
		if gClientWorld[k] ~= v then
			gClientWorld[k] = v
			changes[k] = v
		end
	end
	if next(changes) then
		for id in pairs(s.players) do
			if id ~= s.leader then
				SendNetworkEvent(id,"sync:updateWorld",changes)
			end
		end
	end
	if s.leader ~= -1 then
		if next(gClientUpdate) then
			SendNetworkEvent(s.leader,"sync:updateWorld",changes,gClientUpdate) -- the client will tell us that it has processed this many updates so it can decrement gUpdate
			gClientUpdate = {}
		else
			SendNetworkEvent(s.leader,"sync:updateWorld",changes)
		end
	end
	gSend = false
end
