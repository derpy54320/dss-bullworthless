-- SYNC: debug
s = GetScriptSharedTable()

-- globals:
gShowing = false
gDebugStats = {
	s.getPedDebug,
	function()
		return gcinfo().." KB"
	end,
	function()
		if type(GetNetworkSendBuffer) == "function" then
			local bytes = GetNetworkSendBuffer()
			if bytes >= 2048 then
				return string.format("%.1f KB",bytes/1024)
			end
			return bytes.." B"
		end
	end,
}
gDebugPanels = {
	{"PEDS",s.debugPeds},
	{"WORLD",s.debugWorld},
}

-- cleanup:
function MissionCleanup()
	AreaDisableCameraControlForTransition(false) -- in case leader warping
end

-- main:
function main()
	local pools
	while not SystemIsReady() do
		Wait(0)
	end
	CreateThread("T_Peds")
	CreateDrawingThread("T_Controls")
	CreateDrawingThread("T_Stats")
	CreateDrawingThread("T_Panels","F2")
	while true do
		if IsKeyBeingPressed("F3") then
			if pools and IsThreadRunning(pools) then
				TerminateThread(pools)
				pools = nil
			else
				pools = CreateDrawingThread(T_Pools)
			end
		elseif IsKeyBeingPressed("F4") then
			SendNetworkEvent("sync:requestLeaderWarp")
		elseif IsKeyBeingPressed("F5") then
			gShowing = not gShowing
		end
		Wait(0)
	end
end

-- ped validity:
function T_Peds()
	local reported = {}
	while true do
		for ped in pairs(reported) do
			reported[ped] = false -- false so it will be removed after the ped loop if no longer invalid
		end
		for ped in AllPeds() do
			if not PedIsValid(ped) then
				if reported[ped] == nil then
					SendNetworkEvent("sync:reportInvalid",ped)
				end
				reported[ped] = true
			end
		end
		for ped,invalid in pairs(reported) do
			if not invalid then
				reported[ped] = nil
			end
		end
		Wait(0)
	end
end

-- debug controls:
function T_Controls()
	local w,h
	local controls = {}
	for _,str in ipairs({"[F2] sync debug","[F3] pool debug","[F4] warp to leader","[F5] toggle debug ui"}) do
		table.insert(controls,1,str)
	end
	while true do
		if gShowing then
			local y = 0.998
			for _,str in ipairs(controls) do
				SetTextFormatting(2)
				SetTextAlign("L","B")
				SetTextPosition(0.002/GetDisplayAspectRatio(),y)
				SetTextScale(0.5)
				w,h = DrawText(str)
				y = y - h
			end
		end
		Wait(0)
	end
end

-- debug stats:
function T_Stats()
	local w,h
	while true do
		if gShowing then
			local y = 0.998
			for _,f in ipairs(gDebugStats) do
				local str = f()
				if str then
					SetTextFormatting(2)
					SetTextAlign("R","B")
					SetTextPosition(1-0.002/GetDisplayAspectRatio(),y)
					SetTextScale(0.5)
					w,h = DrawText(str)
					y = y - h
				end
			end
		end
		Wait(0)
	end
end

-- debug panels:
function T_Panels(key)
	local thread
	local text
	local index = 0
	local indent = 0.02 / GetDisplayAspectRatio()
	local fmt = F_SetupText()
	while true do
		local x,y,w,h = 0,0
		if not gShowing then
			if thread then
				TerminateThread(thread)
			end
			index = 0
		elseif IsKeyBeingPressed(key) then
			index = index + 1
			if thread then
				TerminateThread(thread)
			end
			if gDebugPanels[index] then
				SetTextFormatting(fmt)
				SetTextPosition(x,y)
				text = "["..key.."] SYNC DEBUG: "..gDebugPanels[index][1]
				w,h = DrawText(text)
				thread = CreateDrawingThread(gDebugPanels[index][2],fmt,x+indent,y+h,indent)
			else
				index = 0
				thread = nil
			end
		elseif index ~= 0 then
			SetTextFormatting(fmt)
			SetTextPosition(x,y)
			w,h = DrawText(text)
		end
		Wait(0)
	end
end
function F_SetupText()
	SetTextFont("Arial")
	SetTextBlack()
	SetTextOutline()
	SetTextAlign("L")
	SetTextScale(0.4)
	SetTextColor(255,255,255,255)
	return PopTextFormatting()
end

-- debug pools:
function T_Pools()
	local alpha = 150
	local txtfmt
	SetTextFont("Georgia")
	SetTextAlign("L","T")
	SetTextColor(255,255,255,alpha)
	SetTextScale(0.7)
	SetTextBold()
	txtfmt = PopTextFormatting()
	while true do
		local width,height = 0,0
		local pools = GetAllPoolInfo()
		local padx,pady = 0.01/GetDisplayAspectRatio(),0.01
		for stage,func in ipairs({MeasureText,DrawText}) do
			local w1,h1,w2,h2
			local x,y = 0.02/GetDisplayAspectRatio()+padx/2,0.3+pady/2
			if stage == 2 then
				--x = 1 - x - width
				DrawRectangle(x-padx/2,y-pady/2,width+padx,height+pady,0,0,0,alpha)
			end
			for _,pool in ipairs(pools) do
				SetTextFormatting(txtfmt)
				SetTextPosition(x,y)
				w1,h1 = func(pool.name)
				SetTextFormatting(txtfmt)
				SetTextAlign("R","T")
				SetTextPosition(x+width,y)
				if pool.count >= pool.limit then
					SetTextColor(255,0,0,alpha)
				elseif pool.limit - pool.count <= 2 then
					SetTextColor(255,192,0,alpha)
				end
				w2,h2 = func(pool.count.." / "..pool.limit)
				width = math.max(width,w1+w2+0.02/GetDisplayAspectRatio())
				height = height + math.max(h1,h2)
				y = y + math.max(h1,h2)
			end
		end
		Wait(0)
	end
end

-- shared utility:
function s.drawDebugTable(t,fmt,x,y,indent)
	local sorted = {}
	local height,w,h = 0
	for k,v in pairs(t) do
		table.insert(sorted,{k,v})
	end
	table.sort(sorted,function(a,b)
		return a[1] < b[1]
	end)
	for _,value in ipairs(sorted) do
		local k,v = unpack(value)
		SetTextFormatting(fmt)
		SetTextPosition(x,y+height)
		if type(v) ~= "table" then
			w,h = DrawText(k..": "..F_DebugValue(v))
		elseif v[1] or not next(v) then
			local str
			for k,v in pairs(v) do
				if str then
					str = str..", "..F_DebugValue(v)
				else
					str = F_DebugValue(v)
				end
			end
			if str then
				w,h = DrawText(k..": {"..str.."}")
			else
				w,h = DrawText(k..": {}")
			end
		else
			w,h = DrawText(k..": {")
			height = height + h
			height = height + s.drawDebugTable(v,fmt,x+indent,y+height,indent)
			SetTextFormatting(fmt)
			SetTextPosition(x,y+height)
			w,h = DrawText("}")
		end
		height = height + h
	end
	return height
end
function F_DebugValue(v)
	if type(v) == "string" then
		return "\""..v.."\""
	end
	return tostring(v)
end

-- network events:
RegisterNetworkEventHandler("sync:approveLeaderWarp",function(area,x,y,z,h)
	CreateThread(function()
		while AreaIsLoading() do
			Wait(0)
		end
		AreaDisableCameraControlForTransition(true)
		PlayerSetPosXYZArea(x,y,z,area)
		while AreaIsLoading() do
			Wait(0)
		end
		AreaDisableCameraControlForTransition(false)
		PedFaceHeading(gPlayer,h,0)
	end)
end)
