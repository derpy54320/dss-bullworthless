-- client world sync
basync = GetScriptNetworkTable()
shared = GetScriptSharedTable(true)

-- config
SYNC_WORLD = GetConfigBoolean(GetScriptConfig(),"sync_world",false)

-- globals
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
			if not AreaIsLoading() then
				ChapterSet(chapter)
			end
			WeatherSet(weather)
			ClockSet(hour,minute)
			ClockSetTickRate(60)
		end
	end
end

-- main
CreateAdvancedThread("PRE_GAME",function() -- runs pre-game so updates are applied before other scripts run
	if SYNC_WORLD then
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
	ClockSetTickRate(1)
	while true do
		local h,m = basync.get_time()
		local hour,minute = ClockGet()
		if ChapterGet() ~= gWorld.chapter and not AreaIsLoading() then
			ChapterSet(gWorld.chapter)
		end
		if WeatherGet() ~= gWorld.weather then
			WeatherSet(gWorld.weather)
		end
		if hour ~= h or minue ~= m then
			ClockSet(h,m)
			ClockSetTickRate(1)
		end
		Wait(0)
	end
end)

-- debug cutoff
if not GetConfigBoolean(GetScriptConfig(),"debugging",false) then
	return
end

-- debug menu
function shared.run_world_menu()
	local menu = net.menu.create("Basync World")
	while menu:active() do
		if menu:option("Set Chapter","["..(gWorld.chapter+1).."]") then
			local value = get_menu_value(menu,gWorld.chapter+1,1,1,7,false)
			if value then
				SendNetworkEvent("basync:_debugChapter",value-1)
			end
		elseif menu:option("Set Weather","["..gWorld.weather.."]") then
			local value = get_menu_value(menu,gWorld.weather,1,0,5,false)
			if value then
				SendNetworkEvent("basync:_debugWeather",value)
			end
		elseif menu:option("Set Time",get_menu_time()) then
			local h,m = gWorld.hour,gWorld.minute
			local value = get_menu_value(menu,h*60+m,15,0,1425,true)
			if value then
				SendNetworkEvent("basync:_debugTime",math.floor(value/60),math.floor(math.mod(value,60)))
			end
		elseif menu:option("Set Time Rate","["..gWorld.rate.."]") then
			local value = get_menu_value(menu,gWorld.rate,100,0,10000,false)
			if value then
				SendNetworkEvent("basync:_debugTimeRate",value)
			end
		end
		menu:draw()
		Wait(0)
	end
end
function get_menu_value(menu,value,step,minimum,maximum,timestyle)
	while menu:active() do
		if timestyle then
			local m = math.floor(math.mod(value,60))
			if m < 10 then
				m = "0"..m
			end
			menu:draw("> "..math.floor(value/60)..":"..m.." <")
		else
			menu:draw("> "..value.." <")
		end
		Wait(0)
		if menu:up() then
			value = math.floor(value / step) * step + step
			if value > maximum then
				value = minimum
			end
		elseif menu:down() then
			value = math.ceil(value / step) * step - step
			if value < minimum then
				value = maximum
			end
		elseif menu:right() then
			return value
		elseif menu:left() then
			break
		end
	end
end
function get_menu_time()
	local h,m = basync.get_time()
	if m < 10 then
		m = "0"..m
	end
	return "["..h..":"..m.."]"
end
