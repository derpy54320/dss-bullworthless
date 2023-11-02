-- client vehicle sync
basync = GetScriptNetworkTable()
LoadScript("utility/debug.lua")
LoadScript("utility/models.lua")
LoadScript("utility/modules.lua")
LoadScript("utility/state.lua")

-- config
SLIDE_TIME_SECS = GetConfigNumber(GetScriptConfig(),"slide_time_ms",0) / 1000
VEH_POOL_TARGET = GetConfigNumber(GetScriptConfig(),"vehicle_pool_target",0)
VEH_SPAWN_DISTANCE = GetConfigNumber(GetScriptConfig(),"vehicle_spawn_distance",0) ^ 2
VEH_DESPAWN_DISTANCE = GetConfigNumber(GetScriptConfig(),"vehicle_despawn_distance",0) ^ 2

-- globals
mt_vehicle = {__index = {}}
gVehicles = {}
gUnwanted = {}
gVisible = {}

-- load modules
load_modules("veh_",mt_vehicle.__index,mt_vehicle.__index,{})

-- shared api
function basync.get_vehicle_by_vehicle(veh)
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

-- vehicle objects
function create_vehicle(id)
	return setmetatable({
		-- .state is *ONLY* set on first update
		-- .server is *ONLY* set when state is set (and it is set to state.server)
		id = id,
		veh = -1, -- the vehicle is *ONLY* created when the vehicle has state
		created = false, -- if the vehicle *should* exist
		deleted = false, -- if the vehicle was deleted while owned (makes the vehicle unable to be created again)
		position = {0,0,0,0}, -- smooth position {x,y,z,h}
		netbasics = false, -- if the stuff in "set_veh_basics" was applied
	},mt_vehicle)
end
function validate_vehicle(veh,level)
	if type(veh) ~= "table" or getmetatable(veh) ~= mt_vehicle or gVehicles[veh.id] ~= veh or not veh.state then
		error("invalid vehicle",level+1)
	end
end
function mt_vehicle.__index:delete() -- delete's the vehicle handle if valid, NOT the network object
	validate_vehicle(self,2)
	if self.veh ~= -1 then
		if VehicleIsValid(self.veh) then
			for ped in AllPeds() do
				if PedIsInVehicle(ped,self.veh) then
					PedWarpOutOfCar(ped)
				end
			end
			VehicleDelete(self.veh)
		end
		self.veh = -1
	end
end
function mt_vehicle.__index:is_valid(pre)
	if type(self) ~= "table" or getmetatable(self) ~= mt_vehicle then
		error("expected vehicle object",2)
	end
	return (pre or self.state) and gVehicles[self.id] == self
end
function mt_vehicle.__index:is_owner()
	validate_vehicle(self,2)
	return self.state:is_owner()
end
function mt_vehicle.__index:get_vehicle()
	validate_vehicle(self,2)
	if VehicleIsValid(self.veh) then
		return self.veh
	end
	return -1
end
function mt_vehicle.__index:get_id()
	validate_vehicle(self,2)
	return self.id
end
function mt_vehicle.__index:get_name()
	validate_vehicle(self,2)
	return self.server.name
end
function mt_vehicle.__index:get_model()
	validate_vehicle(self,2)
	return self.server.model
end
function mt_vehicle.__index:get_area()
	validate_vehicle(self,2)
	return self.server.area
end
function mt_vehicle.__index:get_position()
	validate_vehicle(self,2)
	return unpack(self.server.pos)
end

-- server vehicle events
RegisterNetworkEventHandler("basync:createVehicle",function(id)
	if gVehicles[id] then
		error("a vehicle with that network id already exists",2)
	end
	gVehicles[id] = create_vehicle(id)
end)
RegisterNetworkEventHandler("basync:deleteVehicle",function(id)
	local veh = gVehicles[id]
	if veh then
		veh:delete()
		gVehicles[id] = nil
	end
end)
RegisterNetworkEventHandler("basync:undeleteVehicle",function(id)
	local veh = gVehicles[id]
	if veh then
		veh.deleted = false
	end
end)
RegisterNetworkEventHandler("basync:updateVehicles",function(all_vehicle_changes)
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
		SendNetworkEvent("basync:updatedVehicles",updated)
	end
end)

-- main / cleanup
function main()
	while not SystemIsReady() do
		Wait(0)
	end
	AreaClearAllVehicles()
	while true do
		hide_vehicles()
		validate_vehicles()
		update_visible()
		update_vehicles()
		Wait(0)
	end
end
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
				veh.veh = -1 -- get rid of invalid vehicle handle
				if veh.created and veh.state:is_owner() then
					SendNetworkEvent("basync:deleteVehicle",veh.id)
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
		if VehicleIsValid(veh.veh) and not VehicleIsModel(veh.veh,veh.server.model) and (not veh.state:is_owner() or veh.state:was_updated("model")) then
			veh:delete() -- delete vehicle so a new one can be made with the correct model
		end
		if not VehicleIsValid(veh.veh) and vehs[i][3] < VEH_SPAWN_DISTANCE then
			local x,y,z = unpack(veh.server.pos)
			veh.veh = VehicleCreateXYZ(veh.server.model,x,y,z) -- create the closest vehicles that there is space for
			if VehicleIsValid(veh.veh) then
				VehicleSetStatic(veh.veh,false)
				VehicleSetStatus(veh.veh,0)
			end
			veh.state:apply_changes({},nil,true) -- force a full update
		end
		veh.created = true
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
		SendNetworkEvent("basync:visibleVehicles",visible)
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
				set_vehicle_basics(veh)
				set_vehicle_pos(veh)
				for k,v in pairs(gModules) do
					if v.set then
						local s,m = pcall(v.set,veh,veh.server[k])
						if not s then
							PrintError(m)
						end
					end
				end
			end
			veh.state:reset_updated()
		end
	end
end
function set_vehicle_basics(veh)
	if not veh.state:is_owner() then
		veh.netbasics = true
	elseif veh.netbasics then
		veh.netbasics = false
	end
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
RegisterLocalEventHandler("basync:updateServer",function()
	local all_changes = {}
	for id,veh in pairs(gVehicles) do
		if VehicleIsValid(veh.veh) and veh.state:is_owner() then
			local state = {}
			state.model = VehicleGetModelId(veh.veh)
			state.area = get_vehicle_area(veh)
			state.pos = get_vehicle_pos(veh)
			for k,v in pairs(gModules) do
				if v.get then
					local s,m = pcall(v.get,veh)
					if s then
						state[k] = m
					else
						PrintError(m)
					end
				end
			end
			all_changes[id] = veh.state:update_server(state)
		end
	end
	if next(all_changes) then
		SendNetworkEvent("basync:updateVehicles",all_changes)
	end
end)
function get_vehicle_area(veh)
	if PlayerIsInVehicle(veh.veh) then
		return AreaGetVisible()
	end
	return veh.server.area
end
function get_vehicle_pos(veh)
	local x,y,z = VehicleGetPosXYZ(veh.veh)
	if PlayerIsInVehicle(veh.veh) then
		return {x,y,z,math.deg(PedGetHeading(gPlayer))}
	end
	return {x,y,z,veh.server.pos[4]}
end

-- debug cutoff
if not GetConfigBoolean(GetScriptConfig(),"allow_debug",false) then
	return
end

-- debug menu
function basync.run_vehicle_menu()
	local menu = net.menu.create("Basync Vehicles","Re-open this menu to show new vehicles.")
	local vehs = {}
	for _,veh in pairs(gVehicles) do
		table.insert(vehs,veh)
	end
	table.sort(vehs,function(a,b)
		return a.id < b.id
	end)
	while menu:active() do
		for _,veh in ipairs(vehs) do
			if veh:is_valid() then
				local name
				if veh.state then
					name = veh.server.name
				else
					name = "uninitialized vehicle"
				end
				if menu:option(name,"["..veh.id.."]") then
					specific_vehicle_menu(veh.id,veh,name)
					break
				end
			end
		end
		menu:draw()
		Wait(0)
	end
end
function basync.spawn_vehicle_menu()
	local menu = net.menu.create("Spawn Basync Vehicle")
	while menu:active() do
		for i = 272,298 do
			local model = VEHICLE_MODELS[i]
			if model and menu:option(model) then
				local h,x,y,z = PedGetHeading(gPlayer),PlayerGetPosXYZ()
				SendNetworkEvent("basync:spawnVehicle",i,AreaGetVisible(),x-math.sin(h),y+math.cos(h),z,math.deg(h))
				break
			end
		end
		menu:draw()
		Wait(0)
	end
end
function specific_vehicle_menu(id,veh,name)
	local menu = net.menu.create("["..id.."] "..name)
	while menu:active() and gVehicles[id] == veh do
		if menu:option("Show Full Server Data") then
			SendNetworkEvent("basync:debugVehicle",id)
		elseif menu:option("Show Full Client Data") then
			local backup = veh.server
			veh.server = nil
			basync.draw_debug_string("gVehicles["..id.."] = "..get_debug_string(veh))
			veh.server = backup
		elseif menu:option("Teleport To Vehicle") and not AreaIsLoading() then
			if veh.state then
				local dist = -0.5
				local a,x,y,z,h = veh.server.area,unpack(veh.server.pos)
				x = x - dist * math.sin(h)
				y = y + dist * math.cos(h)
				CameraFade(0,0)
				PlayerSetPosXYZArea(x,y,z,a)
				AreaDisableCameraControlForTransition(true)
				while AreaIsLoading() do
					menu:draw(true)
					Wait(0)
				end
				AreaDisableCameraControlForTransition(false)
				PedFaceHeading(gPlayer,h)
				CameraFade(500,1)
			else
				menu:alert("Vehicle position unknown.",3)
			end
		elseif menu:option("Warp Into Vehicle") then
			if VehicleIsValid(veh.veh) then
				PedWarpIntoCar(gPlayer,veh.veh,0)
			end
		elseif menu:option("Delete Local Vehicle","["..veh.veh.."]") then
			veh:delete()
		end
		menu:help("owner: "..tostring(veh.state:is_owner()))
		menu:draw()
		Wait(0)
	end
end

-- debug events
RegisterNetworkEventHandler("basync:debugVehicle",function(str)
	if str then
		basync.draw_debug_string(str)
	else
		PrintWarning("Failed to show server data because the network id wasn't a valid vehicle.")
	end
end)
