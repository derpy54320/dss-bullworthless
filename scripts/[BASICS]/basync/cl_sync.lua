-- client sync

local hz

CreateAdvancedThread("GAME2",function() -- runs post-game so changes from other scripts get sent immediately
	local started
	local updates = 0
	if GetConfigBoolean(GetScriptConfig(),"allow_debug") then
		StartScript("cl_debug.lua")
	end
	SendNetworkEvent("basync:_initPlayer")
	while not SystemIsReady() do
		Wait(0)
	end
	while not hz do
		Wait(0)
	end
	started = GetTimer()
	while true do
		local target = math.floor(((GetTimer() - started) / 1000) * hz)
		if target > updates then
			if target - updates > 1 then
				--PrintWarning("missed "..(target - updates - 1).." tick(s)")
			end
			RunLocalEvent("basync:_updateServer")
			--DrawRectangle(0,0,1,0.01,255,0,0,255)
			updates = target
		end
		Wait(0)
	end
end)
RegisterNetworkEventHandler("basync:_setRate",function(v)
	if v <= 0 then
		error("invalid refresh rate: "..tostring(v))
	end
	hz = v
end)
RegisterNetworkEventHandler("basync:_networkId",function(id)
	SendNetworkEvent("basync:_networkId",id)
end)
