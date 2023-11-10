MAX_DRUNK_LEVEL = 4
DRUNK_LEVEL = 0
DRUNK_ROT = 0

function MissionSetup()
	LoadActionTree("2_S05.act")
	LoadActionTree("Act/Props/SodaMach.act")
end
function MissionCleanup()
	if PedGetWeapon(gPlayer) == 327 then
		PedDestroyWeapon(gPlayer,327)
	end
	PickupRemoveAll(327)
end
function main()
	CreateThread("T_DrunkUpdate")
	CreateAdvancedThread("PRE_FADE","T_DrunkHud")
	while true do
		while not WeaponRequestModel(327) do
			TextPrintString("...",0,2)
			Wait(0)
		end
		if PedIsPlaying(gPlayer,"/G/WPROPS/GARBINTERACT",true) then
			PedSetActionNode(gPlayer,"/G/WEAPONS/PICKUPACTIONS/PICKUPSNOWBALL/PICKUPWEAPON/PICKUPWEAPON","")
			while PedIsPlaying(gPlayer,"/G/WEAPONS/PICKUPACTIONS/PICKUPSNOWBALL/PICKUPWEAPON/PICKUPWEAPON",true) do
				if PedGetWeapon(gPlayer) == 313 then
					PickupRemoveAll(327)
					PedDestroyWeapon(gPlayer,313)
					PedSetWeaponNow(gPlayer,327,1,false)
				end
				Wait(0)
			end
			PedDestroyWeapon(gPlayer,313)
		end
		if PedGetWeapon(gPlayer) == 327 and IsButtonBeingPressed(6,0) and (PedMePlaying(gPlayer,"DEFAULT_KEY",true) or PedIsPlaying(gPlayer,"/G/PLAYER/ATTACKS",true)) then
			if play_drink("DRINK") and math.random(1,10) == 1 then
				play_drink("SPLURT")
			end
			PedDestroyWeapon(gPlayer,327)
		end
		Wait(0)
	end
end
function play_drink(what) -- DRINK or SPLURT
	local hp = PlayerGetHealth()
	if what == "DRINK" then
		what = "/G/2_S05/ANIMS/DRINK/DRINK/DRINK2"
		PedSetActionNode(gPlayer,what,"2_S05.ACT")
	else
		what = "/G/SODAMACH/PEDPROPSACTIONS/HASSODA/ACTIONS/PICKUPSODAANDDRINK/PICKUPSODA/DRINK"
		PedSetActionNode(gPlayer,what,"SODAMACH.ACT")
	end
	while PedIsPlaying(gPlayer,what,true) do
		if PedMePlaying(gPlayer,"DRINK2",true) and PedGetNodeTime(gPlayer) >= 5 then
			PedDestroyWeapon(gPlayer,327)
			DRUNK_LEVEL = DRUNK_LEVEL + 1
			if DRUNK_LEVEL > MAX_DRUNK_LEVEL then
				PedSetActionNode(gPlayer,"/G/HITTREE/STANDING/POSTHIT/STANDING/DEAD/COLLAPSE/COLLAPSE_B","")
				PlayerSetHealth(0)
				DRUNK_LEVEL = 0
				break
			end
			PedSetActionNode(gPlayer,"/G","")
			PlayerSetHealth(hp)
			return true
		end
		Wait(0)
	end
	return false
end
function T_DrunkHud()
	while true do
		local x,y,w,h = 0.5,0,0.4/GetDisplayAspectRatio(),0.02
		if DRUNK_LEVEL ~= 0 then
			DrawRectangle(x-w/2,y,w,h,0,0,0,255)
			DrawRectangle(x-w/2,y,w*(DRUNK_LEVEL/MAX_DRUNK_LEVEL),h,255,0,0,255)
		end
		Wait(0)
	end
end
function T_DrunkUpdate()
	local min_timing = 500
	local max_timing = 6000
	local timing = min_timing
	local scale = 1
	while true do
		if DRUNK_LEVEL ~= 0 then
			local level = DRUNK_LEVEL / MAX_DRUNK_LEVEL
			timing = timing + scale * (GetFrameTime() * 500)
			if timing < min_timing or timing >= max_timing then
				scale = math.random(100,300) / 100
				if timing >= max_timing then
					scale = -scale
				end
			end
			DRUNK_ROT = DRUNK_ROT + math.sin(GetTimer() / timing) * (0.7 + 0.3 * level) * GetFrameTime() * math.pi
			DRUNK_LEVEL = DRUNK_LEVEL - GetFrameTime() / 120
			if DRUNK_LEVEL < 0 then
				DRUNK_LEVEL = 0
			end
		end
		Wait(0)
	end
end
RegisterLocalEventHandler("ControllersUpdated",function()
	local x,y = GetStickValue(16,0),GetStickValue(17,0)
	local d = math.sqrt(x*x+y*y)
	local h = math.atan2(x,y)
	local dh = math.mod((h+DRUNK_ROT)-h,math.pi*2)
	while dh > math.pi do
		dh = dh - math.pi * 2
	end
	while dh <= -math.pi do
		dh = dh + math.pi * 2
	end
	h = h + dh * (DRUNK_LEVEL / MAX_DRUNK_LEVEL)
	SetStickValue(16,0,math.sin(h)*d)
	SetStickValue(17,0,math.cos(h)*d)
end)
