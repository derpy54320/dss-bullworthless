-- server ped sync
basync = GetScriptNetworkTable()
shared = GetScriptSharedTable(true)
LoadScript("utility/cleanup.lua")
LoadScript("utility/models.lua")
LoadScript("utility/state.lua")

-- config
SYNC_ENTITIES = string.lower(GetConfigString(GetScriptConfig(),"sync_entities","off"))
ALLOW_PASSENGERS = GetConfigBoolean(GetScriptConfig(),"allow_passengers",false)
REASSIGN_DIST = 1

-- globals
mt_ped = {__index = {}}
gMethodScripts = {}
gPlayers = {} -- generally good enough for validity checking, but some functions must still check in case they are called during a drop event
gPeds = {}

-- shared api
function basync.is_ped_valid(ped)
	return type(ped) == "table" and getmetatable(ped) == mt_ped and gPeds[ped.id] == ped
end
function basync.get_ped_from_player(id)
	local ped = shared.get_net_id(id)
	if ped and ped == gPeds[id] then
		return ped
	end
end
function basync.get_player_ped(player)
	local data = gPlayers[player]
	if data and data.ped:is_valid() and IsPlayerValid(player) then
		return data.ped
	end
end
function basync.all_player_peds() -- for player,ped in basync.all_player_peds() do
	local player,data
	return function()
		player,data = next(gPlayers,player)
		while player do
			if data.ped:is_valid() and IsPlayerValid(player) then
				return player,data.ped
			end
			player,data = next(gPlayers,player)
		end
	end
end
function basync.all_peds() -- for ped in basync.all_peds() do
	local id,ped
	return function()
		id,ped = next(gPeds,id)
		if id then
			return ped
		end
	end
end

-- register method
function basync.set_ped_method(name,func)
	if type(name) ~= "string" or type(func) ~= "function" then
		error("invalid method",2)
	elseif not mt_ped.__index[name] then
		local script = GetCurrentScript()
		local methods = gMethodScripts[script]
		if methods then
			table.insert(methods,name)
		else
			gMethodScripts[script] = {name,n = 1} -- save all methods registered by this script so they can be removed when the script is destroyed
		end
		mt_ped.__index[name] = func
		return true
	end
	return false
end

-- ped objects
function basync.create_ped(model,scriptless) -- 99% of other scripts should *not* make vehicles scriptless
	local model_name = PED_MODELS[model]
	if SYNC_ENTITIES ~= "full" then
		error("entity sync is not enabled",3)
	elseif model_name then
		local server = {
			type = "normal", -- "normal" peds are just normal, "player" peds use gPlayer when owned
			name = model_name,
			model = model,
			pos = {273,-73,6,90}, -- x, y, z, h (degrees)
			area = 0, -- only guaranteed to be a number, not a valid area
		}
		local ped = setmetatable({
			state = create_server_state(server), -- the state object controls the sync of the server table with clients
			server = server, -- basically shortcut to state.server (the table that is synced with clients)
			auto_owner = true, -- if this script will automatically change the owner to the best player for it
			-- .vehicle is set when the ped is in a vehicle (vehicle and seat are controlled by sv_vehicles.lua)
			seat = 0, -- which seat of the vehicle the ped is in
		},mt_ped)
		RunLocalEvent("basync:initPed",ped) -- init a ped object (put custom fields in it)
		ped.id = shared.generate_net_id(ped)
		for p in pairs(gPlayers) do
			if IsPlayerValid(p) then
				SendNetworkEvent(p,"basync:_createPed",ped.id)
				ped.state:require_update(p)
			end
		end
		gPeds[ped.id] = ped
		RunLocalEvent("basync:createPed",ped)
		if not scriptless then
			add_cleanup_object(GetCurrentScript(),ped)
		end
		return ped
	end
	error("invalid ped model",2)
end
function basync.validate_ped(ped,level)
	if type(ped) ~= "table" or getmetatable(ped) ~= mt_ped or gPeds[ped.id] ~= ped then
		if type(level) == "number" then
			error("invalid ped",level+1)
		end
		error("invalid ped")
	end
end
function mt_ped:__tostring()
	if gPeds[self.id] == self then
		return "ped: "..tostring(self.id)
	end
	return "invalid ped"
end
function mt_ped.__index:delete()
	basync.validate_ped(self,2)
	if self.server.type == "player" then
		error("cannot delete player ped",2)
	end
	RunLocalEvent("basync:deletingPed",self)
	if self.vehicle then
		self.vehicle:set_seat(self.seat,nil)
	end
	for p in pairs(gPlayers) do
		if IsPlayerValid(p) then
			SendNetworkEvent(p,"basync:_deletePed",self.id)
		end
	end
	shared.release_net_id(self.id)
	gPeds[self.id] = nil
	RunLocalEvent("basync:deletedPed",self)
end
function mt_ped.__index:is_valid()
	if type(self) ~= "table" or getmetatable(self) ~= mt_ped then
		error("expected ped object",2)
	end
	return gPeds[self.id] == self
end
function mt_ped.__index:is_player()
	return self.server.type == "player"
end
function mt_ped.__index:lock_owner()
	basync.validate_ped(self,2)
	self.auto_owner = false
end
function mt_ped.__index:unlock_owner()
	basync.validate_ped(self,2)
	if self.server.type == "player" then
		error("cannot unlock player owner",2)
	end
	self.auto_owner = true
end
function mt_ped.__index:get_id()
	basync.validate_ped(self,2)
	return self.id
end
function mt_ped.__index:get_owner()
	basync.validate_ped(self,2)
	if IsPlayerValid(self.state.owner) then
		return self.state.owner
	end
	return -1
end
function mt_ped.__index:get_name()
	basync.validate_ped(self,2)
	return self.server.name
end
function mt_ped.__index:get_model()
	basync.validate_ped(self,2)
	return self.server.model
end
function mt_ped.__index:get_area()
	basync.validate_ped(self,2)
	return self.server.area
end
function mt_ped.__index:get_position()
	basync.validate_ped(self,2)
	return unpack(self.server.pos)
end
function mt_ped.__index:get_vehicle()
	basync.validate_ped(self,2)
	return self.vehicle
end
function mt_ped.__index:set_owner(player) -- return false if it can't set the owner to that player yet
	basync.validate_ped(self,2)
	if player ~= -1 and not gPlayers[player] then
		if type(player) == "number" and IsPlayerValid(player) then
			return false
		end
		error("invalid player",2)
	elseif self.server.type == "player" then
		error("cannot change player owner",2)
	end
	self.state:set_owner(player)
	return true
end
function mt_ped.__index:set_name(str)
	basync.validate_ped(self,2)
	self.server.name = tostring(str)
	self.state:update_field("name")
end
function mt_ped.__index:set_model(model)
	basync.validate_ped(self,2)
	if not PED_MODELS[model] then
		error("invalid ped model index",2)
	elseif self.server.type ~= "player" and self.server.name == PED_MODELS[self.server.model] then
		self.server.name = PED_MODELS[model]
		self.state:update_field("name")
	end
	self.server.model = model
	self.state:update_field("model")
end
function mt_ped.__index:set_area(area)
	basync.validate_ped(self,2)
	if type(area) ~= "number" then
		error("invalid area code",2)
	end
	self.server.area = area
	self.state:update_field("area")
end
function mt_ped.__index:set_position(x,y,z,h)
	basync.validate_ped(self,2)
	if type(x) ~= "number" or type(y) ~= "number" or type(z) ~= "number" then
		error("invalid position",2)
	elseif h ~= nil and type(h) ~= "number" then
		error("invalid heading",2)
	end
	self.server.pos = {x,y,z,h or 0}
	self.state:update_field("pos")
end
function mt_ped.__index:warp_into_vehicle(veh,seat)
	basync.validate_ped(self,2)
	if seat == nil then
		seat = 0
	end
	if not basync.is_vehicle_valid(veh) then
		error("invalid vehicle",2)
	elseif veh:is_seat_valid(seat) and (not veh.seats[seat] or veh.seats[seat] == self) then
		if self.vehicle and veh.seats[self.seat] == self then
			veh:set_seat(self.seat,nil) -- warp out of current car first
		end
		if not self.vehicle and not veh.seats[seat] then
			return veh:set_seat(seat,self)
		end
	end
	return false
end
function mt_ped.__index:warp_out_of_vehicle()
	basync.validate_ped(self,2)
	if self.vehicle then
		if self.vehicle.seats[self.seat] == self then
			return self.vehicle:set_seat(self.seat,nil)
		end
		return false -- should never actually happen but it's just a fail-safe
	end
	return true
end

-- ped utility
function shared.update_ped_vehicle(ped)
	local veh = ped.vehicle
	for p in pairs(gPlayers) do
		if IsPlayerValid(p) then
			if veh then
				SendNetworkEvent(p,"basync:_setVehicle",ped.id,veh.id,ped.seat)
			else
				SendNetworkEvent(p,"basync:_setVehicle",ped.id)
			end
		end
	end
	ped.state:update_field("_vehicle") -- there isn't any _vehicle field in ped, but the update state is still used
end

-- player connection events
RegisterLocalEventHandler("basync:_initPlayer",function(player)
	if gPlayers[player] then
		destroy_player(player,gPlayers[player])
	end
	if SYNC_ENTITIES == "partial" then
		SYNC_ENTITIES = "full"
		gPlayers[player] = create_player(player)
		SYNC_ENTITIES = "partial"
	elseif SYNC_ENTITIES == "full" then
		gPlayers[player] = create_player(player)
	end
	for id,ped in pairs(gPeds) do
		SendNetworkEvent(player,"basync:_createPed",id)
		shared.update_ped_vehicle(ped)
		ped.state:require_update(player)
	end
end)
RegisterLocalEventHandler("PlayerDropped",function(player)
	local data = gPlayers[player]
	if data then
		gPlayers[player] = nil
		destroy_player(player,data)
		for _,ped in pairs(gPeds) do
			ped.state:clear_player(player)
		end
	end
end)

-- player state
function create_player(player)
	local zone,x,y,z = 0,273,-73,6 -- school grounds (default spawn)
	local dist,h = math.random(0,500)/100,math.rad(math.random(0,359))
	local ped = basync.create_ped(math.random(3,48),true)
	ped.auto_owner = false
	ped.server.type = "player"
	ped.state:set_owner(player)
	ped:set_name(GetPlayerName(player))
	ped:set_area(zone)
	ped:set_position(x-dist*math.sin(h),y+dist*math.cos(h),z,math.deg(h+math.pi))
	RunLocalEvent("basync:spawnedPlayer",player,ped)
	return {ped = ped,visible = {}}
end
function destroy_player(player,data)
	if data.ped:is_valid() then
		data.ped.server.type = "ped"
		data.ped:delete()
	end
end

-- player ped events
RegisterNetworkEventHandler("basync:_deletePed",function(player,id)
	if gPlayers[player] then
		local ped = shared.get_net_id(id)
		if ped and ped == gPeds[id] then
			if ped.state.owner == player and RunLocalEvent("basync:deletePed",ped) then
				ped:delete()
			else
				SendNetworkEvent(player,"basync:_undeletePed",id)
			end
		end
	end
end)
RegisterNetworkEventHandler("basync:_setVehicle",function(player,id,vid,seat)
	if gPlayers[player] then
		local ped = shared.get_net_id(id)
		if ped and ped == gPeds[id] and not ped.state.updating._vehicle then
			local veh = basync.get_vehicle_from_player(vid)
			if veh then
				if not veh:is_seat_valid(seat) then
					return (kick_bad_args(player))
				elseif not RunLocalEvent("basync:enterVehicle",ped,veh) then
					return
				end
			elseif not RunLocalEvent("basync:exitVehicle",ped) then
				return
			end
			if veh and (not veh.seats[seat] or veh.seats[seat] == ped) then
				ped:warp_into_vehicle(veh,seat)
			else
				ped:warp_out_of_vehicle()
			end
			ped.state:update_field("_vehicle")
			RunLocalEvent("basync:updatePed",ped)
			RunLocalEvent("basync:updateVehicle",veh)
		end
	end
end)
RegisterNetworkEventHandler("basync:_updatePeds",function(player,all_changes)
	if not gPlayers[player] then
		return
	elseif type(all_changes) ~= "table" then
		return (kick_bad_args(player))
	end
	for id,changes in pairs(all_changes) do
		local ped = shared.get_net_id(id)
		if ped and ped == gPeds[id] then
			if type(changes) ~= "table" then
				return (kick_bad_args(player))
			end
			for k,v in pairs(changes) do
				if ped.server[k] == nil then
					changes[k] = nil -- don't update values that aren't even in server state and don't bother checking it (this helps keep modules from kicking players too)
				elseif not check_update_value(k,v) then
					return (kick_bad_args(player,"["..tostring(k).."="..tostring(v).."]"))
				end
			end
			ped.state:apply_changes(player,changes)
			RunLocalEvent("basync:updatePed",ped)
		end
	end
end)
RegisterNetworkEventHandler("basync:_updatedPeds",function(player,all_updates)
	if not gPlayers[player] then
		return
	elseif type(all_updates) ~= "table" then
		return (kick_bad_args(player))
	end
	for id,updates in pairs(all_updates) do
		local ped = shared.get_net_id(id)
		if ped and ped == gPeds[id] then
			if type(updates) ~= "table" then
				return (kick_bad_args(player))
			end
			for _,v in pairs(updates) do
				if type(v) ~= "number" then
					return (kick_bad_args(player))
				end
			end
			ped.state:process_updates(player,updates)
		end
	end
end)
RegisterNetworkEventHandler("basync:_visiblePeds",function(player,ids)
	local data = gPlayers[player]
	if data then
		local before = data.visible
		if type(ids) ~= "table" then
			return kick_bad_args(player)
		end
		data.visible = ids -- not guaranteed to be valid IDs or even numbers (so it should only be checked against valid ones)
		for _,id in ipairs(before) do
			if not has_value(ids,id) then
				local ped = shared.get_net_id(id)
				if ped and ped == gPeds[id] then
					lost_visibility(player,ped)
				end
			end
		end
		for _,id in ipairs(ids) do
			if not has_value(before,id) then
				local ped = shared.get_net_id(id)
				if ped and ped == gPeds[id] then
					gain_visibility(player,ped)
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
	elseif RunLocalEvent("basync:setPed",k,v) then
		return false -- not allowed to update this field
	end
	return true -- some event handler must have returned true so it's okay
end

-- ped owners
function lost_visibility(player,ped)
	if ped.auto_owner and ped.state.owner == player then
		ped.state:set_owner(-1)
		set_best_owner(ped)
	end
end
function gain_visibility(player,ped)
	if ped.auto_owner and ped.state.owner == -1 then
		ped.state:set_owner(player)
	end
end
function should_switch_owner(ped)
	local player = ped.state.owner
	if player ~= -1 then
		local data = gPlayers[player]
		if data and data.ped:is_valid() then
			local x1,y1,z1 = unpack(ped.server.pos)
			local x2,y2,z2 = unpack(data.ped.server.pos)
			local dx,dy,dz = x2-x1,y2-y1,z2-z1
			local dist = math.sqrt(dx*dx+dy*dy+dz*dz) - REASSIGN_DIST
			dist = dist * dist
			for p,d in pairs(gPlayers) do
				if p ~= player and d.ped:is_valid() then
					x2,y2,z2 = unpack(d.ped.server.pos)
					dx,dy,dz = x2-x1,y2-y1,z2-z1
					if dx*dx+dy*dy+dz*dz < dist then
						return true
					end
				end
			end
			return false -- the current owner exists with a valid ped and no other players are much closer
		end
	end
	return true
end
function set_best_owner(ped)
	local player,dist
	local x1,y1,z1 = unpack(ped.server.pos)
	for p,d in pairs(gPlayers) do
		if has_value(d.visible,ped.id) and d.ped:is_valid() then
			local x2,y2,z2 = unpack(d.ped.server.pos)
			local dx,dy,dz = x2-x1,y2-y1,z2-z1
			local d = dx*dx+dy*dy+dz*dz
			if not player or d < dist then
				player,dist = p,d
			end
		end
	end
	if player then
		ped.state:set_owner(player)
	end
end

-- main
CreateAdvancedThread("GAME2",function() -- runs post-game so changes from other scripts get sent immediately
	if SYNC_ENTITIES == "off" then
		return
	end
	while true do
		assign_owners()
		send_updates()
		Wait(0)
	end
end)
function assign_owners()
	for _,ped in pairs(gPeds) do
		if ped.auto_owner and should_switch_owner(ped) then
			set_best_owner(ped)
		end
	end
end
function send_updates()
	for p in pairs(gPlayers) do
		local n,all_ped_changes = 0,{}
		for id,ped in pairs(gPeds) do
			local changes,updates,full = ped.state:update_player(p)
			if changes then
				n = n + 1
				all_ped_changes[n] = {id,changes,updates,full}
			end
		end
		SendNetworkEvent(p,"basync:_updatePeds",all_ped_changes)
	end
	for _,ped in pairs(gPeds) do
		ped.state:finish_update()
	end
end

-- utility
function kick_bad_args(player,info)
	if not info then
		info = debug.getinfo(2,"l")
		info = info.currentline
	end
	if info then
		return KickPlayer(player,"your script misbehaved (ped:"..info..")")
	end
	return KickPlayer(player,"your script misbehaved (ped:?)")
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
	local methods = gMethodScripts[script]
	if methods then
		for _,name in ipairs(methods) do
			mt_ped.__index[name] = nil
		end
		gMethodScripts[script] = nil
	end
	if script == GetCurrentScript() then
		gPeds = {}
	end
end)

-- init
RunLocalEvent("basync:initPeds") -- a good time for module scripts to register methods
