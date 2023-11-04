gPlayers = {}
gSorted = {}

RegisterNetworkEventHandler("playerlist:set",function(id,name)
	gPlayers[id] = name
	F_Resort()
end)
CreateAdvancedThread("PRE_FADE",function()
	SendNetworkEvent("playerlist:get")
	while true do
		local x,y,w,h = 1-0.04/GetDisplayAspectRatio(),0.285
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
end)
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
