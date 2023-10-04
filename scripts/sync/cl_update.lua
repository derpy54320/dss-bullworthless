-- SYNC: client players
s = GetScriptSharedTable()

-- globals:
gUpdateRate = -1

-- events:
RegisterNetworkEventHandler("sync:setRefresh",function(hz)
	gUpdateRate = hz
end)

-- main:
CreateAdvancedThread("GAME2",function()
	local update = GetTimer()
	while gUpdateRate == -1 or not SystemIsReady() do
		Wait(0)
	end
	while true do
		if GetTimer() >= update then
			update = update + (1000 / gUpdateRate)
			if GetTimer() >= update then
				update = GetTimer()
			end
			RunLocalEvent("sync:updateServer") -- this script runs after the main client scripts so this event will run after those scripts
		end
		Wait(0)
	end
end)
