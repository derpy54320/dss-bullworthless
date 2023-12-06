-- client api
basync = GetScriptNetworkTable()

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
function _G.PedGetNetworkId(real)
	return run(function(api)
		local ped = api.get_ped_from_ped(real)
		if ped then
			return ped:get_id()
		end
		return 0 -- invalid network id
	end)
end
function _G.PedFromNetworkId(id) -- name scheme inspired by VehicleFromDriver
	return run(function(api)
		local ped = api.get_ped_from_server(id)
		if ped then
			return ped:get_ped()
		end
		return -1
	end)
end
function _G.VehicleGetNetworkId(real)
	return run(function(api)
		local veh = api.get_vehicle_from_vehicle(real)
		if veh then
			return veh:get_id()
		end
		return 0 -- invalid network id
	end)
end
function _G.VehicleFromNetworkId(id)
	return run(function(api)
		local veh = api.get_vehicle_from_server(id)
		if veh then
			return veh:get_vehicle()
		end
		return -1
	end)
end
