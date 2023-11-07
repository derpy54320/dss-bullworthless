-- server world sync
basync = GetScriptNetworkTable()

-- world state
gStarted = GetTimer()
gPlayers = {}
gWorld = {
	chapter = 0,
	weather = 0,
	hour = 8,
	minute = 0,
	rate = 1000, -- ms per minute (or 0 for frozen time)
}

-- shared api
function basync.get_chapter()
	return gWorld.chapter
end
function basync.get_weather()
	return gWorld.weather
end
function basync.get_time()
	if gWorld.rate ~= 0 then
		local m = math.floor(gWorld.hour * 60 + gWorld.minute + (GetTimer() - gStarted) / gWorld.rate)
		if m < 0 then
			return 0,0
		end
		return math.mod(math.floor(m/60),24),math.mod(m,60)
	end
	return gWorld.hour,gWorld.minute
end
function basync.get_time_rate()
	return gWorld.rate
end
function basync.set_chapter(chapter)
	if type(chapter) ~= "number" or math.floor(chapter) ~= chapter or chapter < 0 or chapter > 6 then
		error("expected valid chapter",2)
	end
	gWorld.chapter = chapter
	update_world()
end
function basync.set_weather(weather)
	if type(weather) ~= "number" or math.floor(weather) ~= weather then
		error("expected integer weather type",2)
	end
	gWorld.weather = weather
	update_world()
end
function basync.set_time(hour,minute)
	if type(hour) ~= "number" or type(minute) ~= "number" or hour < 0 or minute < 0 then
		error("expected non-negative time",2)
	end
	gWorld.hour = math.floor(hour)
	gWorld.minute = math.floor(minute)
	gStarted = GetTimer()
	update_world()
end
function basync.set_time_rate(rate)
	if type(rate) ~= "number" or rate < 0 then
		error("expected non-negative rate",2)
	end
	gWorld.hour,gWorld.minute = basync.get_time()
	gWorld.rate = rate
	gStarted = GetTimer()
	update_world()
end
function update_world(player)
	local world = {gWorld.chapter,gWorld.weather,gWorld.rate,basync.get_time()}
	if player then
		SendNetworkEvent(player,"basync:_updateWorld",world)
		return
	end
	for p in pairs(gPlayers) do
		if IsPlayerValid(p) then
			SendNetworkEvent(p,"basync:_updateWorld",world)
		end
	end
end

-- player events
RegisterLocalEventHandler("basync:_initPlayer",function(player)
	gPlayers[player] = true
	update_world(player)
end)
RegisterLocalEventHandler("PlayerDropped",function(player)
	gPlayers[player] = nil
end)

-- main
CreateAdvancedThread("GAME2",function() -- runs post-game so changes from other scripts get sent immediately
	while true do
		if gWorld.rate ~= 0 then
			local h,m = basync.get_time()
			for p in pairs(gPlayers) do
				SendNetworkEvent(p,"basync:_updateTime",h,m)
			end
		end
		Wait(1000)
	end
end)

-- debug cutoff
if not GetConfigBoolean(GetScriptConfig(),"allow_debug",false) then
	return
end

-- debug events
RegisterNetworkEventHandler("basync:_debugChapter",function(player,chapter)
	if net.admin and net.admin.is_player_admin(player) then
		pcall(basync.set_chapter,chapter)
	end
end)
RegisterNetworkEventHandler("basync:_debugWeather",function(player,weather)
	if net.admin and net.admin.is_player_admin(player) then
		pcall(basync.set_weather,weather)
	end
end)
RegisterNetworkEventHandler("basync:_debugTime",function(player,hour,minute)
	if net.admin and net.admin.is_player_admin(player) then
		pcall(basync.set_time,hour,minute)
	end
end)
RegisterNetworkEventHandler("basync:_debugTimeRate",function(player,rate)
	if net.admin and net.admin.is_player_admin(player) then
		pcall(basync.set_time_rate,rate)
	end
end)
