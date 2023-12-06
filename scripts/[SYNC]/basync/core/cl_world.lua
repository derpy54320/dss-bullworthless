-- client world sync
basync = GetScriptNetworkTable()

-- config
SYNC_WORLD = GetConfigBoolean(GetScriptConfig(),"sync_world",false)
PASS_OUT = GetConfigBoolean(GetScriptConfig(),"control_passout",false)

-- globals
gCommands = {}
gPassout = false
gStarted = 0
gWorld = {}

-- shared api
function basync.is_world_ready()
	return next(gWorld) ~= nil
end
function basync.get_chapter()
	if next(gWorld) then
		return gWorld.chapter
	end
	return 0
end
function basync.get_weather()
	if next(gWorld) then
		return gWorld.weather
	end
	return 0
end
function basync.get_time()
	if next(gWorld) then
		if gWorld.rate ~= 0 then
			local m = math.floor(gWorld.hour * 60 + gWorld.minute + (GetTimer() - gStarted) / gWorld.rate)
			if m < 0 then
				return 0,0
			end
			return math.mod(math.floor(m/60),24),math.mod(m,60)
		end
		return gWorld.hour,gWorld.minute
	end
	return 0,0
end
function basync.get_time_rate()
	if next(gWorld) then
		return gWorld.rate
	end
	return 0
end

-- network events
RegisterNetworkEventHandler("basync:_allowPassout",function()
	if PASS_OUT then
		gPassout = true
	end
end)
RegisterNetworkEventHandler("basync:_updateWorld",function(world)
	if SYNC_WORLD then
		for i,k in pairs({"chapter","weather","rate","hour","minute"}) do
			gWorld[k] = world[i]
		end
		gStarted = GetTimer()
	end
end)
RegisterNetworkEventHandler("basync:_updateTime",function(hour,minute)
	if next(gWorld) then
		gWorld.hour = hour
		gWorld.minute = minute
		gStarted = GetTimer()
	end
end)

-- setup / cleanup
function MissionSetup()
	if SYNC_WORLD then
		local chapter = ChapterGet()
		local weather = WeatherGet()
		local hour,minute = ClockGet()
		while not SystemIsReady() do
			Wait(0)
		end
		function MissionCleanup()
			ChapterSet(chapter)
			WeatherSet(weather)
			ClockSet(hour,minute)
			ClockSetTickRate(60)
		end
	end
end

-- main
CreateAdvancedThread("PRE_GAME",function() -- runs pre-game so updates are applied before other scripts run
	if not SYNC_WORLD then
		return
	end
	while AreaIsLoading() do
		Wait(0)
	end
	while not next(gWorld) do
		Wait(0)
	end
	ChapterSet(gWorld.chapter)
	WeatherSet(gWorld.weather)
	while true do
		local h,m = basync.get_time()
		local hour,minute = ClockGet()
		if ChapterGet() ~= gWorld.chapter and not AreaIsLoading() then
			ChapterSet(gWorld.chapter)
		end
		if WeatherGet() ~= gWorld.weather then
			WeatherSet(gWorld.weather)
		end
		if gPassout then
			if hour < 2 then
				ClockSet(2,0)
			elseif hour >= 8 then
				ClockSet(7,59)
			end
			ClockSetTickRate(60)
			PlayerChangePhysicalState(2)
			Wait(3000) -- some time to let the node start
			while PedIsPlaying(gPlayer,"/G/PLAYER/DEFAULT_KEY/LOCOMOTION",true) and PedMePlaying(gPlayer,"EXHAUSTED_COLLAPSE",true) do
				Wait(0)
			end
			gPassout = false
		elseif PASS_OUT and h >= 2 and h < 8 then
			ClockSet(1,59)
		elseif hour ~= h or minue ~= m then
			ClockSet(h,m)
		end
		if PASS_OUT and (h < 1 or h >= 8) and PlayerGetPhysicalState() ~= 0 then
			PlayerChangePhysicalState(0)
		end
		ClockSetTickRate(1)
		Wait(0)
	end
end)

-- commands
RegisterNetworkEventHandler("basync:_allowCommands",function(allow)
	if allow then
		if not registered then
			for k,v in pairs(gCommands) do
				SetCommand(k,v[2],false,v[1])
			end
			registered = true
		end
	elseif registered then
		for k in pairs(gCommands) do
			ClearCommand(k)
		end
		registered = false
	end
end)
gCommands.set_chapter = {"Usage: set_chapter <chapter>\nSet the chapter (from 1 to 7).",function(chapter)
	chapter = tonumber(chapter)
	if chapter and math.floor(chapter) == chapter and chapter >= 1 and chapter <= 7 then
		SendNetworkEvent("basync:_setChapter",chapter)
	else
		PrintError("expected valid chapter")
	end
end}
gCommands.set_weather = {"Usage: set_weather <weather>\nSet the weather type.",function(weather)
	weather = tonumber(weather)
	if weather and math.floor(weather) == weather then
		SendNetworkEvent("basync:_setWeather",weather)
	else
		PrintError("expected valid weather")
	end
end}
gCommands.set_time = {"Usage: set_time <hour> <minute>\nSet the time.",function(hour,minute)
	hour = tonumber(hour)
	if minute then
		minute = tonumber(minute)
	else
		minute = 0
	end
	if hour and minute and math.floor(hour) == hour and math.floor(minute) == minute and hour >= 0 and minute >= 0 then
		SendNetworkEvent("basync:_setTime",hour,minute)
	else
		PrintError("expected valid time")
	end
end}
gCommands.set_time_rate = {"Usage: set_time_rate <ms_per_minute>\nSet how many real milliseconds are in one game minute.",function(rate)
	rate = tonumber(rate)
	if rate and math.floor(rate) == rate and rate >= 0 then
		SendNetworkEvent("basync:_setTimeRate",rate)
	else
		PrintError("expected valid time rate")
	end
end}
