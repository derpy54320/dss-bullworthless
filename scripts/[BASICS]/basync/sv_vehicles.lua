-- server vehicle sync
basync = GetScriptNetworkTable()
shared = GetScriptSharedTable(true)
LoadScript("utility/cleanup.lua")
LoadScript("utility/debug.lua")
LoadScript("utility/models.lua")
LoadScript("utility/modules.lua")
LoadScript("utility/state.lua")

-- config
REASSIGN_DIST = 5
ALLOW_PASSENGERS = GetConfigBoolean(GetScriptConfig(),"allow_passengers",false)

-- globals
mt_vehicle = {__index = {}}
gVehicles = {}
gPlayers = {}

-- load modules
load_modules("veh_",true,mt_vehicle.__index)

-- shared api
function basync.is_vehicle_valid(veh)
	return type(veh) == "table" and getmetatable(veh) == mt_vehicle and gVehicles[veh.id] == veh
end
function basync.get_vehicle_from_player(player,id)
	local veh = shared.get_net_id(player,id)
	if veh and veh == gVehicles[id] then
		return veh
	end
end
function basync.all_vehicles() -- for veh in basync.all_vehicles() do
	local id,veh
	return function()
		id,veh = next(gVehicles,id)
		if id then
			return veh
		end
	end
end

-- vehicle objects
function basync.create_vehicle(model)
	local model_name = VEHICLE_MODELS[model]
	if model_name then
		local server = {
			name = model_name,
			model = model,
			pos = {273,-73,7,90}, -- x, y, z, h (degrees)
			area = 0, -- only guaranteed to be a number, not a valid area
		}
		local veh = setmetatable({
			state = create_server_state(server),
			server = server,
			auto_owner = true,
			seats = {},
		},mt_vehicle)
		for k,v in pairs(gModules) do
			server[k] = copy_value(v.value)
		end
		veh.id = shared.generate_net_id(veh)
		for p in pairs(gPlayers) do
			SendNetworkEvent(p,"basync:_createVehicle",veh.id)
			veh.state:require_update(p)
		end
		shared.ping_net_id(veh.id)
		gVehicles[veh.id] = veh
		add_cleanup_object(GetCurrentScript(),veh)
		RunLocalEvent("basync:createVehicle",veh)
		return veh
	end
	error("invalid vehicle model",2)
end
function validate_vehicle(veh,level)
	if type(veh) ~= "table" or getmetatable(veh) ~= mt_vehicle or gVehicles[veh.id] ~= veh then
		error("invalid vehicle",level+1)
	end
end
function mt_vehicle:__tostring()
	if gVehicles[self.id] == self then
		return "vehicle: "..tostring(self.id)
	end
	return "invalid vehicle"
end
function mt_vehicle.__index:delete()
	validate_vehicle(self,2)
	for p in pairs(gPlayers) do
		SendNetworkEvent(p,"basync:_deleteVehicle",self.id)
	end
	shared.release_net_id(self.id)
	gVehicles[self.id] = nil
end
function mt_vehicle.__index:is_valid()
	if type(self) ~= "table" or getmetatable(self) ~= mt_vehicle then
		error("expected vehicle object",2)
	end
	return gVehicles[self.id] == self
end
function mt_vehicle.__index:lock_owner()
	validate_vehicle(self,2)
	self.auto_owner = true
end
function mt_vehicle.__index:unlock_owner()
	validate_vehicle(self,2)
	self.auto_owner = false
end
function mt_vehicle.__index:get_id()
	validate_vehicle(self,2)
	return self.id
end
function mt_vehicle.__index:get_owner()
	validate_vehicle(self,2)
	return self.state.owner
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
function mt_vehicle.__index:get_seat(seat)
	validate_vehicle(self,2)
	if seat == nil then
		seat = 0
	elseif (not ALLOW_PASSENGERS and seat ~= 0) or math.floor(seat) ~= seat or seat < 0 then
		error("invalid seat",2)
	end
	if self.seats[seat] then
		local ped = self.seats[seat]
		if basync.is_ped_valid(ped) then
			return ped
		end
		self.seats[seat] = nil
	end
end
function mt_vehicle.__index:set_owner(player) -- return false if it can't set the owner to that player yet
	validate_vehicle(self,2)
	if player ~= -1 and not gPlayers[player] then
		if IsPlayerValid(player) then
			return false
		end
		error("invalid player",2)
	end
	self.state:set_owner(player)
	return true
end
function mt_vehicle.__index:set_name(str)
	validate_vehicle(self,2)
	self.server.name = tostring(str)
	self.state:update_field("name")
end
function mt_vehicle.__index:set_model(model)
	validate_vehicle(self,2)
	if not VEHICLE_MODELS[model] then
		error("invalid vehicle model index",2)
	end
	if self.server.name == VEHICLE_MODELS[self.server.model] then
		self.server.name = VEHICLE_MODELS[model]
		self.state:update_field("name")
	end
	self.server.model = model
	self.state:update_field("model")
end
function mt_vehicle.__index:set_area(area)
	validate_vehicle(self,2)
	if type(area) ~= "number" then
		error("invalid area code",2)
	end
	self.server.area = area
	self.state:update_field("area")
end
function mt_vehicle.__index:set_position(x,y,z,h)
	validate_vehicle(self,2)
	if type(x) ~= "number" or type(y) ~= "number" or type(z) ~= "number" then
		error("invalid position",2)
	elseif h ~= nil and type(h) ~= "number" then
		error("invalid heading",2)
	end
	self.server.pos = {x,y,z,h or 0}
	self.state:update_field("pos")
end
function mt_vehicle.__index:set_seat(seat,ped)
	validate_vehicle(self,2)
	if seat == nil then
		seat = 0
	elseif (not ALLOW_PASSENGERS and seat ~= 0) or math.floor(seat) ~= seat or seat < 0 then
		error("invalid seat",2)
	end
	if ped == nil then
		local ped = self.seats[seat]
		if ped then
			self.seats[seat] = nil
			ped.vehicle = nil
			shared.update_ped_vehicle(nil,ped)
		end
	elseif self.seats[seat] ~= ped then
		if not basync.is_ped_valid(ped) then
			error("invalid ped",2)
		elseif self.seats[seat] then
			error("seat is already occupied",2)
		elseif ped.vehicle then
			error("ped is already in a vehicle",2)
		end
		self.seats[seat] = ped
		ped.vehicle = self
		ped.seat = seat
		shared.update_ped_vehicle(nil,ped)
	end
	if self.auto_owner then
		set_best_owner(self)
	end
end

-- player connection events
RegisterLocalEventHandler("basync:_initPlayer",function(player)
	if gPlayers[player] then
		destroy_player(player,gPlayers[player])
	end
	gPlayers[player] = create_player(player)
	for id,veh in pairs(gVehicles) do
		SendNetworkEvent(player,"basync:_createVehicle",id)
		veh.state:require_update(player)
	end
end)
RegisterLocalEventHandler("PlayerDropped",function(player)
	local data = gPlayers[player]
	if data then
		gPlayers[player] = nil
		destroy_player(player,data)
		for _,veh in pairs(gVehicles) do
			veh.state:clear_player(player)
		end
	end
end)

-- player state
function create_player(player)
	return {visible = {}}
end
function destroy_player(player,data)
end

-- player vehicle events
RegisterNetworkEventHandler("basync:_deleteVehicle",function(player,id)
	if gPlayers[player] then
		local veh = shared.get_net_id(player,id)
		if veh and veh == gVehicles[id] and veh.state.owner == player and RunLocalEvent("basync:deleteVehicle") then
			veh:delete()
		else
			SendNetworkEvent(player,"basync:_undeleteVehicle",id)
		end
	end
end)
RegisterNetworkEventHandler("basync:_updateVehicles",function(player,all_changes)
	if not gPlayers[player] then
		return
	elseif type(all_changes) ~= "table" then
		return (kick_bad_args(player))
	end
	for id,changes in pairs(all_changes) do
		local veh = shared.get_net_id(player,id)
		if veh and veh == gVehicles[id] then
			if type(changes) ~= "table" then
				return (kick_bad_args(player))
			end
			for k,v in pairs(changes) do
				if not check_update_value(k,v) then
					return (kick_bad_args(player))
				end
			end
			veh.state:apply_changes(player,changes)
			RunLocalEvent("basync:updateVehicle",veh)
		end
	end
end)
RegisterNetworkEventHandler("basync:_updatedVehicles",function(player,all_updates)
	if not gPlayers[player] then
		return
	elseif type(all_updates) ~= "table" then
		return (kick_bad_args(player))
	end
	for id,updates in pairs(all_updates) do
		local veh = shared.get_net_id(player,id)
		if veh and veh == gVehicles[id] then
			if type(updates) ~= "table" then
				return (kick_bad_args(player))
			end
			for _,v in pairs(updates) do
				if type(v) ~= "number" then
					return (kick_bad_args(player))
				end
			end
			veh.state:process_updates(player,updates)
		end
	end
end)
RegisterNetworkEventHandler("basync:_visibleVehicles",function(player,ids)
	local data = gPlayers[player]
	if data then
		local before = data.visible
		if type(ids) ~= "table" then
			return kick_bad_args(player)
		end
		data.visible = ids -- not guaranteed to be valid IDs or even numbers (so it should only be checked against valid ones)
		for _,id in ipairs(before) do
			if not has_value(ids,id) then
				local veh = shared.get_net_id(player,id)
				if veh and veh == gVehicles[id] then
					lost_visibility(player,veh)
				end
			end
		end
		for _,id in ipairs(ids) do
			if not has_value(before,id) then
				local veh = shared.get_net_id(player,id)
				if veh and veh == gVehicles[id] then
					gain_visibility(player,veh)
				end
			end
		end
	end
end)

-- check update values
function check_update_value(k,v)
	if k == "pos" then
		if type(v) ~= "table" then
			return false
		end
		for i = 1,4 do
			if type(v[i]) ~= "number" then
				return false
			end
		end
		return true
	elseif k == "area" then
		return type(v) == "number" and math.floor(v) == v
	elseif k == "model" then
		return PED_MODELS[v] ~= nil
	elseif gModules[k] then
		return check_mod_value(gModules[k],v)
	end
	return false -- not allowed to update this field
end
function check_mod_value(mod,value)
	if mod.tname and not is_type(value,mod.tname) then
		return false
	elseif mod.check and not mod.check(value) then
		return false
	end
	return true
end

-- vehicle owners
function lost_visibility(player,veh)
	if veh.auto_owner and veh.state.owner == player then
		veh.state:set_owner(-1)
		set_best_owner(veh)
	end
end
function gain_visibility(player,veh)
	if veh.auto_owner and veh.state.owner == -1 then
		veh.state:set_owner(player)
	end
end
function should_switch_owner(veh)
	local player = veh.state.owner
	if player ~= -1 then
		local ped = basync.get_player_ped(player)
		if ped then
			local x1,y1,z1 = unpack(veh.server.pos)
			local x2,y2,z2 = unpack(ped.server.pos)
			local dx,dy,dz = x2-x1,y2-y1,z2-z1
			local dist = math.sqrt(dx*dx+dy*dy+dz*dz) - REASSIGN_DIST
			dist = dist * dist
			for p in pairs(gPlayers) do
				if p ~= player then
					local ped2 = basync.get_player_ped(p)
					if ped2 then
						x2,y2,z2 = unpack(ped2.server.pos)
						dx,dy,dz = x2-x1,y2-y1,z2-z1
						if dx*dx+dy*dy+dz*dz < dist then
							return true
						end
					end
				end
			end
			return false -- the current owner exists with a valid ped and no other players are much closer
		end
	end
	return true
end
function set_best_owner(veh)
	local player,dist
	local x1,y1,z1 = unpack(veh.server.pos)
	for p in pairs(gPlayers) do
		local ped = basync.get_player_ped(p)
		if ped and ped.vehicle == veh and (not player or ped.seat < dist) then
			player,dist = p,ped.seat
			if dist == 0 then
				break
			end
		end
	end
	if not player then
		for p,d in pairs(gPlayers) do
			if has_value(d.visible,veh.id) then
				local ped = basync.get_player_ped(p)
				if ped then
					local x2,y2,z2 = unpack(ped.server.pos)
					local dx,dy,dz = x2-x1,y2-y1,z2-z1
					local d = dx*dx+dy*dy+dz*dz
					if not player or d < dist then
						player,dist = p,d
					end
				end
			end
		end
	end
	if player then
		veh.state:set_owner(player)
	end
end

-- main
CreateAdvancedThread("GAME2",function() -- runs post-game so changes from other scripts get sent immediately
	while true do
		assign_owners()
		send_updates()
		Wait(0)
	end
end)
function assign_owners()
	for _,veh in pairs(gVehicles) do
		if veh.auto_owner and should_switch_owner(veh) then
			set_best_owner(veh)
		end
	end
end
function send_updates()
	for p in pairs(gPlayers) do
		local n,all_veh_changes = 0,{}
		for id,veh in pairs(gVehicles) do
			local changes,updates,full = veh.state:update_player(p)
			if changes then
				n = n + 1
				all_veh_changes[n] = {id,changes,updates,full}
			end
		end
		SendNetworkEvent(p,"basync:_updateVehicles",all_veh_changes)
	end
	for _,veh in pairs(gVehicles) do
		veh.state:finish_update()
	end
end

-- utility
function kick_bad_args(player)
	local info = debug.getinfo(2,"l")
	if info and info.currentline then
		return KickPlayer(player,"your script misbehaved (vehicles:"..info.currentline..")")
	end
	return KickPlayer(player,"your script misbehaved (vehicles:?)")
end
function copy_value(value)
	if type(value) == "table" then
		local t = {}
		for k,v in pairs(value) do
			t[copy_value(k)] = copy_value(v)
		end
		return t
	end
	return value
end
function has_value(t,value)
	for _,v in ipairs(t) do
		if v == value then
			return true
		end
	end
	return false
end
function is_type(value,tname)
	if type(tname) == "table" then
		if type(value) ~= "table" then
			return false
		end
		for k,v in pairs(tname) do
			if is_type(value[k],v) then
				return false
			end
		end
		return true
	end
	return type(value) == tname
end

-- cleanup
RegisterLocalEventHandler("ScriptShutdown",function(script)
	if script == GetCurrentScript() then
		gVehicles = {}
	end
end)

-- debug cutoff
if not GetConfigBoolean(GetScriptConfig(),"allow_debug",false) then
	return
end

-- debug events
RegisterNetworkEventHandler("basync:_debugVehicle",function(player,id)
	if gPlayers[player] and net.admin.is_player_admin(player) then
		local veh = shared.get_net_id(player,id)
		if veh and veh == gVehicles[id] then
			local backup = veh.server
			veh.server = nil
			SendNetworkEvent(player,"basync:_debugVehicle","gVehicles["..id.."] = "..get_debug_string(veh))
			veh.server = backup
		else
			SendNetworkEvent(player,"basync:_debugVehicle")
		end
	end
end)
RegisterNetworkEventHandler("basync:_spawnVehicle",function(player,model,area,x,y,z,h)
	if gPlayers[player] and net.admin.is_player_admin(player) then
		local veh = basync.create_vehicle(model)
		veh:set_position(x,y,z,h)
		veh:set_area(area)
	end
end)
