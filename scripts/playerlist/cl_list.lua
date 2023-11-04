gPlayers = {}
gSorted = {}

RegisterNetworkEventHandler("playerlist:set",function(id,name)
	gPlayers[id] = name
	F_Resort()
end)
function main()
	local thread
	SendNetworkEvent("playerlist:get")
	while not SystemIsReady() do
		Wait(0)
	end
	while true do
		if IsKeyBeingPressed("Z",0) then
			if thread and IsThreadRunning(thread) then
				TerminateThread(thread)
				thread = nil
			else
				thread = CreateAdvancedThread("PRE_FADE","T_List")
			end
		end
		Wait(0)
	end
end
function T_List()
	while true do
		local x,y,w,h = 1-0.05/GetDisplayAspectRatio(),0.29
		for _,v in ipairs(gSorted) do
			SetTextFont("Arial")
			SetTextBlack()
			SetTextColor(255,255,255,255)
			SetTextOutline()
			SetTextAlign("R","T")
			SetTextScale(0.7)
			SetTextPosition(x,y)
			w,h = DrawText(v[2])
			y = y + h
		end
		Wait(0)
	end
end
function F_Resort()
	local count = 0
	gSorted = {}
	for id,name in pairs(gPlayers) do
		count = count + 1
		gSorted[count] = {id,name}
	end
	table.sort(gSorted,function(a,b)
		local as,bs = string.lower(a[2]),string.lower(b[2])
		if as ~= bs then
			return as < bs
		end
		return a[1] < b[1]
	end)
end
