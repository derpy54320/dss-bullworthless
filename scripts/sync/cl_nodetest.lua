RegisterLocalizedText("NODE_TEST",100)
ReplaceLocalizedText("NODE_TEST","Press ~ddown~ to skip a node!")

s = GetScriptSharedTable()

local thread

-- /set_node
SetCommand("set_node",function()
	F_ToggleThread("T_SetNode","/G",s.all_action_nodes)
end)
function T_SetNode(node,nodes)
	local menu = F_CreateMenu(node)
	local order = {n = 0}
	for k,v in pairs(nodes) do
		table.insert(order,{k,v})
	end
	table.sort(order,function(a,b)
		return a[1] < b[1]
	end)
	while menu:active() do
		if menu:option("< play >") then
			PedSetActionNode(gPlayer,node,"")
		end
		for _,v in ipairs(order) do
			if menu:option(v[1]) then
				T_SetNode(node.."/"..v[1],v[2])
			end
		end
		menu:draw()
		Wait(0)
	end
end

-- /test_nodes
SetCommand("test_nodes",function()
	F_ToggleThread("T_TestNodes","/G",s.action_nodes)
end)
function T_TestNodes(path,global)
	local trees = {}
	local menu = F_CreateMenu("Test Nodes")
	for tree,nodes in pairs(global) do
		table.insert(trees,{tree,nodes})
	end
	table.sort(trees,function(a,b)
		return a[1] < b[1]
	end)
	while menu:active() do
		if menu:option("< test >") then
			TutorialShowMessage("NODE_TEST",3000)
			F_TestNodes(path,global)
		end
		for _,v in ipairs(trees) do
			if menu:option(v[1]) then
				T_TestNodes(path.."/"..v[1],v[2])
			end
		end
		menu:draw()
		Wait(0)
	end
end
function F_TestNodes(node,nodes)
	for k,v in pairs(nodes) do
		F_TestNodes(node.."/"..k,v)
	end
	if not PedSetActionNode(gPlayer,node,"") then
		PrintWarning(node.." is not loaded")
		return
	end
	while PedIsPlaying(gPlayer,node,true) do
		SetTextFont("Comic Sans MS")
		SetTextBold()
		SetTextColor(255,255,255,255)
		SetTextPosition(0.5,0.8)
		SetTextOutline()
		SetTextScale(0.7)
		SetTextWrapping(0.8)
		DrawText(node)
		Wait(0)
		if IsButtonBeingPressed(3,0) then
			break
		end
	end
	PedSetActionNode(gPlayer,"/G","")
end

-- set thread
function F_ToggleThread(...)
	if thread and IsThreadRunning(thread) then
		TerminateThread(thread)
		thread = nil
	else
		thread = CreateThread(unpack(arg))
	end
end

-- menu system
mt_menu = {__index = {}}
function F_CreateMenu(title)
	local title_format,option_format
	SetTextFont("Arial")
	SetTextAlign("C","C")
	SetTextBlack()
	SetTextShadow()
	SetTextColor(255,255,255,255)
	SetTextWrapping(width)
	title_format = PopTextFormatting()
	SetTextFont("Georgia")
	SetTextAlign("L","T")
	SetTextBold()
	SetTextScale(0.8)
	SetTextColor(255,255,255,255)
	option_format = PopTextFormatting()
	return setmetatable({
		-- core:
		n = 0,
		i = 1,
		off = 0,
		live = true,
		adding = true, -- allowed to add options
		update = false, -- call F_UpdateMenu asap since we drew
		roptions = {},
		-- options:
		can_exit = true,
		fix_camera = true,
		-- style:
		title_text = title,
		title_format = title_format,
		option_format = option_format,
		draw_metrics = {
			menu_x = 0.07,
			menu_y = 0.3,
			menu_w_min = 0.4,
			menu_w_max = 0.5,
			title_pad_x = 0.012,
			title_pad_y = 0.01,
			option_pad_x = 0.004,
			option_pad_y = 0.004,
			option_count = 20,
		},
		-- selected is set when a selection is made
	},mt_menu)
end
function F_NavigateMenu(b)
	local buttons = {}
	function F_NavigateMenu(b)
		if IsButtonBeingPressed(b,0) then
			buttons[b] = GetTimer() + 300
			return true
		elseif not IsButtonPressed(b,0) then
			buttons[b] = nil
			return false
		elseif buttons[b] and GetTimer() >= buttons[b] then
			buttons[b] = math.max(GetTimer(),buttons[b]+50)
			return true
		end
	end
	return F_NavigateMenu(b)
end
function F_UpdateMenu(menu,active)
	menu.adding,menu.selected = true
	if active then
		if menu.can_exit and IsButtonBeingPressed(0,0) then
			SoundPlay2D("ButtonUp")
			menu.adding = false
			menu.live = false
		elseif menu.n ~= 0 and IsButtonBeingPressed(1,0) then
			SoundPlay2D("ButtonDown")
			menu.selected = menu.i
		elseif menu.n > 1 then
			if F_NavigateMenu(2,0) then
				SoundPlay2D("NavUp")
				menu.i = menu.i - 1
				if menu.i < 1 then
					menu.i = menu.n
				end
			elseif F_NavigateMenu(3,0) then
				SoundPlay2D("NavDwn")
				menu.i = menu.i + 1
				if menu.i > menu.n then
					menu.i = 1
				end
			end
		end
		menu.n = 0
	end
	menu.update = false
end
function F_DrawMenu(menu)
	local ar,metrics = GetDisplayAspectRatio(),menu.draw_metrics
	local shown = math.min(math.max(1,menu.n),metrics.option_count)
	local x,y,width,height = metrics.menu_x/ar,metrics.menu_y,metrics.menu_w_min/ar,0
	local w,h,bgbottom
	SetTextFormatting(menu.option_format)
	SetTextWrapping(metrics.menu_w_max/ar)
	for i = 1,shown do
		width = math.max(width,MeasureText(menu[menu.off+i])+metrics.option_pad_x/ar)
	end
	if menu.title_text ~= nil then
		SetTextFormatting(menu.title_format)
		w,h = MeasureText(menu.title_text)
		h = h + metrics.title_pad_y
		width = math.max(width,w+metrics.title_pad_x/ar)
		DrawRectangle(x,y,width,h,0,100,200,150)
		SetTextPosition(x+width*0.5,y+h*0.5)
		DrawText(menu.title_text)
		y = y + h
		SetTextFormatting(menu.option_format)
		SetTextWrapping(metrics.menu_w_max/ar)
	end
	for i = 1,shown do
		w,h = MeasureText(menu[menu.off+i])
		h = h + metrics.option_pad_y
		if menu.off + i == menu.i and menu.n ~= 0 then
			DrawRectangle(x,y,width,height,0,0,0,150) -- top
			DrawRectangle(x,y+height,width,h,255,255,255,150) -- middle
			bgbottom = height + h
		end
		height = height + h
	end
	if bgbottom then
		DrawRectangle(x,y+bgbottom,width,height-bgbottom,0,0,0,150) -- bottom
	else
		DrawRectangle(x,y,width,height,0,0,0,150)
	end
	DiscardText()
	height = 0
	for i = 1,shown do
		local rtext = menu.roptions[menu.off+i]
		SetTextFormatting(menu.option_format)
		if rtext ~= nil then
			SetTextAlign("R","T")
			SetTextClipping(width*0.5)
			SetTextPosition(x+width-(metrics.option_pad_x/ar)*0.5,y+height+metrics.option_pad_y*0.5)
			if menu.off + i == menu.i and menu.n ~= 0 then
				SetTextColor(0,0,0,255)
			end
			w,h = DrawText(rtext)
			SetTextFormatting(menu.option_format)
			SetTextWrapping(metrics.menu_w_max/ar-w)
		else
			SetTextWrapping(metrics.menu_w_max/ar)
		end
		SetTextPosition(x+(metrics.option_pad_x/ar)*0.5,y+height+metrics.option_pad_y*0.5)
		if menu.off + i == menu.i and menu.n ~= 0 then
			SetTextColor(0,0,0,255)
		end
		w,h = DrawText(menu[menu.off+i])
		height = height + h + metrics.option_pad_y
	end
end
function mt_menu.__index:active()
	if self.update then
		F_UpdateMenu(self,true)
	end
	return self.live
end
function mt_menu.__index:option(text,rtext)
	if self.update then
		F_UpdateMenu(self,true)
	end
	if self.adding then
		self.n = self.n + 1
		if self.n == self.selected and text == self[self.n] then
			self.adding,self.selected = false
			repeat
				self.n = self.n + 1 -- restore all previous options
			until self[self.n] == nil
			self.n = self.n - 1
			return true
		end
		self[self.n] = text
		self.roptions[self.n] = rtext
	end
	return false
end
function mt_menu.__index:draw(keep)
	if self.update then
		F_UpdateMenu(self,not keep)
	end
	if self.live then
		local shown = self.draw_metrics.option_count
		if self.fix_camera and IsButtonBeingReleased(2,0) then -- fix camera change
			CreateThread(function()
				CameraAllowChange(false)
				Wait(0)
				CameraAllowChange(true)
			end)
		end
		if self.n <= shown then -- adjust offset
			self.off = 0
		elseif self.i <= self.off then
			self.off = self.i - 1
		elseif self.i - self.off > shown then
			self.off = self.i - shown
		end
		if not keep then
			if self.n ~= 0 then
				local i = self.n + 1
				while self[i] ~= nil do
					self[i] = nil -- clear unused options
					self.roptions[i] = nil
					i = i + 1
				end
			else
				self[1] = "(empty menu)"
			end
		end
		F_DrawMenu(self)
		self.update = true
	end
end
