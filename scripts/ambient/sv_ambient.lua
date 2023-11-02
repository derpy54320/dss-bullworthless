-- globals
gPlayers = {}
gPeds = {n = 0}

-- player events
RegisterNetworkEventHandler("ambient:initPlayer",function(player)
	local ids = {}
	for i,ped in ipairs(gPeds) do
		ids[i] = ped:get_id()
	end
	SendNetworkEvent(player,"ambient:setPeds",ids)
	gPlayers[player] = true
end)
RegisterLocalEventHandler("PlayerDropped",function(player)
	gPlayers[player] = nil
end)

-- spawn events
RegisterNetworkEventHandler("ambient:spawnPed",function(player,area,x,y,z)
	if gPeds.n < 20000 and gPlayers[player] and is_spawn_clear(area,x,y,z,1) then
		local ped = net.basync.create_ped(math.random(3,48))
		local id = ped:get_id()
		ped:set_area(area)
		ped:set_position(x,y,z)
		for p in pairs(gPlayers) do
			SendNetworkEvent(p,"ambient:addPed",id)
		end
	end
end)

-- spawn utility
function is_spawn_clear(area,x1,y1,z1,range)
	range = range * range
	for ped in net.basync.all_peds() do
		if ped:get_area() == area then
			local x2,y2,z2 = ped:get_position()
			local dx,dy,dz = x2-x1,y2-y1,z2-z1
			if dx*dx+dy*dy+dz*dz < range then
				return false
			end
		end
	end
	return true
end
