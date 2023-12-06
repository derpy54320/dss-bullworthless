-- server debug menu
basync = GetScriptNetworkTable()

-- utility
function register_debug_event(name,func)
	return RegisterNetworkEventHandler(name,function(player,...)
		if net.admin and net.admin.is_player_mod(player) then
			func(player,unpack(arg))
		end
	end)
end
function is_browsable(t,depth)
	if type(t) == "table" then
		if depth >= 100 then
			return false
		end
		for k,v in pairs(t) do
			if not is_browsable(k,depth+1) or not is_browsable(v,depth+1) then
				return false
			end
		end
	end
	return true
end

-- ped events
register_debug_event("basync:_debugSpawnPed",function(player,model,x,y,z,h,area)
	local ped = basync.create_ped(model,true)
	ped:set_position(x,y,z,h)
	ped:set_area(area)
end)
register_debug_event("basync:_debugDeletePed",function(player,id)
	local ped = basync.get_ped_from_player(id)
	if ped and not ped:is_player() then
		ped:delete()
	end
end)
register_debug_event("basync:_debugBrowsePed",function(player,id)
	local ped = basync.get_ped_from_player(id)
	if ped and is_browsable(ped,1) then
		SendNetworkEvent(player,"basync:_debugBrowsePed",ped)
	else
		SendNetworkEvent(player,"basync:_debugBrowsePed")
	end
end)
register_debug_event("basync:_debugTeleportPed",function(player,id,direction)
	local ped = basync.get_player_ped(player)
	local target = basync.get_ped_from_player(id)
	if ped and target then
		if direction then
			local a,x,y,z,h = target:get_area(),target:get_position()
			ped:set_position(x+math.sin(math.rad(h)),y-math.cos(math.rad(h)),z,h)
			ped:set_area(a)
		else
			local a,x,y,z,h = ped:get_area(),ped:get_position()
			target:set_position(x-math.sin(math.rad(h)),y+math.cos(math.rad(h)),z,h)
			target:set_area(a)
		end
	end
end)

-- vehicle events
register_debug_event("basync:_debugSpawnVehicle",function(player,model,x,y,z,h,area)
	local veh = basync.create_vehicle(model,true)
	veh:set_position(x,y,z,h)
	veh:set_area(area)
end)
register_debug_event("basync:_debugDeleteVehicle",function(player,id)
	local veh = basync.get_vehicle_from_player(id)
	if veh then
		veh:delete()
	end
end)
register_debug_event("basync:_debugBrowseVehicle",function(player,id)
	local veh = basync.get_vehicle_from_player(id)
	if veh and is_browsable(veh,1) then
		SendNetworkEvent(player,"basync:_debugBrowseVehicle",veh)
	else
		SendNetworkEvent(player,"basync:_debugBrowseVehicle")
	end
end)
register_debug_event("basync:_debugTeleportVehicle",function(player,id,direction)
	local ped = basync.get_player_ped(player)
	local veh = basync.get_vehicle_from_player(id)
	if ped and veh then
		if direction then
			local a,x,y,z,h = veh:get_area(),veh:get_position()
			ped:set_position(x+math.sin(math.rad(h)),y-math.cos(math.rad(h)),z,h)
			ped:set_area(a)
		else
			local a,x,y,z,h = ped:get_area(),ped:get_position()
			veh:set_position(x-math.sin(math.rad(h)),y+math.cos(math.rad(h)),z,h)
			veh:set_area(a)
		end
	end
end)
register_debug_event("basync:_debugDriveVehicle",function(player,id)
	local ped = basync.get_player_ped(player)
	local veh = basync.get_vehicle_from_player(id)
	if ped and veh then
		local limit = veh:get_seat_count() - 1
		ped:warp_out_of_vehicle()
		for i = 0,limit do
			if veh:set_seat(i,ped) then
				return
			end
		end
	end
end)

-- world events
register_debug_event("basync:_debugChapter",function(player,chapter)
	basync.set_chapter(chapter)
end)
register_debug_event("basync:_debugWeather",function(player,weather)
	basync.set_weather(weather)
end)
register_debug_event("basync:_debugTime",function(player,m)
	basync.set_time(math.floor(m/60),math.mod(m,60))
end)
register_debug_event("basync:_debugTimeRate",function(player,rate)
	basync.set_time_rate(rate)
end)
