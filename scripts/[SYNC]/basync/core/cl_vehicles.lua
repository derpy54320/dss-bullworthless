-- client vehicle sync
basync = GetScriptNetworkTable()
LoadScript("utility/models.lua")
LoadScript("utility/state.lua")

-- config
SYNC_ENTITIES = string.lower(GetConfigString(GetScriptConfig(),"sync_entities","off"))
VEH_POOL_TARGET = GetConfigNumber(GetScriptConfig(),"vehicle_pool_target",0)
VEH_SPAWN_DISTANCE = GetConfigNumber(GetScriptConfig(),"vehicle_spawn_distance",0) ^ 2
VEH_DESPAWN_DISTANCE = GetConfigNumber(GetScriptConfig(),"vehicle_despawn_distance",0) ^ 2
VEH_STATUS_DISTANCE = GetConfigNumber(GetScriptConfig(),"vehicle_physics_distance",-1) ^ 2
SLIDE_TIME_SECS = GetConfigNumber(GetScriptConfig(),"slide_time_ms",0) / 1000

-- globals
mt_vehicle = {__index = {}}
gMethodScripts = {}
gCreateCount = 0
gUnwanted = {}
gVehicles = {}
gVisible = {}

-- shared api
function basync.get_vehicle_from_vehicle(veh)
	if veh ~= -1 then
		for _,v in pairs(gVehicles) do
			if v.veh == veh then
				return v
			end
		end
	end
end
function basync.get_vehicle_from_server(id,pre)
	local veh = gVehicles[id]
	if veh and (pre or veh.state) then
		return veh
	end
end
function basync.all_vehicles()
	local id,veh
	return function()
		id,veh = next(gVehicles,id)
		while id do
			if veh.state then
				return veh
			end
			id,veh = next(gVehicles,id)
		end
	end
end

-- debug stuff
function basync.get_vehicles_created()
	return gCreateCount
end

-- register method
function basync.set_vehicle_method(name,func)
	if type(name) ~= "string" or type(func) ~= "function" then
		error("invalid method",2)
	elseif not mt_vehicle.__index[name] then
		local script = GetCurrentScript()
		local methods = gMethodScripts[script]
		if methods then
			table.insert(methods,name)
		else
			gMethodScripts[script] = {name,n = 1} -- save all methods registered by this script so they can be removed when the script is destroyed
		end
		mt_vehicle.__index[name] = func
		return true
	end
	return false
end

-- vehicle objects
function create_vehicle(id)
	return setmetatable({
		-- .state is *ONLY* set on first update
		-- .server is *ONLY* set when state is set (and it is set to state.server)
		id = id,
		veh = -1, -- the vehicle is *ONLY* created when the vehicle has state
		created = false, -- if the vehicle *should* exist
		deleted = false, -- if the vehicle was deleted while owned (makes the vehicle unable to be created again)
		respawning = false, -- if the vehicle needs to be re-created
		netbasics = false, -- if the stuff in "set_vehicle_basics" was applied
		position = {0,0,0,0}, -- smooth position {x,y,z,h}
	},mt_vehicle)
end
function basync.validate_vehicle(veh,level)
	if type(veh) ~= "table" or getmetatable(veh) ~= mt_vehicle or gVehicles[veh.id] ~= veh or not veh.state then
		if type(level) == "number" then
			error("invalid vehicle",level+1)
		end
		error("invalid vehicle")
	end
end
function mt_vehicle:__tostring()
	if gVehicles[self.id] == self then
		return "vehicle: "..tostring(self.id)
	end
	return "invalid vehicle"
end
function mt_vehicle.__index:delete() -- deletes the vehicle handle if valid, NOT the network object
	basync.validate_vehicle(self,2)
	if self.veh ~= -1 then
		if VehicleIsValid(self.veh) then
			for ped in AllPeds() do
				if PedIsInVehicle(ped,self.veh) then
					PedWarpOutOfCar(ped) -- it's okay to use this with bikes since we're deleting the vehicle anyway
				end
			end
			VehicleDelete(self.veh)
		end
		set_vehicle(self,-1)
	end
end
function mt_vehicle.__index:respawn() -- mark the vehicle for respawn
	basync.validate_vehicle(self,2)
	self.respawning = true
end
function mt_vehicle.__index:is_valid(pre)
	if type(self) ~= "table" or getmetatable(self) ~= mt_vehicle then
		error("expected vehicle object",2)
	end
	return (pre or self.state) and gVehicles[self.id] == self
end
function mt_vehicle.__index:is_owner()
	basync.validate_vehicle(self,2)
	return self.state:is_owner()
end
function mt_vehicle.__index:get_vehicle()
	basync.validate_vehicle(self,2)
	if VehicleIsValid(self.veh) then
		return self.veh
	end
	return -1
end
function mt_vehicle.__index:get_id()
	basync.validate_vehicle(self,2)
	return self.id
end
function mt_vehicle.__index:get_name()
	basync.validate_vehicle(self,2)
	return self.server.name
end
function mt_vehicle.__index:get_model()
	basync.validate_vehicle(self,2)
	return self.server.model
end
function mt_vehicle.__index:get_area()
	basync.validate_vehicle(self,2)
	return self.server.area
end
function mt_vehicle.__index:get_position()
	basync.validate_vehicle(self,2)
	return unpack(self.server.pos)
end

-- server vehicle events
RegisterNetworkEventHandler("basync:_createVehicle",function(id)
	if gVehicles[id] then
		error("a vehicle with that network id already exists",2)
	end
	gVehicles[id] = create_vehicle(id)
end)
RegisterNetworkEventHandler("basync:_deleteVehicle",function(id)
	local veh = gVehicles[id]
	if veh then
		RunLocalEvent("basync:deletingVehicle",veh)
		veh:delete()
		gVehicles[id] = nil
		RunLocalEvent("basync:deletedVehicle",veh)
	end
end)
RegisterNetworkEventHandler("basync:_undeleteVehicle",function(id)
	local veh = gVehicles[id]
	if veh then
		veh.deleted = false
	end
end)
RegisterNetworkEventHandler("basync:_updateVehicles",function(all_vehicle_changes)
	local updated = {}
	for _,v in ipairs(all_vehicle_changes) do
		local id,changes,updates,full = unpack(v)
		local veh = gVehicles[id]
		if veh then
			if not veh.state then
				veh.state = create_client_state({})
				veh.server = veh.state.server
			end
			veh.state:apply_changes(changes,updates,full)
			if updates and next(updates) and veh.state:is_owner() then
				updated[id] = updates
			end
		else
			PrintWarning("tried to update non-existant vehicle: "..id)
		end
	end
	if next(updated) then
		SendNetworkEvent("basync:_updatedVehicles",updated)
	end
end)

-- main / cleanup
CreateAdvancedThread("PRE_GAME",function() -- runs pre-game so updates are applied before other scripts run
	if SYNC_ENTITIES == "off" then
		return
	end
	while not SystemIsReady() do
		Wait(0)
	end
	AreaClearAllVehicles()
	while true do
		if SYNC_ENTITIES == "full" then
			hide_vehicles()
		end
		validate_vehicles()
		update_visible()
		update_vehicles()
		Wait(0)
	end
end)
function MissionCleanup()
	for _,veh in pairs(gVehicles) do
		veh:delete()
	end
end

-- hide unwanted vehicles
function hide_vehicles()
	local vehicles = VehicleFindInAreaXYZ(0,0,0,9999)
	if vehicles then
		for _,veh in ipairs(vehicles) do
			if gUnwanted[veh] == nil and should_hide_vehicle(veh) then
				gUnwanted[veh] = RunLocalEvent("basync:hideVehicle",veh)
				gCreateCount = gCreateCount + 1
			end
		end
	end
	for veh,hide in pairs(gUnwanted) do
		if not VehicleIsValid(veh) then
			gUnwanted[veh] = nil
		elseif hide then
			VehicleSetPosXYZ(veh,0,0,0)
		end
	end
end
function should_hide_vehicle(veh)
	for _,v in pairs(gVehicles) do
		if v.veh == veh then
			return false
		end
	end
	return true
end

-- validate / create vehicles
function validate_vehicles()
	local count,vehs = 0,{}
	local space = VEH_POOL_TARGET - GetPoolUsage("VEHICLE")
	local area,x1,y1,z1 = AreaGetVisible(),PlayerGetPosXYZ()
	for _,veh in pairs(gVehicles) do
		if veh.deleted and not veh.state:is_owner() then
			veh.deleted = false -- we don't own them anymore so just forget it
		end
		if veh.state and not veh.deleted then
			local x2,y2,z2 = unpack(veh.server.pos)
			local dx,dy,dz = x2-x1,y2-y1,z2-z1
			if VehicleIsValid(veh.veh) then
				space = space + 1
			else
				set_vehicle(veh,-1) -- get rid of invalid vehicle handle
				if veh.created and veh.state:is_owner() then
					SendNetworkEvent("basync:_deleteVehicle",veh.id)
					veh.created = false
					veh.deleted = true
				end
			end
			if not veh.deleted then
				local dist = dx*dx+dy*dy+dz*dz
				count = count + 1
				if dist < VEH_DESPAWN_DISTANCE then
					vehs[count] = {veh,area == veh.server.area,dist}
				else
					vehs[count] = {veh,false,dist} -- act like the vehicle isn't even in this area since they're so far
				end
			end
		end
	end
	table.sort(vehs,sort_vehicles)
	for i = math.min(count,space),1,-1 do
		if not vehs[i][2] then
			space = i - 1 -- don't include vehicles that are not in this area
			break
		end
	end
	for i = math.max(1,space+1),count do
		local veh = vehs[i][1]
		veh:delete() -- not enough space for these far away vehicles
		veh.created = false
	end
	space = math.min(count,space)
	for i = 1,space do
		local veh = vehs[i][1]
		if veh.respawning then
			veh:delete()
			veh.respawning = false
		elseif VehicleIsValid(veh.veh) and not VehicleIsModel(veh.veh,veh.server.model) and (not veh.state:is_owner() or veh.state:was_updated("model")) then
			veh:delete() -- delete vehicle so a new one can be made with the correct model
		end
		if not VehicleIsValid(veh.veh) and vehs[i][3] < VEH_SPAWN_DISTANCE then
			local x,y,z = unpack(veh.server.pos)
			local real = VehicleCreateXYZ(veh.server.model,x,y,z) -- create the closest vehicles that there is space for
			gCreateCount = gCreateCount + 1
			if real == -1 then
				real = VehicleCreateXYZ(veh.server.model,0,0,0) -- vehicles don't spawn if the spawn point is crowded so we'll try 0, 0, 0 too
				if real == -1 then
					gCreateCount = gCreateCount - 1
				end
			end
			if VehicleIsValid(real) then
				VehicleSetStatic(real,false)
				veh.state:apply_changes({},nil,true) -- force a full update
				set_vehicle(veh,real)
			else
				set_vehicle(veh,-1)
			end
		end
		veh.created = true
	end
end
function set_vehicle(veh,real)
	if veh.veh ~= real then
		veh.veh = real
		RunLocalEvent("basync:assignVehicle",veh,real)
	end
end
function sort_vehicles(a,b)
	if a[2] ~= b[2] then
		return a[2] -- put vehicles in the current area first
	end
	return a[3] < b[3]
end

-- update visible vehicles
function update_visible()
	local count,visible = 0,{}
	for _,veh in pairs(gVehicles) do
		if VehicleIsValid(veh.veh) then
			count = count + 1
			visible[count] = veh.id
		end
	end
	table.sort(visible)
	if count ~= gVisible.n or is_dif_visible(visible) then
		SendNetworkEvent("basync:_visibleVehicles",visible)
		visible.n = count
		gVisible = visible
	end
end
function is_dif_visible(visible)
	for i,v in ipairs(gVisible) do
		if v ~= visible[i] then
			return true
		end
	end
	return false
end

-- update state (server -> client)
function update_vehicles()
	for _,veh in pairs(gVehicles) do
		if veh.state then
			if VehicleIsValid(veh.veh) then
				local off = set_vehicle_basics(veh)
				set_vehicle_pos(veh)
				RunLocalEvent("basync:setVehicle",veh)
				if off then
					veh.netbasics = false
				end
			end
			veh.state:reset_updated()
		end
	end
end
function set_vehicle_basics(veh)
	if VEH_STATUS_DISTANCE ~= -1 then
		local x1,y1,z1 = PlayerGetPosXYZ()
		local x2,y2,z2 = VehicleGetPosXYZ(veh.veh)
		local dx,dy,dz = x2-x1,y2-y1,z2-z1
		if dx*dx+dy*dy+dz*dz < VEH_STATUS_DISTANCE or PlayerIsInVehicle(veh.veh) then
			VehicleSetStatus(veh.veh,0)
		else
			VehicleSetStatus(veh.veh,2)
		end
	end
	if not veh.state:is_owner() then
		veh.netbasics = true
	elseif veh.netbasics then
		return true
	end
	return false
end
function set_vehicle_pos(veh)
	local pos = veh.position
	local updated = veh.state:was_updated("pos")
	if updated or not veh.state:is_owner() then
		local x1,y1,z1,h1 = unpack(pos)
		local x2,y2,z2,h2 = unpack(veh.server.pos)
		if not updated then
			local amount = GetFrameTime() / SLIDE_TIME_SECS
			local dx,dy,dz,dh = x2-x1,y2-y1,z2-z1,math.mod(h2-h1,360)
			while dh <= -180 do
				dh = dh + 360
			end
			while dh > 180 do
				dh = dh - 360
			end
			x2,y2,z2,h2 = x1+dx*amount,y1+dy*amount,z1+dz*amount,h1+dh*amount
		end
		VehicleSetPosXYZ(veh.veh,x2,y2,z2)
		VehicleFaceHeading(veh.veh,h2)
		pos[1],pos[2],pos[3],pos[4] = x2,y2,z2,h2
	else
		pos[1],pos[2],pos[3],pos[4] = unpack(veh.server.pos) -- we own the vehicle so just match the smooth position
	end
end

-- update state (client -> server)
RegisterLocalEventHandler("basync:_updateServer",function()
	local all_changes = {}
	for id,veh in pairs(gVehicles) do
		if VehicleIsValid(veh.veh) and veh.state:is_owner() then
			local state = {}
			state.model = VehicleGetModelId(veh.veh)
			state.area = get_vehicle_area(veh)
			state.pos = get_vehicle_pos(veh)
			RunLocalEvent("basync:getVehicle",veh,state)
			all_changes[id] = veh.state:update_server(state)
		end
	end
	if next(all_changes) then
		SendNetworkEvent("basync:_updateVehicles",all_changes)
	end
end)
function get_vehicle_area(veh)
	if PlayerIsInVehicle(veh.veh) then
		return AreaGetVisible()
	end
end
function get_vehicle_pos(veh)
	local x,y,z = VehicleGetPosXYZ(veh.veh)
	if PlayerIsInVehicle(veh.veh) then
		return {x,y,z,math.deg(PedGetHeading(gPlayer))}
	end
	return {x,y,z,veh.server.pos[4]}
end

-- cleanup
RegisterLocalEventHandler("ScriptShutdown",function(script)
	local methods = gMethodScripts[script]
	if methods then
		for _,name in ipairs(methods) do
			mt_vehicle.__index[name] = nil
		end
		gMethodScripts[script] = nil
	end
	if script == GetCurrentScript() then
		gVehicles = {}
	end
end)

-- init
RunLocalEvent("basync:initVehicles")
