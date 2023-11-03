-- server ped sync
basync = GetScriptNetworkTable()
LoadScript("utility/cleanup.lua")
LoadScript("utility/debug.lua")
LoadScript("utility/models.lua")
LoadScript("utility/modules.lua")
LoadScript("utility/state.lua")

-- TODO: send events for vehicle / veh_id instantly instead of in normal ped updates (for timing)
-- TODO: occupy vehicle seats when players report a ped in a vehicle

-- config
REASSIGN_DIST = 1
ALLOW_PASSENGERS = GetConfigBoolean(GetScriptConfig(),"allow_passengers",false)

-- globals
mt_ped = {__index = {}}
gPlayers = {}
gPeds = {}

-- load modules
load_modules("ped_",{},mt_ped.__index,mt_ped.__index)

-- shared api
function basync.create_ped(model)
	return create_ped(model)
end
function basync.is_ped_valid(ped)
	return type(ped) == "table" and getmetatable(ped) == mt_ped and gPeds[ped.id] == ped
end
function basync.get_player_ped(player)
	local data = gPlayers[player]
	if data and data.ped:is_valid() then
		return data.ped
	end
end
function basync.get_ped_from_player(player,id)
	local ped = basync.get_net_id(player,id)
	if ped and ped == gPeds[id] then
		return ped
	end
end
function basync.all_player_peds() -- for player,ped in basync.all_player_peds() do
	local player,data
	return function()
		player,data = next(gPlayers,player)
		while player do
			if data.ped:is_valid() then
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

-- ped objects
function create_ped(model)
	local model_name = PED_MODELS[model]
	if model_name then
		local server = {
			type = "normal", -- "normal" peds are just normal, "player" peds use gPlayer when owned
			name = model_name,
			model = model,
			pos = {273,-73,7,90}, -- x, y, z, h (degrees)
			area = 0, -- only guaranteed to be a number, not a valid area
			veh_id = 0, -- set in adjust_state
			veh_seat = 0,
		}
		local ped = setmetatable({
			state = create_server_state(server),
			server = server,
			auto_owner = true,
			-- .vehicle is set when the ped is in a vehicle
		},mt_ped)
		for k,v in pairs(gModules) do
			server[k] = copy_value(v.value)
		end
		ped.id = basync.generate_net_id(ped)
		for p in pairs(gPlayers) do
			SendNetworkEvent(p,"basync:_createPed",ped.id)
			ped.state:require_update(p)
		end
		basync.ping_net_id(ped.id)
		gPeds[ped.id] = ped
		add_cleanup_object(GetCurrentScript(),ped)
		RunLocalEvent("basync:createPed",ped)
		return ped
	end
	error("invalid ped model",2)
end
function validate_ped(ped,level)
	if type(ped) ~= "table" or getmetatable(ped) ~= mt_ped or gPeds[ped.id] ~= ped then
		error("invalid ped",level+1)
	end
end
function mt_ped.__index:delete()
	validate_ped(self,2)
	if self.vehicle then
		for seat,already in pairs(self.vehicle.seats) do
			if already == self then
				self.vehicle.seats[seat] = nil
			end
		end
	end
	for p in pairs(gPlayers) do
		SendNetworkEvent(p,"basync:_deletePed",self.id)
	end
	basync.release_net_id(self.id)
	gPeds[self.id] = nil
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
	validate_ped(self,2)
	self.auto_owner = true
end
function mt_ped.__index:unlock_owner()
	validate_ped(self,2)
	if type(self.server.type) == "player" then
		error("cannot unlock player owner",2)
	end
	self.auto_owner = false
end
function mt_ped.__index:get_id()
	validate_ped(self,2)
	return self.id
end
function mt_ped.__index:get_owner()
	validate_ped(self,2)
	return self.state.owner
end
function mt_ped.__index:get_name()
	validate_ped(self,2)
	return self.server.name
end
function mt_ped.__index:get_model()
	validate_ped(self,2)
	return self.server.model
end
function mt_ped.__index:get_area()
	validate_ped(self,2)
	return self.server.area
end
function mt_ped.__index:get_position()
	validate_ped(self,2)
	return unpack(self.server.pos)
end
function mt_ped.__index:get_vehicle()
	validate_ped(self,2)
	if self.vehicle then
		if self.vehicle:is_valid() then
			return self.vehicle
		end
		self.vehicle = nil
	end
end
function mt_ped.__index:set_owner(player) -- return false if it can't set the owner to that player yet
	validate_ped(self,2)
	if player ~= -1 and not gPlayers[player] then
		if IsPlayerValid(player) then
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
	validate_ped(self,2)
	self.server.name = tostring(str)
	self.state:update_field("name")
end
function mt_ped.__index:set_model(model)
	validate_ped(self,2)
	if not PED_MODELS[model] then
		error("invalid ped model index",2)
	end
	if self.server.type ~= "player" and self.server.name == PED_MODELS[self.server.model] then
		self.server.name = PED_MODELS[model]
		self.state:update_field("name")
	end
	self.server.model = model
	self.state:update_field("model")
end
function mt_ped.__index:set_area(area)
	validate_ped(self,2)
	if type(area) ~= "number" then
		error("invalid area code",2)
	end
	self.server.area = area
	self.state:update_field("area")
end
function mt_ped.__index:set_position(x,y,z,h)
	validate_ped(self,2)
	if type(x) ~= "number" or type(y) ~= "number" or type(z) ~= "number" then
		error("invalid position",2)
	elseif h ~= nil and type(h) ~= "number" then
		error("invalid heading",2)
	end
	self.server.pos = {x,y,z,h or 0}
	self.state:update_field("pos")
end
function mt_ped.__index:warp_into_vehicle(veh,seat)
	validate_ped(self,2)
	if seat == nil then
		seat = 0
	end
	if not basync.is_vehicle_valid(veh) then
		error("invalid vehicle",2)
	elseif (ALLOW_PASSENGERS and seat ~= 0) or type(seat) ~= "number" or math.floor(seat) ~= seat then
		error("invalid seat",2)
	elseif veh.seats[seat] then
		local already = veh.seats[seat]
		if already ~= self and already:is_valid() then
			error("seat occupied",2)
		end
		veh.seats[seat] = nil
	end
	self.vehicle = veh
	veh.seats[seat] = self
	self.server.pos = {unpack(veh.server.pos)}
	self.server.area = veh.server.area
	self.server.veh_seat = seat
	self.state:update_field("pos")
	self.state:update_field("area")
	self.state:update_field("veh_id") -- veh_seat isn't "updated" since it is just used along veh_id
	veh:update_owner()
end
function mt_ped.__index:warp_out_of_vehicle()
	validate_ped(self,2)
	if self.vehicle then
		for seat,already in pairs(self.vehicle.seats) do
			if already == self then
				self.vehicle.seats[seat] = nil
			end
		end
		self.vehicle = nil
	end
	self.state:update_field("veh_id")
end

-- player connection events
RegisterLocalEventHandler("basync:_initPlayer",function(player)
	if gPlayers[player] then
		destroy_player(player,gPlayers[player])
	end
	gPlayers[player] = create_player(player)
	for id,ped in pairs(gPeds) do
		SendNetworkEvent(player,"basync:_createPed",id)
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
	local zone,x,y,z = 0,273,-73,7 -- school grounds (default spawn)
	local dist,h = math.random(0,500)/100,math.rad(math.random(0,359))
	local ped = create_ped(math.random(3,48))
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
		data.ped:delete()
	end
end

-- player ped events
RegisterNetworkEventHandler("basync:_deletePed",function(player,id)
	if gPlayers[player] then
		local ped = basync.get_net_id(player,id)
		if ped and ped == gPeds[id] and ped.state.owner == player and RunLocalEvent("basync:deletePed",ped) then
			ped:delete()
		else
			SendNetworkEvent(player,"basync:_undeletePed",id)
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
		local ped = basync.get_net_id(player,id)
		if ped and ped == gPeds[id] then
			if type(changes) ~= "table" or not special_changes(player,changes,ped) then
				return (kick_bad_args(player))
			end
			for k,v in pairs(changes) do
				if not check_update_value(k,v) then
					return (kick_bad_args(player))
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
		local ped = basync.get_net_id(player,id)
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
				local ped = basync.get_net_id(player,id)
				if ped and ped == gPeds[id] then
					lost_visibility(player,ped)
				end
			end
		end
		for _,id in ipairs(ids) do
			if not has_value(before,id) then
				local ped = basync.get_net_id(player,id)
				if ped and ped == gPeds[id] then
					gain_visibility(player,ped)
				end
			end
		end
	end
end)

-- accept special changes
function special_changes(player,changes,ped)
	if changes.veh_id ~= nil then
		if ped.state.owner == player then
			ped.vehicle = basync.get_vehicle_from_player(player,changes.veh_id)
		end
		changes.veh_id = nil
	end
	return true -- success (otherwise player is kicked for bad args)
end

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
	elseif k == "area" or k == "veh_seat" then
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
function main()
	while true do
		assign_owners()
		adjust_state()
		send_updates()
		Wait(0)
	end
end
function assign_owners()
	for _,ped in pairs(gPeds) do
		if ped.auto_owner and should_switch_owner(ped) then
			set_best_owner(ped)
		end
	end
end
function adjust_state()
	for _,ped in pairs(gPeds) do
		local veh = ped:get_vehicle()
		if veh then
			ped.server.veh_id = veh.id
		else
			ped.server.veh_id = 0
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
function kick_bad_args(player)
	local info = debug.getinfo(2,"l")
	if info and info.currentline then
		return KickPlayer(player,"your script misbehaved (peds:"..info.currentline..")")
	end
	return KickPlayer(player,"your script misbehaved (peds:?)")
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
		gPeds = {}
	end
end)

-- debug cutoff
if not GetConfigBoolean(GetScriptConfig(),"allow_debug",false) then
	return
end

-- debug events
RegisterNetworkEventHandler("basync:_debugPed",function(player,id)
	if gPlayers[player] and net.admin.is_player_admin(player) then
		local ped = basync.get_net_id(player,id)
		if ped and ped == gPeds[id] then
			local backup = ped.server
			ped.server = nil
			SendNetworkEvent(player,"basync:_debugPed","gPeds["..id.."] = "..get_debug_string(ped))
			ped.server = backup
		else
			SendNetworkEvent(player,"basync:_debugPed")
		end
	end
end)
RegisterNetworkEventHandler("basync:_spawnPed",function(player,model,area,x,y,z,h)
	if gPlayers[player] and net.admin.is_player_admin(player) then
		local ped = basync.create_ped(model)
		ped:set_position(x,y,z,h)
		ped:set_area(area)
	end
end)
