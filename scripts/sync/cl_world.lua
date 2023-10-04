-- SYNC: client world
s = GetScriptSharedTable()

-- globals:
gWorld = {}
gUpdate = {}

-- update server:
RegisterLocalEventHandler("sync:updateServer",function()
	if s.leader then
		local changes = F_GetWorld()
		for k,v in pairs(changes) do
			if gWorld[k] == v or gUpdate[k] then
				changes[k] = nil -- server already knows (or we're still trying to update something)
			else
				gWorld[k] = v -- predict that the server will accept it (otherwise we'll get kicked anyway)
			end
		end
		if next(changes) then
			SendNetworkEvent("sync:updateWorld",changes)
		end
	end
end)
function F_GetWorld()
	local h,m = ClockGet()
	return {
		hour = h,
		minute = m,
		weather = WeatherGet(),
		chapter = ChapterGet(),
	}
end

-- update from server:
RegisterNetworkEventHandler("sync:updateWorld",function(changes,updates)
	for k,v in pairs(changes) do
		gWorld[k] = v
	end
	if updates then
		for k in pairs(updates) do
			gUpdate[k] = true
		end
		SendNetworkEvent("sync:updatedWorld",updates)
	end
end)

-- events:
RegisterLocalEventHandler("PlayerSleepCheck",function()
	return true
end)

-- cleanup:
function MissionCleanup()
	WeatherRelease()
end

-- main:
function main()
	while not next(gWorld) or not SystemIsReady() do
		Wait(0)
	end
	while true do
		F_Sync()
		Wait(0)
	end
end
function F_Sync()
	local h,m = ClockGet()
	if (not s.leader or gUpdate.hour or gUpdate.minute) and (h ~= gWorld.hour or m ~= gWorld.minute) then
		ClockSet(gWorld.hour,gWorld.minute)
		gUpdate.hour = nil
		gUpdate.minute = nil
	end
	if (not s.leader or gUpdate.weather) and WeatherGet() ~= gWorld.weather then
		WeatherSet(gWorld.weather)
		if s.leader then
			WeatherRelease()
		end
		gUpdate.weather = nil
	end
	if (not s.leader or gUpdate.chapter) and ChapterGet() ~= gWorld.chapter and not AreaIsLoading() then
		ChapterSet(gWorld.chapter)
		gUpdate.chapter = nil
	end
end

-- debug:
function s.debugWorld(fmt,x,y,indent)
	while true do
		s.drawDebugTable(gWorld,fmt,x,y,indent)
		Wait(0)
	end
end
