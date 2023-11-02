SPAWN_TIMER = 2000 -- only SPAWN_BURST spawns can be sent over SPAWN_TIMER
SPAWN_BURST = 10

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
	SendNetworkEvent("ambient:initPlayer")
	while true do
		if can_make_spawns() then
			local x,y,z = PedFindRandomSpawnPosition(gPlayer)
			if x ~= 9999 and not is_spawn_occupied(x,y,z,1) then
				local index = 1
				local timer = GetTimer()
				while times[index] do
					if timer >= times[index] then
						table.remove(times,index)
					else
						index = index + 1
					end
				end
				if index <= SPAWN_BURST then
					SendNetworkEvent("ambient:spawnPed",AreaGetVisible(),x,y,z)
					times[index] = timer + SPAWN_TIMER
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
						if not wandering[ped] then
							PedWander(v)
							wandering[ped] = true
						end
					elseif wandering[ped] then
						PedStop(v)
						PedClearObjectives(v)
						wandering[ped] = nil
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
function is_spawn_occupied(x1,y1,z1,range)
	range = range * range
	for ped in AllPeds() do
		local x2,y2,z2 = PedGetPosXYZ(ped)
		local dx,dy,dz = x2-x1,y2-y1,z2-z1
		if dx*dx+dy*dy+dz*dz < range then
			return true
		end
	end
	return false
end
