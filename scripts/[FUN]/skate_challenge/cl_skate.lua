local MINIMUM_SPEED = 5

local gTransition
local gWaiting = false
local gStarted
local gThread
local gLast = {0,0,0}
local gLeaderboard = {}

function MissionCleanup()
	PlayerSetControl(1)
end
function main()
	local score
	local under_speed
	local rolling = CreateTexture("rolling.png")
	while not SystemIsReady() do
		Wait(0)
	end
	SendNetworkEvent("skate:initPlayer")
	while true do
		gTransition = nil
		while not gTransition or AreaIsLoading() do
			Wait(0)
		end
		transition_area()
		gWaiting = true
		SendNetworkEvent("skate:imReady")
		if PedGetAmmoCount(gPlayer,437) < 1 then
			GiveWeaponToPlayer(437,1)
		end
		PlayerSetWeapon(437,1)
		PedSetActionNode(gPlayer,"/G/VEHICLES/SKATEBOARD/LOCOMOTION/BOARDINHAND/IDLE/IDLE","")
		CameraReset()
		CameraDefaultFOV()
		CameraReturnToPlayer()
		while gWaiting do
			if not PedIsPlaying(gPlayer,"/G/VEHICLES/SKATEBOARD/LOCOMOTION/BOARDINHAND/IDLE/IDLE",true) then
				PedSetActionNode(gPlayer,"/G/VEHICLES/SKATEBOARD/LOCOMOTION/BOARDINHAND/IDLE/IDLE","")
			end
			PlayerSetControl(0)
			Wait(0)
		end
		PlayerSetControl(1)
		PlayerSetWeapon(437,1)
		gStarted = GetTimer()
		update_speed()
		while gStarted do
			local h = 0.2
			local w = h * GetTextureDisplayAspectRatio(rolling)
			local speed = update_speed()
			DrawTexture(rolling,0.5-w/2,0,w,h,255,255,255,255)
			if speed >= MINIMUM_SPEED then
				under_speed = nil
			elseif not under_speed then
				under_speed = GetTimer()
			end
			score = GetTimer() - gStarted
			if score >= 3000 and (should_fail() or (under_speed and GetTimer() - under_speed >= 1000)) then
				SendNetworkEvent("skate:imDone",score)
				break
			end
			update_players(get_time(score))
			SetTextFont("Arial")
			SetTextBlack()
			if speed < MINIMUM_SPEED then
				SetTextColor(255,0,0,255)
			else
				SetTextColor(255,255,255,255)
			end
			SetTextOutline()
			SetTextPosition(0.5,0.95)
			SetTextAlign("C","C")
			SetTextScale(0.9)
			DrawText("%s\n(speed: %.1f)",get_time(score),speed)
			Wait(0)
		end
		while gStarted do
			update_players(get_time(GetTimer()-gStarted))
			if math.mod(math.floor(GetTimer()/500),2) == 0 then
				SetTextFont("Arial")
				SetTextBlack()
				SetTextColor(255,0,0,255)
				SetTextOutline()
				SetTextPosition(0.5,0.95)
				SetTextAlign("C","C")
				SetTextScale(0.85)
				DrawText(get_time(score))
			end
			Wait(0)
		end
	end
end
function transition_area()
	local area,x,y,z,h = unpack(gTransition)
	PlayerSetPosXYZArea(x,y,z,area)
	while AreaIsLoading() do
		Wait(0)
	end
	PedFaceHeading(gPlayer,h,0)
end
function get_time(ms)
	local s = math.floor(ms / 1000)
	local m = math.floor(s / 60)
	s = math.mod(s,60)
	if m == 0 then
		return s
	elseif s < 10 then
		return m..":0"..s
	end
	return m..":"..s
end
function should_fail()
	return PedGetWeapon(gPlayer) ~= 437 or not (PedIsPlaying(gPlayer,"/G/VEHICLES/SKATEBOARD/LOCOMOTION/RIDE/BRAKE",true) or PedIsPlaying(gPlayer,"/G/VEHICLES/SKATEBOARD/LOCOMOTION/RIDE/CHARGEJUMP",true) or PedIsPlaying(gPlayer,"/G/VEHICLES/SKATEBOARD/LOCOMOTION/RIDE/COAST",true) or PedIsPlaying(gPlayer,"/G/VEHICLES/SKATEBOARD/LOCOMOTION/RIDE/POWERSLIDE",true))
end
function update_speed()
	local x1,y1,z1 = unpack(gLast)
	local x2,y2,z2 = PlayerGetPosXYZ()
	local dx,dy,dz = x2-x1,y2-y1,z2-z1
	gLast = {x2,y2,z2}
	return math.sqrt(dx*dx+dy*dy+dz*dz) / GetFrameTime()
end

SetCommand("start_skate_challenge",function()
	SendNetworkEvent("skate:startChallenge")
end)
RegisterNetworkEventHandler("skate:getReady",function(area,x,y,z,h)
	gStarted = nil
	gWaiting = false
	gTransition = {area,x,y,z,h}
end)
RegisterNetworkEventHandler("skate:startChallenge",function()
	gLeaderboard = {}
	gWaiting = false
end)
RegisterNetworkEventHandler("skate:showText",function(text,ms)
	if gThread then
		TerminateThread(gThread)
	end
	gThread = CreateThread("T_Text",text,ms)
end)
RegisterNetworkEventHandler("skate:finishChallenge",function()
	gStarted = nil
end)

function T_Text(text,ms)
	local expire = GetTimer() + ms
	repeat
		SetTextFont("Arial")
		SetTextBlack()
		SetTextColor(255,255,255,255)
		SetTextOutline()
		SetTextPosition(0.5,0.3)
		SetTextAlign("C","C")
		SetTextScale(1.5)
		DrawText(text)
		Wait(0)
	until GetTimer() >= expire
end

RegisterLocalEventHandler("ControllerUpdating",function(c)
	if gStarted and c == 0 and PedIsPlaying(gPlayer,"/G/VEHICLES/SKATEBOARD/LOCOMOTION/RIDE",true) then
		SetButtonPressed(7,0,false)
		--SetButtonPressed(8,0,false)
	end
end)

-- leaderboard
function get_player(id)
	for _,v in ipairs(gLeaderboard) do
		if v.id == id then
			return v
		end
	end
end
function update_players(score)
	for _,v in ipairs(gLeaderboard) do
		if v.active then
			v.score = score
		end
	end
end
CreateThread(function()
	while true do
		if gStarted then
			local x,y,w,h = 0.2/GetDisplayAspectRatio(),0.3
			for _,v in ipairs(gLeaderboard) do
				SetTextFont("Arial")
				SetTextBlack()
				SetTextScale(0.9)
				SetTextAlign("L","T")
				SetTextPosition(x,y)
				SetTextColor(255,255,255,255)
				SetTextOutline()
				w,h = DrawText(v.name..": "..v.score)
				y = y + h
			end
		end
		Wait(0)
	end
end)
RegisterNetworkEventHandler("skate:startPlayer",function(id,name)
	if not get_player(id) then
		table.insert(gLeaderboard,{id = id,name = name,score = 0,active = true})
	end
	table.sort(gLeaderboard,function(a,b)
		local as,bs = string.lower(a.name),string.lower(b.name)
		if as ~= bs then
			return as < bs
		end
		return a.id < b.id
	end)
end)
RegisterNetworkEventHandler("skate:finishPlayer",function(id,score)
	local what = get_player(id)
	if what then
		what.active = false
		what.score = get_time(score)
	end
end)

-- keyboard
RegisterLocalEventHandler("ControllersUpdated",function(c)
	if c == 0 and not IsUsingJoystick(c) then
		local x,y = 0,0
		--[[
		if IsKeyPressed("W",c) then
			y = y + 1
		end
		if IsKeyPressed("A",c) then
			x = x - 1
		end
		if IsKeyPressed("S",c) then
			y = y - 1
		end
		if IsKeyPressed("D",c) then
			x = x + 1
		end
		]]
		SetStickValue(c,16,x)
		SetStickValue(c,17,y)
	end
end)
