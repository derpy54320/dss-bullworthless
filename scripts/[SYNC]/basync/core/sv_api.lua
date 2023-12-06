-- server api
basync = GetScriptNetworkTable()
LoadScript("utility/models.lua")

-- utility
function pack(...)
	return arg
end
function run(cb)
	local api = net.basync
	if api then
		local results = pack(pcall(cb,api))
		if table.remove(results,1) then
			return unpack(results)
		end
		PrintError(results[1])
		error("an error occurred during a basync api call",3)
	end
	error("basync api function unavailable",3)
end

-- network
function _G.PedGetNetworkId(ped)
	return run(function()
		return ped:get_id()
	end)
end
function _G.PedFromNetworkId(id) -- name scheme inspired by VehicleFromDriver
	return run(function(api)
		return api.get_ped_from_player(id)
	end)
end
function _G.VehicleGetNetworkId(veh)
	return run(function()
		return veh:get_id()
	end)
end
function _G.VehicleFromNetworkId(id)
	return run(function(api)
		return api.get_vehicle_from_player(id)
	end)
end

-- peds
function _G.AllPeds() -- iterator (for loops)
	return run(function(api)
		return api.all_peds()
	end)
end
function _G.PedFindInAreaXYZ(x1,y1,z1,range) -- returns a boolean then results just like the client version
	range = range * range
	return run(function(api)
		local count,peds = 0,{}
		for ped in api.all_peds() do
			local x2,y2,z2 = ped:get_position()
			local dx,dy,dz = x2-x1,y2-y1,z2-z1
			if dx*dx+dy*dy+dz*dz < range then
				count = count + 1
				peds[count] = ped
			end
		end
		if count == 0 then
			return false
		end
		return true,unpack(peds)
	end)
end
function _G.PedCreateXYZ(model,x,y,z,h) -- still make sure to set area if needed!!!
	return run(function(api)
		local ped = api.create_ped(model)
		if x ~= nil then
			ped:set_position(x,y,z,h)
		end
		return ped
	end)
end
function _G.PedFromPlayer(player)
	return run(function(api)
		return api.get_player_ped(player)
	end)
end
function _G.PedDelete(ped)
	return run(function()
		ped:delete()
	end)
end
function _G.PedIsValid(ped)
	return run(function(api)
		return api.is_ped_valid(ped)
	end)
end
function _G.PedIsPlayer(ped)
	return run(function()
		return ped:is_player()
	end)
end
function _G.PedGetOwner(ped)
	return run(function()
		return ped:get_owner()
	end)
end
function _G.PedGetName(ped)
	return run(function()
		return ped:get_name()
	end)
end
function _G.PedGetModelId(ped)
	return run(function()
		return ped:get_model()
	end)
end
function _G.PedIsModel(ped,model)
	return run(function()
		return ped:get_model() == model
	end)
end
function _G.PedGetArea(ped)
	return run(function()
		return ped:get_area()
	end)
end
function _G.PedGetPosXYZ(ped)
	return run(function()
		local x,y,z = ped:get_position()
		return x,y,z
	end)
end
function _G.PedGetHeading(ped) -- radians, just like the client version
	return run(function()
		local x,y,z,h = ped:get_position()
		return math.rad(h)
	end)
end
function _G.PedInRectangle(ped,lx,ly,hx,hy)
	return run(function()
		local x,y = ped:get_position()
		if hx < lx then
			lx,hx = hx,lx
		end
		if hy < ly then
			ly,hy = hy,ly
		end
		return x >= lx and y >= ly and x < hx and y < hy
	end)
end
function _G.PedIsInAreaXYZ(ped,x1,y1,z1,range)
	return run(function()
		local x2,y2,z2 = ped:get_position()
		local dx,dy,dz = x2-x1,y2-y1,z2-z1
		return dx*dx+dy*dy+dz*dz < range*range
	end)
end
function _G.PedGetLastVehicle(ped)
	return run(function()
		return ped:get_last_vehicle()
	end)
end
function _G.PedIsInAnyVehicle(ped)
	return run(function()
		return ped:get_vehicle() ~= nil
	end)
end
function _G.PedIsInVehicle(ped,veh)
	return run(function()
		return ped:get_vehicle() == veh
	end)
end
function _G.PedSetOwner(ped,player,locked) -- returns if the owner was set successfully
	return run(function()
		if locked then
			ped:lock_owner()
		else
			ped:unlock_owner()
		end
		return ped:set_owner(player)
	end)
end
function _G.PedSetName(ped,name)
	return run(function()
		ped:set_name(name)
	end)
end
function _G.PedSwapModel(ped,name)
	return run(function()
		if type(name) == "string" then
			name = string.lower(name)
			for m,v in pairs(PED_MODELS) do
				if string.lower(v) == name then
					ped:set_model(m)
					return
				end
			end
			error("invalid ped model")
		end
		ped:set_model(name)
	end)
end
function _G.PedSetArea(ped,area)
	return run(function()
		ped:set_area(area)
	end)
end
function _G.PedSetPosXYZ(ped,x,y,z)
	return run(function()
		ped:set_position(x,y,z)
	end)
end
function _G.PedFaceHeading(ped,h) -- degrees, just like the client version
	return run(function()
		local x,y,z = ped:get_position()
		ped:set_position(x,y,z,h)
	end)
end
function _G.PedFaceObject(ped,target)
	return run(function(api)
		local x1,y1,z1 = ped:get_position()
		local x2,y2,z2 = target:get_position()
		ped:set_position(x1,y1,z1,math.deg(math.atan2(x1-x2,y2-y1)))
	end)
end
function _G.PedFaceXYZ(ped,x2,y2,z2)
	return run(function(api)
		local x1,y1,z1 = ped:get_position()
		ped:set_position(x1,y1,z1,math.deg(math.atan2(x1-x2,y2-y1)))
	end)
end
function _G.PedPutOnBike(ped,veh)
	return run(function()
		ped:warp_into_vehicle(veh)
	end)
end
function _G.PedWarpIntoCar(ped,veh,seat)
	return run(function()
		ped:warp_into_vehicle(veh,seat)
	end)
end
function _G.PedWarpOutOfCar()
	return run(function()
		ped:warp_out_of_vehicle()
	end)
end

-- vehicles
function _G.AllVehicles() -- iterator (for loops)
	return run(function(api)
		return api.all_vehicles()
	end)
end
function _G.VehicleFindInAreaXYZ(x1,y1,z1,range) -- returns a table if there are vehicles in the area
	range = range * range
	return run(function(api)
		local count,vehs = 0,{}
		for veh in api.all_vehicles() do
			local x2,y2,z2 = veh:get_position()
			local dx,dy,dz = x2-x1,y2-y1,z2-z1
			if dx*dx+dy*dy+dz*dz < range then
				count = count + 1
				vehs[count] = veh
			end
		end
		if count ~= 0 then
			return vehs
		end
	end)
end
function _G.VehicleCreateXYZ(model,x,y,z,h) -- still make sure to set area if needed!!!
	return run(function(api)
		local veh = api.create_vehicle(model)
		veh:set_position(x,y,z,h)
		return veh
	end)
end
function _G.VehicleFromDriver(ped)
	return run(function()
		return ped:get_vehicle()
	end)
end
function _G.VehicleDelete(veh)
	return run(function()
		veh:delete()
	end)
end
function _G.VehicleIsValid(veh)
	return run(function(api)
		return api.is_vehicle_valid(veh)
	end)
end
function _G.VehicleGetOwner(veh)
	return run(function()
		return veh:get_owner()
	end)
end
function _G.VehicleGetName(veh)
	return run(function()
		return veh:get_name()
	end)
end
function _G.VehicleGetModelId(veh)
	return run(function()
		return veh:get_model()
	end)
end
function _G.VehicleIsModel(ped,model)
	return run(function()
		return veh:get_model() == model
	end)
end
function _G.VehicleGetArea(veh)
	return run(function()
		return veh:get_area()
	end)
end
function _G.VehicleGetPosXYZ(veh)
	return run(function()
		local x,y,z = veh:get_position()
		return x,y,z
	end)
end
function _G.VehicleGetHeading(veh) -- radians, just like the client version
	return run(function()
		local x,y,z,h = veh:get_position()
		return math.rad(h)
	end)
end
function _G.VehicleIsInAreaXYZ(veh,x1,y1,z1,range)
	return run(function()
		local x2,y2,z2 = veh:get_position()
		local dx,dy,dz = x2-x1,y2-y1,z2-z1
		return dx*dx+dy*dy+dz*dz < range*range
	end)
end
function _G.VehicleSetOwner(veh,player,locked) -- returns if the owner was set successfully
	return run(function()
		if locked then
			veh:lock_owner()
		else
			veh:unlock_owner()
		end
		return veh:set_owner(player)
	end)
end
function _G.VehicleSetName(veh,name)
	return run(function()
		veh:set_name(name)
	end)
end
function _G.VehicleSetArea(veh,area)
	return run(function()
		veh:set_area(area)
	end)
end
function _G.VehicleSetPosXYZ(veh,x,y,z)
	return run(function()
		veh:set_position(x,y,z)
	end)
end
function _G.VehicleFaceHeading(veh,h) -- degrees, just like the client version
	return run(function()
		local x,y,z = veh:get_position()
		veh:set_position(x,y,z,h)
	end)
end

-- world
function _G.ChapterGet()
	return run(function(api)
		return api.get_chapter()
	end)
end
function _G.WeatherGet()
	return run(function(api)
		return api.get_weather()
	end)
end
function _G.ClockGet()
	return run(function(api)
		return api.get_time()
	end)
end
function _G.ClockGetTickRate()
	return run(function(api)
		local rate = api.get_time_rate()
		if rate == 0 then
			return 0
		end
		return 60000 / rate
	end)
end
function _G.ChapterSet(chapter)
	return run(function(api)
		return api.set_chapter(chapter)
	end)
end
function _G.WeatherSet(weather)
	return run(function(api)
		return api.set_weather(weather)
	end)
end
function _G.ClockSet(hour,minute)
	return run(function(api)
		return api.set_time(hour,minute)
	end)
end
function _G.ClockSetTickRate(rate)
	return run(function(api)
		if rate == 0 then
			return api.set_time_rate(0)
		end
		return api.set_time_rate(60000/rate)
	end)
end

-- utility
function _G.DistanceBetweenCoords2d(x1,y1,x2,y2)
	return run(function()
		local dx,dy = x2-x1,y2-y1
		return math.sqrt(dx*dx+dy*dy)
	end)
end
function _G.DistanceBetweenCoords3d(x1,y1,z1,x2,y2,z2)
	return run(function()
		local dx,dy,dz = x2-x1,y2-y1,z2-z1
		return math.sqrt(dx*dx+dy*dy+dz*dz)
	end)
end
function _G.DistanceBetweenPeds2D(ped1,ped2) -- casing is intentionally inconsistent with DistanceBetweenCoords2d because that's how the game does it
	return run(function()
		local x1,y1 = ped1:get_position()
		local x2,y2 = ped2:get_position()
		local dx,dy = x2-x1,y2-y1
		return math.sqrt(dx*dx+dy*dy)
	end)
end
function _G.DistanceBetweenPeds3D(ped1,ped2)
	return run(function()
		local x1,y1,z1 = ped1:get_position()
		local x2,y2,z2 = ped2:get_position()
		local dx,dy,dz = x2-x1,y2-y1,z2-z1
		return math.sqrt(dx*dx+dy*dy+dz*dz)
	end)
end
