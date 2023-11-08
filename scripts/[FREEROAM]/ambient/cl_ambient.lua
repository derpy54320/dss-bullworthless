-- config
SPAWN_DISTANCE = GetConfigNumber(GetScriptConfig(),"spawn_distance",0)
SPAWN_SPACING = GetConfigNumber(GetScriptConfig(),"spawn_spacing",0) ^ 2
SPAWN_TIMER = GetConfigNumber(GetScriptConfig(),"spawn_timer",0)
SPAWN_BURST = GetConfigNumber(GetScriptConfig(),"spawn_burst",0)
RIOT_MODE = true

-- globals
gPeds = {}

-- events
RegisterNetworkEventHandler("ambient:setPeds",function(ids)
	gPeds = {}
	for _,id in ipairs(ids) do
		local ped = net.basync.get_ped_from_server(id,true)
		if ped then
			gPeds[ped] = true
		else
			PrintWarning("ambient:setPeds failed to get ped #"..id)
		end
	end
end)
RegisterNetworkEventHandler("ambient:addPed",function(id)
	local ped = net.basync.get_ped_from_server(id,true)
	if ped then
		gPeds[ped] = true
	else
		PrintWarning("ambient:addPed failed to get ped #"..id)
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
	SendNetworkEvent("ambient:initPlayer")
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
					SendNetworkEvent("ambient:spawnPed",AreaGetVisible(),x,y,z)
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
						local faction = PedGetFaction(v)
						if faction == 6 or faction == 9 or faction == 10 then
							faction = -1 -- they'll even hate their own faction
						end
						for rival = 0,13 do
							if rival ~= faction and PedGetPedToTypeAttitude(v,rival) ~= 0 then
								PedSetPedToTypeAttitude(v,rival,0)
							end
						end
						for target in AllPeds() do
							if target ~= v and PedGetFaction(target) ~= faction then
								PedSetEmotionTowardsPed(v,target,0)
							end
						end
						if not wandering[v] then
							PedWander(v)
							wandering[v] = true
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
