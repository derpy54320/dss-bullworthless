local STAY_TIME = 1000
local FADE_OUT = 500
local gPlayers = {}
local gSorted = {}
local gOpened

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
		if IsButtonBeingPressed(3,0) then
			if not thread then
				thread = CreateAdvancedThread("PRE_FADE","T_List")
			end
			gOpened = GetTimer()
		elseif thread and GetTimer() - gOpened >= STAY_TIME + FADE_OUT then
			TerminateThread(thread)
			thread = nil
		end
		Wait(0)
	end
end
function T_List()
	while true do
		local x,y,w,h = 1-0.09/GetDisplayAspectRatio(),0.32
		local opacity = 1 - (GetTimer() - gOpened) / FADE_OUT
		if opacity > 0 then
			for _,v in ipairs(gSorted) do
				SetTextFont("Arial")
				SetTextBlack()
				SetTextColor(255,255,255,255*opacity)
				SetTextOutline()
				SetTextAlign("R","T")
				SetTextScale(0.7)
				SetTextPosition(x,y)
				w,h = DrawText(v[2])
				y = y + h
			end
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
