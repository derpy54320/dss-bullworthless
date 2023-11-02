-- derpy's script server: server menu - derpy54320
api = GetScriptNetworkTable()
LoadScript("dms.lua")

-- globals
local gMainMenu
local gOptions
local gRefresh

-- api
function api.create(title,help)
	return F_CreateMenu(title,help)
end
function api.submenu(title,help)
	if gMainMenu then
		return gMainMenu:submenu(title,help)
	end
	error("main menu is not running",2)
end
function api.extend(help)
	if gMainMenu then
		return gMainMenu:extend(help)
	end
	error("main menu is not running",2)
end
function api.is_active()
	return gMainMenu ~= nil
end

-- main
function main()
	local key = GetConfigString(GetScriptConfig(),"menu_key",0)
	if not IsKeyValid(key) then
		PrintError("invalid menu_key: \""..tostring(gMenuKey).."\"")
		StopCurrentScriptCollection()
		return
	end
	while not SystemIsReady() do
		Wait(0)
	end
	while true do
		if F_OpenMenu(key) then
			local thread = coroutine.create(M_MainMenu) -- run in a coroutine so we can control hiding it
			gRefresh = false
			while true do
				local status,message = coroutine.resume(thread)
				if coroutine.status(thread) == "dead" then
					if not status then
						TerminateCurrentScript()
						PrintError(message)
					end
					break
				end
				Wait(GetThreadWait())
				if F_HideMenu(key) then
					local backup = gMainMenu
					SoundPlay2D("ButtonUp")
					gMainMenu = nil
					repeat
						Wait(0)
					until F_OpenMenu(key)
					SoundPlay2D("ButtonDown")
					gMainMenu = backup
					gRefresh = true
				end
			end
		end
		Wait(0)
	end
end
function F_OpenMenu(key)
	-- if you want to make your own logic for opening the menu you can do it here
	-- just also remember to take away the key check in main if needed
	if IsUsingJoystick(0) then
		return IsKeyBeingPressed(key,1)
	end
	return IsKeyBeingPressed(key,0)
end
function F_HideMenu(key)
	-- seperate from the open function in case you need different logic for it
	-- by default it still just uses the open function though
	return F_OpenMenu(key)
end

-- main menu
function M_MainMenu()
	local menu = F_CreateMenu(GetConfigString(GetScriptConfig(),"menu_name"))
	local style = GetConfigString(GetScriptConfig(),"menu_style")
	if style and not pcall(menu.style,menu,style) then
		PrintWarning("failed to set menu style \""..style.."\"")
	end
	gMainMenu = menu
	gOptions = F_GetOptions()
	if not gOptions then
		gMainMenu = nil
		return
	end
	SoundPlay2D("ButtonDown")
	while menu:active() do
		local selected
		for _,opt in ipairs(gOptions) do
			if menu:option(opt[1],nil,opt[2]) then
				selected = opt
				break
			end
		end
		if selected then
			selected[3] = 1 -- tells the already created thread to run the coroutine
			while IsThreadRunning(selected[4]) do
				Wait(0) -- wait for that thread to finish
			end
			F_CleanOptions(gOptions)
			gOptions = F_GetOptions()
			if not gOptions then
				break
			end
			gRefresh = false
		end
		menu:draw()
		Wait(0)
		if gRefresh then
			gOptions = F_GetOptions()
			if not gOptions then
				break
			end
			gRefresh = false
		end
	end
	gMainMenu = nil
	if gOptions then
		F_CleanOptions(gOptions)
		gOptions = nil
	end
end
function F_GetOptions()
	local count,sorted,options = 0,{},{}
	if not RunLocalEvent("menu:openMain",function(name,desc,func)
		local opt = {name,desc,0} -- [3] 0 = wait, 1 = run, 2 = die
		opt[4] = CreateAdvancedThread("GAME2",T_Option,opt,coroutine.create(func)) -- creating a thread *during* the event handler will make it so it gets registered with that script
		options[name] = opt
	end) then
		return
	end
	for name in AllConfigStrings(GetScriptConfig(),"menu_order") do -- add explicitly ordered options first
		local opt = options[name]
		if opt then
			count = count + 1
			sorted[count] = opt
			options[name] = nil
		end
	end
	if next(options) then -- then add the rest alphabetically
		local n,remain = 0,{}
		for _,opt in pairs(options) do
			n = n + 1
			remain[n] = opt
		end
		table.sort(remain,F_SortOptions)
		for _,v in ipairs(remain) do
			count = count + 1
			sorted[count] = v
		end
	end
	return sorted
end
function F_SortOptions(a,b)
	return string.lower(a[1]) < string.lower(b[1])
end
function F_CleanOptions(options)
	for _,opt in ipairs(options) do
		TerminateThread(opt[4]) -- very important to terminate these threads as they belong to other scripts
	end
end

-- option thread
function T_Option(opt,c)
	while opt[3] == 0 do
		Wait(0)
	end
	while opt[3] == 1 do
		if gMainMenu then -- may be nil while the menu is hidden
			local status,message = coroutine.resume(c)
			if coroutine.status(c) == "dead" then
				if not status then
					PrintError(message)
				end
				break
			end
			Wait(GetThreadWait())
		else
			Wait(0)
		end
	end
	if gMainMenu then
		gMainMenu:draw(true) -- draw the main menu for one frame without updating options (because this GAME2 thread ran after the menu's GAME thread)
	end
end

-- thread cleanup
RegisterLocalEventHandler("ScriptShutdown",function(script)
	if script == GetCurrentScript() then
		if gOptions then
			for _,opt in ipairs(gOptions) do
				opt[3] = 2 -- tell these threads to die (since they belong to those other scripts)
			end
		end
		gMainMenu = nil -- so the main menu doesn't draw when threads die
	end
end)
