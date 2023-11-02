-- client debug menu stuff
if not GetConfigBoolean(GetScriptConfig(),"allow_debug",false) then
	TerminateCurrentScript()
	return
end
basync = GetScriptNetworkTable()

local gDebugText = {active = {},funcs = {},order = {"position","peds","send"}}
local gDebugPanel
local gDebugString

-- shared
function basync.draw_debug_string(str)
	if gDebugString and IsThreadRunning(gDebugString) then
		TerminateThread(gDebugString)
	end
	gDebugString = CreateDrawingThread(T_DebugString,str)
end

-- events
RegisterLocalEventHandler("menu:openMain",function(add)
	if net.admin and net.admin.is_admin() then
		add("Basync Debug","Admin menu for basync.",M_Debug)
	end
end)

-- core functions
function M_Debug()
	local menu = net.menu.create("Basync Debug")
	while menu:active() do
		if menu:option("Ped Viewer") then
			basync.run_ped_menu()
		elseif menu:option("Summon Ped") then
			basync.spawn_ped_menu()
		elseif menu:option("Vehicle Viewer") then
			basync.run_vehicle_menu()
		elseif menu:option("Spawn Vehicle") then
			basync.spawn_vehicle_menu()
		elseif menu:option("World Settings") then
			if basync.is_world_ready() then
				basync.run_world_menu()
			else
				menu:alert("World is not ready.",3)
			end
		elseif menu:option("Debug Panel Options") then
			M_DebugPanel()
		end
		menu:draw()
		Wait(0)
	end
end
function M_DebugPanel()
	local menu = net.menu.create("Debug Panel Options")
	while menu:active() do
		if menu:option("Show Ped Pool Usage",gDebugText.active.peds and "[ON]" or "[OFF]") then
			F_DebugPanel("peds")
		elseif menu:option("Show Send Buffer Usage",gDebugText.active.send and "[ON]" or "[OFF]") then
			if type(GetNetworkSendBuffer) == "function" then
				F_DebugPanel("send")
			else
				menu:alert("The GetNetworkSendBuffer function does not exist, you may need to turn on debug functions.",3)
			end
		elseif menu:option("Show Player Position",gDebugText.active.position and "[ON]" or "[OFF]") then
			F_DebugPanel("position")
		end
		menu:draw()
		Wait(0)
	end
end
function F_DebugPanel(what,state)
	if gDebugText.active[what] then
		gDebugText.active[what] = nil
	else
		gDebugText.active[what] = {}
	end
	if next(gDebugText.active) then
		if not gDebugPanel or not IsThreadRunning(gDebugPanel) then
			gDebugPanel = CreateDrawingThread(T_DebugPanel)
		end
	elseif gDebugPanel then
		TerminateThread(gDebugPanel)
		gDebugPanel = nil
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
		for _,k in ipairs(gDebugText.order) do
			local state = gDebugText.active[k]
			if state then
				local str = gDebugText.funcs[k](state)
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
function T_DebugString(str)
	local w,h,height
	local expire = GetTimer() + 10000
	SetTextFont("Consolas")
	SetTextHeight(0.01)
	w,h = MeasureText(str)
	height = 0.01 * (0.96 / h)
	SetTextHeight(height)
	w,h = MeasureText(str)
	DiscardText()
	repeat
		local x = 1 - 0.02 / GetDisplayAspectRatio() - w
		local y = 0.02
		DrawRectangle(x,y,w,h,0,0,0,255)
		SetTextFont("Consolas")
		SetTextColor(255,255,255,255)
		SetTextAlign("L","T")
		SetTextPosition(x,y)
		SetTextHeight(height)
		DrawText(str)
		Wait(0)
	until GetTimer() >= expire
end

-- text functions
function gDebugText.funcs.position()
	local h,x,y,z = math.deg(PedGetHeading(gPlayer)),PlayerGetPosXYZ()
	while h <= -180 do
		h = h + 360
	end
	while h > 180 do
		h = h - 360
	end
	return string.format("%.2f, %.2f, %.2f (h: %.0f, area: %d)",x,y,z,h,AreaGetVisible())
end
function gDebugText.funcs.send(state)
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
function gDebugText.funcs.peds()
	return GetPoolUsage("PED").." / "..GetPoolSize("PED").." peds"
end
