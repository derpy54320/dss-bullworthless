-- server world sync
basync = GetScriptNetworkTable()

-- config
SYNC_WORLD = GetConfigBoolean(GetScriptConfig(),"sync_world",false)
PASS_OUT = GetConfigBoolean(GetScriptConfig(),"control_passout",false)

-- globals
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
	assert_support()
	return gWorld.chapter
end
function basync.get_weather()
	assert_support()
	return gWorld.weather
end
function basync.get_time()
	assert_support()
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
	assert_support()
	return gWorld.rate
end
function basync.set_chapter(chapter)
	assert_support()
	if type(chapter) ~= "number" or math.floor(chapter) ~= chapter or chapter < 0 or chapter > 6 then
		error("expected valid chapter",2)
	end
	gWorld.chapter = chapter
	update_world()
end
function basync.set_weather(weather)
	assert_support()
	if type(weather) ~= "number" or math.floor(weather) ~= weather then
		error("expected integer weather type",2)
	end
	gWorld.weather = weather
	update_world()
end
function basync.set_time(hour,minute)
	assert_support()
	if type(hour) ~= "number" or type(minute) ~= "number" or hour < 0 or minute < 0 then
		error("expected non-negative time",2)
	end
	gWorld.hour = math.mod(math.floor(hour)+math.floor(minute/60),24)
	gWorld.minute = math.mod(math.floor(minute),60)
	gStarted = GetTimer()
	update_world()
end
function basync.set_time_rate(rate)
	assert_support()
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
function assert_support()
	if not SYNC_WORLD then
		error("world sync is not enabled",3)
	end
end

-- player events
RegisterLocalEventHandler("basync:_initPlayer",function(player)
	if SYNC_WORLD then
		gPlayers[player] = true
		update_world(player)
	end
end)
RegisterLocalEventHandler("PlayerDropped",function(player)
	gPlayers[player] = nil
end)

-- main
CreateAdvancedThread("GAME2",function() -- runs post-game so changes from other scripts get sent immediately
	if not SYNC_WORLD then
		return
	end
	while true do
		if gWorld.rate ~= 0 then
			local h,m = basync.get_time()
			if PASS_OUT and update_passout(h,m) then
				h,m = basync.get_time()
			end
			for p in pairs(gPlayers) do
				SendNetworkEvent(p,"basync:_updateTime",h,m)
			end
		end
		Wait(1000)
	end
end)
function update_passout(h,m)
	if h >= 2 and h < 8 then
		for p in pairs(gPlayers) do
			SendNetworkEvent(p,"basync:_allowPassout")
		end
		gWorld.hour = 8
		gWorld.minute = 0
		gStarted = GetTimer()
		return true -- time changed
	end
	return false
end

-- commands
function run_client_command(player,callback,...)
	if net.admin and net.admin.is_player_mod(player) then
		SendNetworkEvent(player,"basync:_respondWorld",(pcall(callback,unpack(arg)))) -- true / false for status
	else
		SendNetworkEvent(player,"basync:_respondWorld") -- nil for not allowed
	end
end
RegisterNetworkEventHandler("basync:_setChapter",function(player,chapter)
	run_client_command(player,basync.set_chapter,chapter)
end)
RegisterNetworkEventHandler("basync:_setWeather",function(player,weather)
	run_client_command(player,basync.set_weather,weather)
end)
RegisterNetworkEventHandler("basync:_setTime",function(player,hour,minute)
	run_client_command(player,basync.set_time,hour,minute)
end)
RegisterNetworkEventHandler("basync:_setTimeRate",function(player,rate)
	run_client_command(player,basync.set_time_rate,rate)
end)
SetCommand("set_chapter",function(chapter)
	chapter = tonumber(chapter)
	if chapter and math.floor(chapter) == chapter and chapter >= 1 and chapter <= 7 then
		basync.set_chapter(chapter-1)
	else
		PrintError("expected valid chapter")
	end
end,false,"Usage: set_chapter <chapter>\nSet the chapter (from 1 to 7).")
SetCommand("set_weather",function(weather)
	weather = tonumber(weather)
	if weather and math.floor(weather) == weather then
		basync.set_weather(weather)
	else
		PrintError("expected valid weather")
	end
end,false,"Usage: set_weather <weather>\nSet the weather type.")
SetCommand("set_time",function(hour,minute)
	hour = tonumber(hour)
	if minute then
		minute = tonumber(minute)
	else
		minute = 0
	end
	if hour and minute and math.floor(hour) == hour and math.floor(minute) == minute and hour >= 0 and minute >= 0 then
		basync.set_time(hour,minute)
	else
		PrintError("expected valid time")
	end
end,false,"Usage: set_time <hour> <minute>\nSet the time.")
SetCommand("set_time_rate",function(rate)
	rate = tonumber(rate)
	if rate and math.floor(rate) == rate and rate >= 0 then
		basync.set_time_rate(rate)
	else
		PrintError("expected valid time rate")
	end
end,false,"Usage: set_time_rate <ms_per_minute>\nSet how many real milliseconds are in one game minute.")
