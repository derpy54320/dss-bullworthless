-- client debug menu
basync = GetScriptNetworkTable()
LoadScript("utility/models.lua")

-- state
gPanel = {active = {},funcs = {},order = {"position","vehicles","peds","send"}}

-- events
RegisterLocalEventHandler("menu:openMain",function(add)
	if net.admin and net.admin.is_mod() then
		add("Basync Debug","Debug menu for basync.",M_Debug)
	end
end)

-- core functions
function M_Debug()
	local menu = net.menu.create("Basync Debug")
	while menu:active() do
		if menu:option("Debug Peds") then
			M_Peds()
		elseif menu:option("Debug Vehicles") then
			M_Vehicles()
		elseif menu:option("Debug World") then
			M_World()
		elseif type(GetNetworkSendBuffer) == "function" and menu:option("Show Send Buffer Usage",gPanel.active.send and "[ON]" or "[OFF]","Show an approximation of the client's upload rate per second in the debug panel.") then
			F_TogglePanel("send")
		elseif menu:option("Show Ped Pool Usage",gPanel.active.peds and "[ON]" or "[OFF]","Show ped pool usage in the debug panel.") then
			F_TogglePanel("peds")
		elseif menu:option("Show Vehicle Pool Usage",gPanel.active.vehicles and "[ON]" or "[OFF]","Show vehicle pool usage in the debug panel.") then
			F_TogglePanel("vehicles")
		elseif menu:option("Show Player Position",gPanel.active.position and "[ON]" or "[OFF]","Show your position in the debug panel.") then
			F_TogglePanel("position")
		end
		menu:draw()
		Wait(0)
	end
end
function F_TogglePanel(what,state)
	if gPanel.active[what] then
		gPanel.active[what] = nil
	else
		gPanel.active[what] = {}
	end
	if next(gPanel.active) then
		if not gPanel.thread or not IsThreadRunning(gPanel.thread) then
			gPanel.thread = CreateDrawingThread(T_DebugPanel)
		end
	elseif gPanel.thread then
		TerminateThread(gPanel.thread)
		gPanel.thread = nil
	end
end
function T_DebugPanel()
	local fmt
	SetTextFont("Consolas")
	SetTextColor(255,255,255,255)
	SetTextAlign("R","B")
	SetTextHeight(0.02)
	fmt = PopTextFormatting()
	while true do
		local count,text,width,height = 0,{},0,0
		SetTextFormatting(fmt)
		for _,k in ipairs(gPanel.order) do
			local state = gPanel.active[k]
			if state then
				local str = gPanel.funcs[k](state)
				local w,h = MeasureText(str)
				width = math.max(width,w)
				height = height + h
				count = count + 1
				text[count] = str
			end
		end
		DiscardText()
		DrawRectangle(1-width,1-height,width,height,0,0,0,255)
		height = 1
		for _,str in ipairs(text) do
			SetTextFormatting(fmt)
			SetTextPosition(1,height)
			local w,h = DrawText(str)
			height = height - h
		end
		Wait(0)
	end
end

-- panel functions
function gPanel.funcs.position()
	local h,x,y,z = math.deg(PedGetHeading(gPlayer)),PlayerGetPosXYZ()
	while h <= -180 do
		h = h + 360
	end
	while h > 180 do
		h = h - 360
	end
	return string.format("%.2f, %.2f, %.2f (h: %.0f, area: %d)",x,y,z,h,AreaGetVisible())
end
function gPanel.funcs.peds()
	return string.format("%d / %d peds (%2d%%)",GetPoolUsage("PED"),GetPoolSize("PED"),math.floor((basync.get_peds_created()/32768)*100))
end
function gPanel.funcs.vehicles()
	return string.format("%d / %d vehicles (%2d%%)",GetPoolUsage("VEHICLE"),GetPoolSize("VEHICLE"),math.floor((basync.get_vehicles_created()/32768)*100))
end
function gPanel.funcs.send(state)
	if not state.started or GetTimer() - state.started >= 1000 then
		if not state.total then
			state.text = "? B/s"
		elseif state.total >= 1024 * 1024 then
			state.text = string.format("%.1f MiB/s",state.total/(1024*1024))
		elseif state.total >= 1024 then
			state.text = string.format("%.1f KiB/s",state.total/1024)
		else
			state.text = state.total.." B/s"
		end
		state.started = GetTimer()
		state.total = 0
	end
	state.total = state.total + GetNetworkSendBuffer()
	return state.text
end

-- ped browser
function M_Peds()
	local menu = net.menu.create("Basync Peds")
	while menu:active() do
		for _,ped in ipairs(F_GetPeds()) do
			if menu:option(ped:get_name(),"["..ped:get_id().."]") then
				M_ManagePed(ped)
			end
		end
		if menu:option("< create new ped >") then
			M_SpawnPed()
		end
		menu:draw()
		Wait(0)
	end
end
function M_SpawnPed()
	local menu = net.menu.create("Spawn Ped")
	local selected = 0
	while menu:active() do
		for model = 0,258 do
			local name = PED_MODELS[model]
			if name then
				if menu:option(name) then
					local h,x,y,z = PedGetHeading(gPlayer),PlayerGetPosXYZ()
					SendNetworkEvent("basync:_debugSpawnPed",model,x-math.sin(h),y+math.cos(h),z,math.deg(h),AreaGetVisible())
				end
				if menu.i == menu.n then
					selected = model
				end
			end
		end
		menu:help(selected.." / 258")
		menu:draw()
		Wait(0)
	end
end
function M_ManagePed(ped)
	local menu = net.menu.create(ped:get_name().." ["..ped:get_id().."]")
	while ped:is_valid() and menu:active() do
		local real = ped:get_ped()
		if menu:option("Teleport To Ped") then
			SendNetworkEvent("basync:_debugTeleportPed",ped:get_id(),true)
		elseif menu:option("Teleport Ped Here") then
			SendNetworkEvent("basync:_debugTeleportPed",ped:get_id())
		elseif menu:option("Browse Server Data",nil,"Browsing server data is done by getting a copy of the current server data, so it will not update while you are browsing it.") then
			local data = F_GetPedData(menu,ped)
			if data then
				M_Table("ped",data)
			else
				menu:alert("Failed to get ped data.",3)
			end
		elseif menu:option("Browse Client Data") then
			M_Table("ped",ped)
		elseif real ~= gPlayer and menu:option("Delete Local Ped","["..real.."]","Deleting a ped you own will usually delete it on the server too, but if you don't own it then it will just be reset.") and PedIsValid(real) then
			PedDelete(real)
		elseif not ped:is_player() and menu:option("Delete") then
			SendNetworkEvent("basync:_debugDeletePed",ped:get_id())
		end
		if ped:is_valid() then
			menu:help("owned: "..tostring(ped:is_owner()))
		end
		menu:draw()
		Wait(0)
	end
end
function F_GetPeds()
	local peds = {}
	for ped in basync.all_peds() do
		table.insert(peds,ped)
	end
	table.sort(peds,F_SortPeds)
	return peds
end
function F_SortPeds(a,b)
	if a:is_player() ~= b:is_player() then
		return a:is_player()
	end
	return a:get_id() < b:get_id()
end
function F_GetPedData(menu,ped)
	local result,event
	local expire = GetTimer() + 3000
	event = RegisterNetworkEventHandler("basync:_debugBrowsePed",function(data)
		RemoveEventHandler(event)
		result = data
		event = nil
	end)
	SendNetworkEvent("basync:_debugBrowsePed",ped:get_id())
	while event do
		if GetTimer() >= expire then
			RemoveEventHandler(event)
			return
		end
		menu:draw(true)
		Wait(0)
	end
	return result
end

-- vehicle browser
function M_Vehicles()
	local menu = net.menu.create("Basync Vehicles")
	while menu:active() do
		for _,veh in ipairs(F_GetVehicles()) do
			if menu:option(veh:get_name(),"["..veh:get_id().."]") then
				M_ManageVehicle(veh)
			end
		end
		if menu:option("< create new vehicle >") then
			M_SpawnVehicle()
		end
		menu:draw()
		Wait(0)
	end
end
function M_SpawnVehicle()
	local menu = net.menu.create("Spawn Vehicle")
	local selected = 0
	while menu:active() do
		for model = 272,298 do
			local name = VEHICLE_MODELS[model]
			if name then
				if menu:option(name) then
					local h,x,y,z = PedGetHeading(gPlayer),PlayerGetPosXYZ()
					SendNetworkEvent("basync:_debugSpawnVehicle",model,x-math.sin(h),y+math.cos(h),z,math.deg(h),AreaGetVisible())
				end
				if menu.i == menu.n then
					selected = model
				end
			end
		end
		menu:help(selected.." / 298")
		menu:draw()
		Wait(0)
	end
end
function M_ManageVehicle(veh)
	local menu = net.menu.create(veh:get_name().." ["..veh:get_id().."]")
	while veh:is_valid() and menu:active() do
		if menu:option("Warp Into Vehicle") then
			SendNetworkEvent("basync:_debugDriveVehicle",veh:get_id())
		elseif menu:option("Teleport To Vehicle") then
			SendNetworkEvent("basync:_debugTeleportVehicle",veh:get_id(),true)
		elseif menu:option("Teleport Vehicle Here") then
			SendNetworkEvent("basync:_debugTeleportVehicle",veh:get_id())
		elseif menu:option("Browse Server Data",nil,"Browsing server data is done by getting a copy of the current server data, so it will not update while you are browsing it.") then
			local data = F_GetVehicleData(menu,veh)
			if data then
				M_Table("veh",data)
			else
				menu:alert("Failed to get vehicle data.",3)
			end
		elseif menu:option("Browse Client Data") then
			M_Table("veh",veh)
		elseif menu:option("Delete Local Vehicle","["..veh:get_vehicle().."]","Deleting a vehicle you own will usually delete it on the server too, but if you don't own it then it will just be reset.") then
			veh:delete()
		elseif menu:option("Delete") then
			SendNetworkEvent("basync:_debugDeleteVehicle",veh:get_id())
		end
		menu:help("owned: "..tostring(veh:is_owner()))
		menu:draw()
		Wait(0)
	end
end
function F_GetVehicles()
	local vehs = {}
	for veh in basync.all_vehicles() do
		table.insert(vehs,veh)
	end
	table.sort(vehs,F_SortVehicles)
	return vehs
end
function F_SortVehicles(a,b)
	return a:get_id() < b:get_id()
end
function F_GetVehicleData(menu,veh)
	local result,event
	local expire = GetTimer() + 3000
	event = RegisterNetworkEventHandler("basync:_debugBrowseVehicle",function(data)
		RemoveEventHandler(event)
		result = data
		event = nil
	end)
	SendNetworkEvent("basync:_debugBrowseVehicle",veh:get_id())
	while event do
		if GetTimer() >= expire then
			RemoveEventHandler(event)
			return
		end
		menu:draw(true)
		Wait(0)
	end
	return result
end

-- table browser
function M_Table(name,t)
	local menu = net.menu.create(name)
	while menu:active() do
		local selected
		for _,kv in ipairs(F_GetValues(t)) do
			local right
			if type(kv[2]) == "table" then
				if next(kv[2]) then
					right = "{...}"
				else
					right = "{}"
				end
			end
			if menu:option(kv[1],right) and type(kv[2]) == "table" then
				M_Table(name.."."..kv[1],kv[2])
			end
			if menu.i == menu.n then
				selected = kv[2]
			end
		end
		if selected ~= nil then
			menu:help(F_GetString(selected))
		end
		menu:draw()
		Wait(0)
	end
end
function F_GetValues(t)
	local values = {}
	for k,v in pairs(t) do
		if type(k) == "number" then
			table.insert(values,{k,v})
		else
			table.insert(values,{tostring(k),v})
		end
	end
	table.sort(values,F_SortValues)
	return values
end
function F_SortValues(a,b)
	if type(a[1]) ~= type(b[1]) then
		return type(b[1]) == "number" -- numbers *last*
	end
	return a[1] < b[1]
end
function F_GetString(selected)
	if type(selected) == "string" then
		return "\""..selected.."\""
	elseif type(selected) ~= "table" then
		return tostring(selected)
	elseif not next(selected) then
		return "{}"
	end
	if selected[1] then
		local keys = 0
		for _,v in ipairs(selected) do
			if type(v) ~= "string" and type(v) ~= "number" then
				return "{...}"
			end
		end
		for _ in pairs(selected) do
			keys = keys + 1
		end
		if table.getn(selected) == keys then
			return "{"..table.concat(selected,", ").."}"
		end
		return "{"..table.concat(selected,", ")..", ...}"
	end
	return "{...}"
end

-- world menu
function M_World()
	local menu = net.menu.create("Basync World")
	while menu:active() do
		if menu:option("Set Chapter","["..(basync.get_chapter()+1).."]") then
			F_SetChapter(menu)
		elseif menu:option("Set Weather","["..basync.get_weather().."]") then
			F_SetWeather(menu)
		elseif menu:option("Set Time","["..F_GetTime(basync.get_time()).."]") then
			F_SetTime(menu)
		elseif menu:option("Set Time Rate","["..basync.get_time_rate().."]") then
			F_SetTimeRate(menu)
		end
		menu:draw()
		Wait(0)
	end
end
function F_GetTime(h,m)
	h = h + math.floor(m/60)
	m = math.mod(m,60)
	if m < 10 then
		m = "0"..m
	end
	return h..":"..m
end
function F_SetChapter(menu)
	local chapter = basync.get_chapter() + 1
	while menu:active() do
		menu:draw("> "..chapter.." <")
		Wait(0)
		if menu:up() then
			chapter = chapter + 1
			if chapter > 7 then
				chapter = 1
			end
		elseif menu:down() then
			chapter = chapter - 1
			if chapter < 1 then
				chapter = 7
			end
		elseif menu:left() then
			return
		elseif menu:right() then
			SendNetworkEvent("basync:_debugChapter",chapter-1)
			return
		end
	end
end
function F_SetWeather(menu)
	local weather = basync.get_weather()
	while menu:active() do
		menu:draw("> "..weather.." <")
		Wait(0)
		if menu:up() then
			weather = weather + 1
		elseif weather > 0 and menu:down() then
			weather = weather - 1
			if weather < 0 then
				weather = 0
			end
		elseif menu:left() then
			return
		elseif menu:right() then
			SendNetworkEvent("basync:_debugWeather",weather)
			return
		end
	end
end
function F_SetTime(menu)
	local h,m = basync.get_time()
	m = m + h * 60
	while menu:active() do
		menu:draw("> "..F_GetTime(0,m).." <")
		Wait(0)
		if menu:up() then
			if math.mod(m,15) ~= 0 then
				m = math.floor(m/15) * 15
			end
			m = m + 15
			if m > 1440 - 15 then
				m = 0
			end
		elseif menu:down() then
			if math.mod(m,15) ~= 0 then
				m = math.ceil(m/15) * 15
			end
			m = m - 15
			if m < 0 then
				m = 1440 - 15
			end
		elseif menu:left() then
			return
		elseif menu:right() then
			SendNetworkEvent("basync:_debugTime",m)
			return
		end
	end
end
function F_SetTimeRate(menu)
	local rate = basync.get_time_rate()
	while menu:active() do
		menu:draw("> "..rate.." <")
		Wait(0)
		if menu:up() then
			rate = rate + 100
		elseif rate > 0 and menu:down() then
			rate = rate - 100
			if rate < 0 then
				rate = 0
			end
		elseif menu:left() then
			return
		elseif menu:right() then
			SendNetworkEvent("basync:_debugTimeRate",rate)
			return
		end
	end
end
