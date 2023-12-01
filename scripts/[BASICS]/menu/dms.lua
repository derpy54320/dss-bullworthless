-- derpy's menu system - derpy54320

local mt_menu = {__index = {}}
local styles = {}
local F_NavigateMenu
local F_UpdateMenu
local F_DrawMenu
local T_FixCam

-- Create
function F_CreateMenu(title,help)
	return setmetatable({
		-- core:
		n = 0,
		i = 1,
		off = 0,
		live = true,
		adding = true, -- allowed to add options
		update = false, -- call F_UpdateMenu asap since we drew
		keeping = false,
		roptions = {},
		doptions = {},
		-- options:
		can_exit = true,
		fix_camera = true,
		-- miscellaneous:
		title_text = title,
		desc_default = help,
		draw_style = styles.default(),
		-- extensions is set later if needed
		-- selected is set when a selection is made
		-- desc_text and desc_time are set by the alert method
	},mt_menu)
end

-- Core
function mt_menu.__index:active()
	if self.update then
		F_UpdateMenu(self,true)
	end
	return self.live
end
function mt_menu.__index:option(text,rtext,dtext) -- dtext has medium description priority
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
		self.doptions[self.n] = dtext
	end
	return false
end
function mt_menu.__index:alert(text,seconds) -- text has high description priority
	self.desc_text = text
	if seconds and seconds > 0 then
		self.desc_time = math.floor(GetTimer() + seconds * 1000)
	else
		self.desc_time = nil
	end
end
function mt_menu.__index:help(text) -- text has low description priority
	self.desc_default = text
end
function mt_menu.__index:draw(keep)
	if self.update then
		F_UpdateMenu(self,not keep)
	end
	if self.live then
		local shown = self.draw_style.option_count
		if self.fix_camera and IsButtonBeingReleased(2,0) then -- fix camera change
			CreateAdvancedThread("GAME2",T_FixCam)
		end
		if self.i > self.n and self.n ~= 0 then -- adjust index
			self.i = self.n
		end
		if self.n <= shown then -- adjust offset
			self.off = 0
		elseif self.i <= self.off then
			self.off = self.i - 1
		elseif self.i - self.off > shown then
			self.off = self.i - shown
		end
		if keep then
			if keep ~= true and self.i <= self.n then
				self.roptions[self.i] = keep -- update current rtext while keeping
			end
			self.keeping = true -- force inactive update next update
		elseif self.n ~= 0 then
			local i = self.n + 1
			while self[i] ~= nil do
				self[i] = nil -- clear unused options
				self.roptions[i] = nil
				self.doptions[i] = nil
				i = i + 1
			end
		else
			self[1] = "(empty menu)"
			self.roptions[i] = nil
			self.doptions[i] = nil
		end
		self.update = true
		return F_DrawMenu(self)
	end
	return 0,0,0,0
end

-- Extra
function mt_menu.__index:submenu(name,help) -- creates a new menu that inherits draw_style
	local menu = F_CreateMenu(name,help)
	menu.draw_style = {} -- inherits the style of the parent menu by making a copy
	for key,value in pairs(self.draw_style) do
		if type(value) == "table" then
			local t = {}
			for k,v in pairs(value) do
				t[k] = v
			end
			value = t
		end
		menu.draw_style[key] = value
	end
	return menu
end
function mt_menu.__index:extend(help) -- creates a new menu that extends to the right
	local menu = self:submenu(nil,help)
	if self.extensions then
		menu.extensions = {unpack(self.extensions)}
		table.insert(menu.extensions,self)
	else
		menu.extensions = {self}
	end
	return menu
end
function mt_menu.__index:style(name) -- apply a pre-defined style to the menu
	local f = styles[name]
	if not f then
		error("unknown style given",2)
	end
	self.draw_style = f()
end

-- Input
function mt_menu.__index:up()
	if F_NavigateMenu(2) then
		SoundPlay2D("NavUp")
		return true
	end
	return false
end
function mt_menu.__index:down()
	if F_NavigateMenu(3) then
		SoundPlay2D("NavDwn")
		return true
	end
	return false
end
function mt_menu.__index:left()
	if IsButtonBeingPressed(0,0) then
		SoundPlay2D("ButtonUp")
		TextPrintString("",0,1)
		return true
	end
	return false
end
function mt_menu.__index:right()
	if IsButtonBeingPressed(1,0) then
		SoundPlay2D("ButtonDown")
		TextPrintString("",0,1)
		return true
	end
	return false
end

-- Internal
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
	if menu.keeping then
		menu.keeping = false
	elseif active then
		if menu.can_exit and IsButtonBeingPressed(0,0) then
			SoundPlay2D("ButtonUp")
			TextPrintString("",0,1)
			menu.adding = false
			menu.live = false
		elseif menu.n ~= 0 and IsButtonBeingPressed(1,0) then
			SoundPlay2D("ButtonDown")
			TextPrintString("",0,1)
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
function F_DrawMenu(menu,extx,exty)
	local description
	local ar,style = GetDisplayAspectRatio(),menu.draw_style
	local shown = math.min(math.max(1,menu.n),style.option_count)
	local x,y,width,height = style.menu_x/ar,style.menu_y,style.menu_w_min/ar,0
	local selecty = y
	local w,h,bgbottom
	if extx then -- this menu is being drawn for an extended menu
		x,y = extx,exty
	elseif menu.extensions then -- draw previous menus if this menu is an extension
		for _,ext in ipairs(menu.extensions) do
			x,y = F_DrawMenu(ext,x,y)
		end
	end
	SetTextFormatting(style.option_format)
	SetTextWrapping(style.menu_w_max/ar)
	for i = 1,shown do -- measure options for width
		width = math.max(width,MeasureText(menu[menu.off+i])+style.option_pad_x/ar)
	end
	if menu.title_text ~= nil then -- draw title
		SetTextFormatting(style.title_format)
		w,h = MeasureText(menu.title_text)
		h = h + style.title_pad_y
		width = math.max(width,w+style.title_pad_x/ar)
		if menu.n > shown then
			DrawRectangle(x,y,width+style.scrollbar_width/ar,h,unpack(style.title_background))
		else
			DrawRectangle(x,y,width,h,unpack(style.title_background))
		end
		SetTextPosition(x+width*0.5,y+h*0.5)
		DrawText(menu.title_text)
		y = y + h
	end
	for i = 1,shown do -- measure options for height
		local rtext = menu.roptions[menu.off+i]
		SetTextFormatting(style.option_format)
		if rtext ~= nil then
			SetTextAlign("R","T")
			SetTextClipping(width*style.option_right_w)
			w,h = MeasureText(rtext)
			SetTextWrapping(width-style.option_pad_x/ar-w)
		else
			SetTextWrapping(width-style.option_pad_x/ar)
		end
		w,h = MeasureText(menu[menu.off+i])
		h = h + style.option_pad_y
		if menu.off + i == menu.i and menu.n ~= 0 then
			DrawRectangle(x,y,width,height,0,0,0,style.option_background[4]) -- top
			DrawRectangle(x,y+height,width,h,unpack(style.option_background)) -- middle
			bgbottom = height + h
			selecty = y + height
		end
		height = height + h
	end
	if bgbottom then
		DrawRectangle(x,y+bgbottom,width,height-bgbottom,0,0,0,style.option_background[4]) -- bottom
	else
		DrawRectangle(x,y,width,height,0,0,0,style.option_background[4]) -- full backdrop if none were drawn for selection
	end
	if menu.n > shown then -- draw scrollbar
		local r = menu.off / (menu.n - shown)
		w = style.scrollbar_width / ar
		h = height * (shown / menu.n)
		DrawRectangle(x+width,y,w,(height-h)*r,0,0,0,style.option_background[4]) -- above bar
		DrawRectangle(x+width,y+(height-h)*r,w,h,unpack(style.title_background)) -- scroll bar
		DrawRectangle(x+width,y+height*r+h*(1-r),w,(height-h)*(1-r),0,0,0,style.option_background[4]) -- below bar
	end
	DiscardText()
	height = 0
	for i = 1,shown do -- draw menu options
		local rtext = menu.roptions[menu.off+i]
		SetTextFormatting(style.option_format)
		if rtext ~= nil then
			SetTextAlign("R","T")
			SetTextClipping(width*style.option_right_w)
			SetTextPosition(x+width-(style.option_pad_x/ar)*0.5,y+height+style.option_pad_y*0.5)
			if menu.off + i == menu.i and menu.n ~= 0 then
				SetTextColor(0,0,0,255)
			end
			w,h = DrawText(rtext)
			SetTextFormatting(style.option_format)
			SetTextWrapping(width-style.option_pad_x/ar-w)
		else
			SetTextWrapping(width-style.option_pad_x/ar)
		end
		SetTextPosition(x+(style.option_pad_x/ar)*0.5,y+height+style.option_pad_y*0.5)
		if menu.off + i == menu.i and menu.n ~= 0 then
			SetTextColor(0,0,0,255)
		end
		w,h = DrawText(menu[menu.off+i])
		height = height + h + style.option_pad_y
	end
	if menu.desc_text ~= nil then -- update description set by alert
		if menu.desc_time and GetTimer() >= menu.desc_time then
			menu.desc_text = nil
		else
			description = menu.desc_text
			if not menu.desc_time then
				menu.desc_text = nil
			end
		end
	end
	if description == nil and menu.i <= menu.n then -- possibly use option description instead
		description = menu.doptions[menu.i]
	end
	if description == nil and menu.desc_default ~= nil then -- or finally just use menu help
		description = menu.desc_default
	end
	if description ~= nil then -- draw description
		y = y + height + style.desc_off_y
		SetTextFormatting(style.description_format)
		SetTextWrapping(width-style.desc_pad_x/ar)
		SetTextPosition(x+(style.desc_pad_x/ar)*0.5,y+style.desc_pad_y*0.5)
		w,h = MeasureText(description)
		height = h + style.desc_pad_y
		DrawRectangle(x,y,width,height,0,0,0,style.option_background[4])
		DrawText(description)
	end
	if not extx then
		local bx,by = style.menu_x/ar,style.menu_y
		return bx,by,(x+width)-bx,(y+height)-by -- full dimensions to return for draw method
	end
	return x+width,selecty -- new x and y for extensions
end
function T_FixCam()
	CameraAllowChange(false)
	Wait(0)
	CameraAllowChange(true)
end

-- Styles
function styles.default()
	local title_format,option_format,description_format
	SetTextFont("Georgia")
	SetTextAlign("C","C")
	SetTextBold()
	SetTextItalic()
	SetTextShadow()
	SetTextScale(1.4)
	SetTextColor(220,220,220,255)
	SetTextWrapping(width)
	title_format = PopTextFormatting()
	SetTextFont("Georgia")
	SetTextAlign("L","T")
	SetTextBold()
	SetTextScale(0.9)
	SetTextColor(210,210,210,255)
	option_format = PopTextFormatting()
	SetTextFont("Georgia")
	SetTextAlign("L","T")
	SetTextBold()
	SetTextScale(0.7)
	SetTextColor(210,210,210,255)
	description_format = PopTextFormatting()
	return {
		menu_x = 0.04, -- x and w values are divided by aspect ratio
		menu_y = 0.285,
		menu_w_min = 0.45,
		menu_w_max = 0.55,
		title_pad_x = 0.008, -- padding is the total on both sides
		title_pad_y = 0.006,
		option_pad_x = 0.004,
		option_pad_y = 0.004,
		option_right_w = 0.8, -- relative to calculated width
		option_count = 16,
		desc_off_y = 0.004,
		desc_pad_x = 0.008,
		desc_pad_y = 0.008,
		scrollbar_width = 0.008,
		title_background = {49,85,90,150},
		option_background = {240,240,240,150},
		title_format = title_format,
		option_format = option_format,
		description_format = description_format,
	}
end
function styles.alternate()
	local title_format,option_format,description_format
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
	SetTextFont("Georgia")
	SetTextAlign("L","T")
	SetTextBold()
	SetTextScale(0.6)
	SetTextColor(255,255,255,255)
	description_format = PopTextFormatting()
	return {
		menu_x = 0.07, -- x and w values are divided by aspect ratio
		menu_y = 0.3,
		menu_w_min = 0.4,
		menu_w_max = 0.5,
		title_pad_x = 0.012, -- padding is the total on both sides
		title_pad_y = 0.01,
		option_pad_x = 0.004,
		option_pad_y = 0.004,
		option_right_w = 0.8, -- relative to calculated width
		option_count = 20,
		desc_off_y = 0.004,
		desc_pad_x = 0.008,
		desc_pad_y = 0.008,
		scrollbar_width = 0.008,
		title_background = {0,100,200,150},
		option_background = {255,255,255,150},
		title_format = title_format,
		option_format = option_format,
		description_format = description_format,
	}
end
function styles.swegta()
	local style = styles.default()
	for _,key in ipairs({"title_format","option_format","description_format"}) do
		SetTextFormatting(style[key])
		SetTextFont("Comic Sans MS")
		SetTextItalic(false)
		SetTextBlack(false)
		SetTextBold(true)
		style[key] = PopTextFormatting()
	end
	style.option_count = 12
	return style
end
function styles.opaque()
	local style = styles.default()
	style.title_background = {unpack(style.title_background)}
	style.option_background = {unpack(style.option_background)}
	style.title_background[4] = 255
	style.option_background[4] = 255
	return style
end
