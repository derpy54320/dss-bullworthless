-- server api
LoadScript("utility/models.lua")

-- utility
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
	error("basync is not running",3)
end
function pack(...)
	return arg
end
GetScriptSharedTable(true).run_api = run

-- peds [core]
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
		ped:set_position(x,y,z,h)
		return ped
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
function _G.PedInRectangle(ped,lx,ly,hx,hy)
	return run(function()
		local x,y = ped:get_position()
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
function _G.PedGetHeading(ped) -- radians, just like the client version
	return run(function()
		local x,y,z,h = ped:get_position()
		return math.rad(h)
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
function _G.PedPutOnBike(ped,veh)
	return run(function()
		ped:warp_into_vehicle(ped,veh)
	end)
end
function _G.PedWarpIntoCar(ped,veh,seat)
	return run(function()
		ped:warp_into_vehicle(ped,veh,seat)
	end)
end
function _G.PedWarpOutOfCar()
	return run(function()
		ped:warp_out_of_vehicle()
	end)
end

-- peds [actions]

-- peds [ai]

-- peds [flag]

-- peds [punishment]

-- peds [speech]

-- peds [stats]

-- peds [target]

-- peds [throttle]

-- vehicles [core]
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
function _G.VehicleIsInAreaXYZ(veh,x1,y1,z1,range)
	return run(function()
		local x2,y2,z2 = veh:get_position()
		local dx,dy,dz = x2-x1,y2-y1,z2-z1
		return dx*dx+dy*dy+dz*dz < range*range
	end)
end
function _G.VehicleGetHeading(veh) -- radians, just like the client version
	return run(function()
		local x,y,z,h = veh:get_position()
		return math.rad(h)
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
		return 60000/api.get_time_rate()
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
function _G.ClockSetTickRate(min_per_sec)
	return run(function(api)
		return api.set_time_rate(hour,60000/min_per_sec)
	end)
end
