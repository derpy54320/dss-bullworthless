-- config
SPAWN_DISTANCE = GetConfigNumber(GetScriptConfig(),"spawn_distance",0)
SPAWN_SPACING = GetConfigNumber(GetScriptConfig(),"spawn_spacing",0) ^ 2
SPAWN_TIMER = GetConfigNumber(GetScriptConfig(),"spawn_timer",0)
SPAWN_BURST = GetConfigNumber(GetScriptConfig(),"spawn_burst",0)

-- globals
gPeds = {}

-- events
RegisterNetworkEventHandler("sheldon_world:setPeds",function(ids)
	gPeds = {}
	for _,id in ipairs(ids) do
		local ped = net.basync.get_ped_from_server(id,true)
		if ped then
			gPeds[ped] = true
		else
			PrintWarning("sheldon_world:setPeds failed to get ped #"..id)
		end
	end
end)
RegisterNetworkEventHandler("sheldon_world:addPed",function(id)
	local ped = net.basync.get_ped_from_server(id,true)
	if ped then
		gPeds[ped] = true
	else
		PrintWarning("sheldon_world:addPed failed to get ped #"..id)
	end
end)

-- main
function main()
	local times = {}
	local wandering = {}
	while not SystemIsReady() do
		Wait(0)
	end
	Wait(2000) -- TODO: this shouldn't be needed, it's just a bandaid for the server sending ids before basync initialized the player
	SendNetworkEvent("sheldon_world:initPlayer")
	if GetConfigBoolean(GetScriptConfig(),"show_debug_counter",false) then
		CreateThread("T_Debug")
	end
	while true do
		if can_make_spawns() then
			local x,y,z = PedFindRandomSpawnPosition(gPlayer)
			if x ~= 9999 and not is_spawn_occupied(x,y,z) and DistanceBetweenCoords3d(x,y,z,PlayerGetPosXYZ()) >= SPAWN_DISTANCE then
				local timer = GetTimer()
				while times[1] and timer >= times[1] do
					table.remove(times,1)
				end
				if table.getn(times) <= SPAWN_BURST then
					if SPAWN_TIMER > 0 then
						table.insert(times,timer+SPAWN_TIMER)
					end
					SendNetworkEvent("sheldon_world:spawnPed",AreaGetVisible(),x,y,z)
				end
			end
		end
		for v in pairs(wandering) do
			if not PedIsValid(v) then
				wandering[v] = nil
			end
		end
		for ped in pairs(gPeds) do
			if not ped:is_valid(true) then
				gPeds[ped] = nil
			elseif ped:is_valid() then
				local v = ped:get_ped()
				if PedIsValid(v) then
					if ped:is_owner() then
						if not wandering[v] then
							PedWander(v)
							wandering[v] = true
						end
						if PedIsModel(v,66) then
							if PedCanSeeObject(v,gPlayer,2) then
								PedSetPedToTypeAttitude(v,13,0)
								PedSetEmotionTowardsPed(v,gPlayer,0)
								PedAttackPlayer(v,3)
							end
							PedSetInfiniteSprint(v,true)
							GameSetPedStat(v,20,PedIsInCombat(v) and 200 or 100)
							GameSetPedStat(v,8,100)
							PedSetMaxHealth(v,200)
						end
					elseif wandering[v] then
						PedStop(v)
						PedClearObjectives(v)
						wandering[v] = nil
					end
				end
			end
		end
		Wait(0)
	end
end
function can_make_spawns()
	return not AreaIsLoading() and GetCutsceneRunning() == 0
end
function is_spawn_occupied(x1,y1,z1)
	for ped in AllPeds() do
		local x2,y2,z2 = PedGetPosXYZ(ped)
		local dx,dy,dz = x2-x1,y2-y1,z2-z1
		if dx*dx+dy*dy+dz*dz < SPAWN_SPACING then
			return true
		end
	end
	return false
end

-- riot
RegisterLocalEventHandler("PedStatOverriding",function(ped,stat,value)
	if stat == 8 and PedIsModel(ped,66) then
		return false
	end
end)

-- debug
function T_Debug()
	while true do
		local count = 0
		for ped in net.basync.all_peds() do
			count = count + 1
		end
		SetTextFont("Arial")
		SetTextBlack()
		SetTextColor(255,255,255,255)
		SetTextOutline()
		SetTextPosition(0.5,0.02)
		DrawText(GetPoolUsage("PED").." / "..count)
		Wait(0)
	end
end

CreateThread(function()
	local alpha = 0
	while false do
		local hidden = true
		for ped in AllPeds() do
			if PedIsInCombat(ped) and PedGetTargetPed(ped) == gPlayer then
				hidden = false
				break
			end
		end
		if hidden then
			alpha = alpha + GetFrameTime() / 1
			if alpha > 1 then
				alpha = 1
			end
		elseif alpha ~= 0 then
			alpha = alpha - GetFrameTime() / 0.5
			if alpha < 0 then
				alpha = 0
			end
		end
		if alpha ~= 0 then
			SetTextFont("Georgia")
			SetTextBold()
			SetTextColor(0,255,64,255*alpha)
			SetTextPosition(0.5,0.15)
			SetTextOutline()
			DrawText("[HIDDEN]")
		end
		Wait(0)
	end
end)
