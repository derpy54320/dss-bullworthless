-- basync module utility (load this into your module scripts)

-- globals
mt_ped = {__index = setmetatable({},{__newindex=function(t,k,v)
	local api = net.basync
	if api then
		if not api.set_ped_method(k,v) then
			PrintWarning("failed to register mt_ped.__index."..k)
		end
	end
	rawset(t,k,v)
end})}
mt_vehicle = {__index = setmetatable({},{__newindex=function(t,k,v)
	local api = net.basync
	if api then
		if not api.set_vehicle_method(k,v) then
			PrintWarning("failed to register mt_vehicle.__index."..k)
		end
	end
	rawset(t,k,v)
end})}

-- methods
local function init_peds()
	local api = net.basync
	if api then
		local set = api.set_ped_method
		for n,f in pairs(mt_ped.__index) do
			if not set(n,f) then
				PrintWarning("failed to register mt_ped.__index."..n)
			end
		end
	end
end
local function init_vehicles()
	local api = net.basync
	if api then
		local set = api.set_vehicle_method
		for n,f in pairs(mt_vehicle.__index) do
			if not set(n,f) then
				PrintWarning("failed to register mt_vehicle.__index."..n)
			end
		end
	end
end
RegisterLocalEventHandler("basync:initPeds",init_peds)
RegisterLocalEventHandler("basync:initVehicles",init_vehicles)

-- global api
local function pack(...)
	return arg
end
function run(cb) -- tail call this with the only argument being a function with your function's actual code
	local api = net.basync
	if api and pack then
		local results = pack(pcall(cb,api))
		if table.remove(results,1) then
			return unpack(results)
		end
		PrintError(results[1])
		error("an error occurred during a basync api call",3)
	end
	error("basync api function unavailable",3)
end
RegisterLocalEventHandler("ScriptShutdown",function(script)
	if script == GetCurrentScript() then
		pack = nil -- run checks for pack to know if this script is still running
	end
end)

-- default value (for server only)
local ped_fields = {}
local vehicle_fields = {}
function register_ped_field(name,default)
	local api = net.basync
	if api then
		for ped in api.all_peds() do
			ped.server[name] = default
		end
	end
	ped_fields[name] = default
end
function register_vehicle_field(name,default)
	local api = net.basync
	if api then
		for veh in api.all_vehicles() do
			veh.server[name] = default
		end
	end
	vehicle_fields[name] = default
end
RegisterLocalEventHandler("basync:initPed",function(ped)
	for name,default in pairs(ped_fields) do
		ped.server[name] = default
	end
end)
RegisterLocalEventHandler("basync:initVehicle",function(veh)
	for name,default in pairs(vehicle_fields) do
		veh.server[name] = default
	end
end)
RegisterLocalEventHandler("ScriptShutdown",function(script)
	local api = net.basync
	if api and script == GetCurrentScript() then
		for ped in api.all_peds() do
			for name in pairs(ped_fields) do
				ped.server[name] = nil
			end
		end
		for veh in api.all_vehicles() do
			for name in pairs(vehicle_fields) do
				veh.server[name] = nil
			end
		end
	end
end)
