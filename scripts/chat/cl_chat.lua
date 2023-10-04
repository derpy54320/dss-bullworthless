-- derpy's script server: chat - derpy54320 & SWEGTA
api = GetScriptSharedTable()

-- globals
gTyping = false
gEscape = false -- keep controls disabled while holding escape
gCommand = false -- put script printing into chat for command output
gDisplay = false -- if not false, the time that the chat was displayed
gMessages = {n = 0}
gScrolling = 0 -- how far we're scrolled back in messages

-- api
function api.notify(message,r,g,b)
	if r then
		if type(r) ~= "number" or type(g) ~= "number" or type(b) ~= "number" then
			error("bad color arguments",2)
		end
		F_AddMessage({s = tostring(message),r = r,g = g,b = b})
	else
		F_AddNotification("alert",tostring(message))
	end
	SoundPlay2D("ButtonDown")
end
function api.say(name,message,r,g,b)
	if r then
		if type(r) ~= "number" or type(g) ~= "number" or type(b) ~= "number" then
			error("bad color arguments",2)
		end
		F_AddMessage({n = tostring(name),s = tostring(message),r = r,g = g,b = b})
	else
		F_AddMessage({n = tostring(name),s = tostring(message),r = 255,g = 213,b = 3})
	end
	SoundPlay2D("ButtonDown")
end

-- cleanup
function MissionCleanup()
	if gTyping then
		StopTyping()
	end
end

-- main
function main()
	local ui = false
	local drawing = CreateAdvancedThread("PRE_FADE","T_Draw")
	while not SystemIsReady() do
		Wait(0)
	end
	if GetConfigBoolean(GetScriptConfig(),"should_fade_chat",true) then
		drawing = CreateAdvancedThread("PRE_FADE","T_Draw")
	else
		drawing = CreateDrawingThread("T_Draw")
	end
	while IsThreadRunning(drawing) do
		if F_CanUseChat() then
			F_Typing()
			F_Scroll()
			ui = true
		elseif ui then
			if gTyping then
				StopTyping()
				gTyping = false
			end
			ui = false
		end
		Wait(0)
	end
end
function F_CanUseChat()
	if GetConfigBoolean(GetScriptConfig(),"use_account_system") and dsl.account and dsl.account.is_ui_active() then
		return false -- account ui is active
	end
	return true -- we can use the chat
end

-- typing
function F_Typing()
	if gTyping or F_StartTyping() then
		local submit = F_UpdateTyping()
		if submit then
			local max_char = GetConfigNumber(GetScriptConfig(),"max_message_length",100)
			if string.sub(submit,1,1) == '/' then
				local starts,stops,name = string.find(submit,"[/]*%s*(%S+)%s*",1) -- seperate command name and arguments
				if starts then
					F_RunCommand(name,string.sub(submit,stops+1)) -- command name + anything else afterwards
				end
			else
				local starts = string.find(submit,"%S")
				if starts then
					F_SendMessage(string.sub(submit,starts,starts+max_char-1))
				end
			end
		end
	end
end
function F_StartTyping()
	local started = false
	local command = IsKeyBeingPressed("SLASH")
	if (command or IsKeyBeingPressed("RETURN")) and not IsConsoleActive() then
		if command then
			started = StartTyping("/")
		else
			started = StartTyping()
		end
		if started then
			SoundPlay2D("ButtonDown")
			gTyping = true
		end
	end
	return started
end
function F_UpdateTyping()
	F_ShowDisplay()
	if not IsTypingActive() then
		gTyping = false
		if not WasTypingAborted() then
			return GetTypingString() -- submit this message
		end
	elseif IsConsoleActive() then
		SoundPlay2D("NavInvalid")
		StopTyping()
		gTyping = false
	end
end
function F_RunCommand(cmd,args)
	if string.lower(cmd) == "help" then
		local str = GetConfigString(GetScriptConfig(),"help_command_output")
		if str then
			F_AddNotification("output",str)
		else
			F_AddNotification("error","no help available")
		end
		return
	elseif args ~= "" then
		cmd = cmd.." "..args
	end
	gCommand = true
	if not RunCommand(cmd) then
		F_AddNotification("error","command does not exist")
	end
	gCommand = false
end
function F_SendMessage(message)
	local profanity = GetConfigNumber(GetScriptConfig(),"use_profanity_filter")
	if profanity then
		if not dsl.profanity then
			PrintWarning("Failed to send message because \"profanity\" scripts are not running.")
			return
		end
		message = dsl.profanity.get_clean_str(message,profanity)
	end
	SendNetworkEvent("chat:sendMessage",message)
end

-- scrolling
function F_Scroll()
	if not IsConsoleActive() then
		if IsKeyBeingPressed("PRIOR") then
			F_ShowDisplay()
			if gScrolling < gMessages.n - 1 then
				gScrolling = gScrolling + 1
				SoundPlay2D("NavUp")
			end
		elseif IsKeyBeingPressed("NEXT") then
			F_ShowDisplay()
			if gScrolling > 0 then
				gScrolling = gScrolling - 1
				SoundPlay2D("NavDwn")
			end
		end
	end
end

-- utility
function F_ShowDisplay()
	gDisplay = GetTimer()
end
function F_AddMessage(msg)
	-- {n = "name", s = "string", r = 255, g = 255, b = 255}
	-- if .n == nil, the color is for the whole string
	-- otherwise the color is just for the name
	if gMessages.n >= GetConfigNumber(GetScriptConfig(),"max_message_count",100) then
		table.remove(gMessages,1)
	end
	table.insert(gMessages,msg)
	F_ShowDisplay()
	gScrolling = 0
end
function F_AddNotification(type,text)
	local msg = {s = text,r = 150,g = 150,b = 150}
	if type == "alert" then
		msg.r,msg.g,msg.b = 230,230,230
	elseif type == "error" then
		msg.r,msg.g,msg.b = 200,50,50
	elseif type == "warning" then
		msg.r,msg.g,msg.b = 200,150,50
	elseif type == "special" then
		msg.r,msg.g,msg.b = 50,150,200
	end
	F_AddMessage(msg)
end

-- drawing
function T_Draw()
	local chatbox = CreateTexture("chatbox.png")
	local chatbanner = CreateTexture("chatbanner.png") -- same res as chatbox
	local timeout = GetConfigNumber(GetScriptConfig(),"display_timeout_ms",7000)
	local draw = {
		-- basic:
		base_x = 0.01, -- base position is relative to bottom right (base_x is divided by aspect)
		base_y = 0.01,
		height = 0.35, -- chatbox size
		txtfmt = F_SetupText(),
		-- state (updating during drawing):
		alpha = 0, -- goes from 0 to 1 when gDisplay is on
		ar = 1, -- set to the display aspect when drawing starts
		x = 0, -- x, y, and width are set during the backdrop draw
		y = 0,
		width = 0,
		-- box (area that is actually used):
		box_y = 0.03, -- where chat text starts    (from bottom, .height relative)
		box_w = 0.95, -- how wide chat text spans  (from center, .width relative)
		box_pad_x = 0.015, -- total for both sides (.height relative, divided by aspect)
		box_pad_y = 0.015, -- total for both sides (.height relative)
		-- typing:
		type_h = 0.075, -- box height (from top,    .height relative)
		type_adjust_y = GetConfigNumber(GetScriptConfig(),"font_offset",-0.1), -- text offset (relative to final calculated position)
		type_adjust_size = 0.9, -- text scale (relative to final calculated size)
		-- messages:
		msg_clip_h = 0.2, -- where to start clipping text (from top, .height relative)
		msg_space_w = 0.01, -- space between name and msg (.height relative, divided by aspect)
	}
	while true do
		if gDisplay and GetTimer() - gDisplay >= timeout then
			gDisplay = false
		end
		if not IsGamePaused() then
			if gDisplay then
				if draw.alpha ~= 1 then
					draw.alpha = math.min(1,draw.alpha+GetFrameTime()/0.3) -- fade in
				end
			elseif draw.alpha ~= 0 then
				draw.alpha = math.max(0,draw.alpha-GetFrameTime()/0.7) -- fade out
			end
			if draw.alpha ~= 0 then
				draw.ar = GetDisplayAspectRatio()
				F_DrawBackdrop(draw,chatbox) -- also updates x, y, and width
				if gTyping then
					F_DrawTyping(draw,GetTypingString())
				end
				F_DrawMessages(draw)
				F_DrawBanner(draw,chatbanner) -- banner is drawn after text so it goes on top
			end
		end
		Wait(0)
	end
end
function F_SetupText()
	local cfg = GetScriptConfig()
	local weight = GetConfigString(cfg,"font_weight","black")
	SetTextFont(GetConfigString(cfg,"font_family","Arial"))
	SetTextScale(GetConfigNumber(cfg,"font_scale",0.7))
	if weight == "bold" then
		SetTextBold()
	elseif weight == "black" then
		SetTextBlack()
	end
	return PopTextFormatting()
end
function F_DrawBackdrop(d,texture)
	d.width = d.height * GetTextureDisplayAspectRatio(texture)
	d.x = 1 - d.width - d.base_x / d.ar
	d.y = 1 - d.height - d.base_y
	DrawTexture(texture,d.x,d.y,d.width,d.height,255,255,255,255*d.alpha)
end
function F_DrawTyping(d,str)
	local width = d.width * d.box_w -- full size of the typing box
	local height = d.height * d.type_h
	local pad_x = (d.height * d.box_pad_x) / d.ar -- padding for the text inside the typing box
	local pad_y = d.height * d.box_pad_y
	local x = d.x + (d.width * (1 - d.box_w)) / 2 -- top left corner of the typing box
	local y = d.y + d.height * ((1 - d.box_y) - d.type_h)
	DrawRectangle(x,y,width,height,0,0,0,150*d.alpha)
	SetTextFormatting(d.txtfmt)
	SetTextColor(220,220,220,255*d.alpha)
	SetTextHeight((height-pad_y)*d.type_adjust_size)
	if MeasureText(str) > width - pad_x then -- start drawing right aligned if we go off the edge
		SetTextClipping(width-pad_x)
		SetTextPosition(x+width-pad_x/2,y+pad_y/2+height*d.type_adjust_y)
		SetTextAlign("R","T")
	else
		SetTextPosition(x+pad_x/2,y+pad_y/2+height*d.type_adjust_y)
		SetTextAlign("L","T")
	end
	DrawText(str)
end
function F_DrawMessages(d)
	local width = d.width * d.box_w -- full width of the messages area
	local top_y = d.y + d.height * d.msg_clip_h
	local pad_x = (d.height * d.box_pad_x) / d.ar -- padding for the text inside the messages area
	local pad_y = d.height * d.box_pad_y
	local x = d.x + (d.width - width) / 2 -- bottom left of messages area
	local y = d.y + d.height * (1 - d.box_y)
	if gTyping then
		y = y - d.height * d.type_h
	end
	if y <= top_y then
		return
	end
	x = x + pad_x / 2
	y = y - pad_y / 2
	width = width - pad_x
	for index = gMessages.n-gScrolling,1,-1 do
		local w,h
		local msg = gMessages[index]
		if msg.n then
			local fmt,w2,h2
			local name = msg.n..":"
			local space = (d.height * d.msg_space_w) / d.ar
			SetTextFormatting(d.txtfmt)
			SetTextColor(msg.r,msg.g,msg.b,255*d.alpha)
			SetTextClipping(nil,y-top_y)
			SetTextPosition(x,y)
			SetTextAlign("L","B")
			fmt = PopTextFormatting()
			SetTextFormatting(d.txtfmt)
			w,h = MeasureText(name) -- measure name
			w2,h2 = MeasureText(msg.s) -- measure message
			if w + w2 + space <= width then
				SetTextFormatting(fmt)
				SetTextClipping(width,y-top_y)
				DrawText(name) -- draw single line name
				SetTextFormatting(fmt)
				SetTextColor(230,230,230,255*d.alpha)
				SetTextPosition(x+w+space,y)
				DrawText(msg.s) -- then draw single line message
				h = math.max(h,h2)
			else
				SetTextFormatting(fmt)
				SetTextColor(230,230,230,255*d.alpha)
				SetTextWrapping(width)
				w2,h2 = DrawText(msg.s) -- draw multi line message
				SetTextFormatting(fmt)
				SetTextClipping(width,y-top_y)
				SetTextPosition(x,y-h2)
				w,h = DrawText(name) -- then draw multi line name
				h = h + h2
			end
		else
			SetTextFormatting(d.txtfmt)
			SetTextColor(msg.r,msg.g,msg.b,255*d.alpha)
			SetTextClipping(nil,y-top_y)
			SetTextWrapping(width)
			SetTextPosition(x,y)
			SetTextAlign("L","B")
			w,h = DrawText(msg.s) -- draw nameless message
		end
		y = y - h
		if y <= top_y + 0.001 then -- slight extra bit because floating point accuracy
			return
		end
	end
end
function F_DrawBanner(d,texture)
	DrawTexture(texture,d.x,d.y,d.width,d.height,255,255,255,255*d.alpha)
end

-- local events
RegisterLocalEventHandler("ScriptPrinted",function(str,type)
	if gCommand then
		F_AddNotification(type,str)
	end
end)
RegisterLocalEventHandler("ControllerUpdating",function(c)
	if (gTyping or gEscape) and c == 0 and not IsGamePaused() then
		if gEscape then
			if not gTyping and not IsKeyPressed("ESCAPE",0) then
				gEscape = false -- controls stay disabled until escape is released after typing
				return
			end
		elseif IsKeyPressed("ESCAPE",0) then
			gEscape = true
		end
		ZeroController(c)
	end
end)
RegisterLocalEventHandler("ControllersUpdated",function()
	if (gTyping or gEscape) and not IsGamePaused() then
		ZeroController(0)
	end
end)

-- network events
RegisterNetworkEventHandler("chat:playerJoined",function(name,id)
	if id then
		F_AddNotification("output","["..id.."] "..name.." has joined the game.")
	else
		F_AddNotification("output",name.." has joined the game.")
	end
	SoundPlay2D("RightBtn")
end)
RegisterNetworkEventHandler("chat:playerLeft",function(name,id)
	if id then
		F_AddNotification("output","["..id.."] "..name.." has left the game.")
	else
		F_AddNotification("output",name.." has left the game.")
	end
	SoundPlay2D("WrongBtn")
end)
RegisterNetworkEventHandler("chat:playerMessage",function(name,str,r,g,b)
	F_AddMessage({n = name,s = str,r = r,g = g,b = b})
	SoundPlay2D("ButtonDown")
end)
RegisterNetworkEventHandler("chat:serverMessage",function(str,r,g,b)
	if r then
		F_AddMessage({s = str,r = r,g = g,b = b})
	else
		F_AddNotification("alert",str)
	end
	SoundPlay2D("ButtonDown")
end)
