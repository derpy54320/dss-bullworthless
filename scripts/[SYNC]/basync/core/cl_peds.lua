-- client ped sync
basync = GetScriptNetworkTable()
LoadScript("utility/models.lua")
LoadScript("utility/state.lua")

-- config
SYNC_ENTITIES = string.lower(GetConfigString(GetScriptConfig(),"sync_entities","off"))
PED_POOL_TARGET = GetConfigNumber(GetScriptConfig(),"ped_pool_target",0)
PED_SPAWN_DISTANCE = GetConfigNumber(GetScriptConfig(),"ped_spawn_distance",0) ^ 2
PED_DESPAWN_DISTANCE = GetConfigNumber(GetScriptConfig(),"ped_despawn_distance",0) ^ 2
ALT_PED_STOP_METHOD = GetConfigBoolean(GetScriptConfig(),"alt_ped_stop_method",false)
ALLOW_PASSENGERS = GetConfigBoolean(GetScriptConfig(),"allow_passengers",false)
FORCE_PLAYER_AI = GetConfigBoolean(GetScriptConfig(),"force_player_ai",false)
SLIDE_TIME_SECS = GetConfigNumber(GetScriptConfig(),"slide_time_ms",0) / 1000
WARP_DISTANCE = 10 ^ 2 -- distance that a position change is considered a warp

-- data
AUTHORITY_MODELS = {[49]=1,[50]=1,[51]=1,[52]=1,[53]=1,[83]=1,[97]=1,[158]=1,[234]=0,[238]=1}

-- globals
mt_ped = {__index = {}}
gRunningMainUpdate = false
gPlayerWarning = 0 -- warning timer for duplicate player ped
gPlayerPed = setmetatable({},mt_ped) -- invalid player ped
gMethodScripts = {}
gCreateCount = 0
gUnwanted = {} -- unwanted peds
gVisible = {} -- who the server thinks we see
gPeds = {}

-- shared api
function basync.get_player_ped()
	if gPlayerPed:is_valid() and gPlayerPed.state:is_owner() and gPlayerPed.server.type == "player" then
		return gPlayerPed
	end
end
function basync.get_ped_from_ped(ped)
	if ped ~= -1 then
		for _,v in pairs(gPeds) do
			if v.ped == ped then
				return v
			end
		end
	end
end
function basync.get_ped_from_server(id,pre)
	local ped = gPeds[id]
	if ped and (pre or ped.state) then
		return ped
	end
end
function basync.all_peds()
	local id,ped
	return function()
		id,ped = next(gPeds,id)
		while id do
			if ped.state then
				return ped
			end
			id,ped = next(gPeds,id)
		end
	end
end

-- debug stuff
function basync.get_peds_created()
	return gCreateCount
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
function basync.validate_ped(ped,level)
	if type(ped) ~= "table" or getmetatable(ped) ~= mt_ped or gPeds[ped.id] ~= ped or not ped.state then
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
function mt_ped.__index:delete() -- deletes the ped handle if valid, NOT the network object
	basync.validate_ped(self,2)
	if self.ped ~= -1 then
		if PedIsValid(self.ped) then
			PedDelete(self.ped)
		end
		set_ped(self,-1)
	end
end
function mt_ped.__index:respawn() -- mark the ped for respawn
	basync.validate_ped(self,2)
	self.respawning = true
end
function mt_ped.__index:is_valid(pre)
	if type(self) ~= "table" or getmetatable(self) ~= mt_ped then
		error("expected ped object",2)
	end
	return (pre or self.state) and gPeds[self.id] == self
end
function mt_ped.__index:is_owner()
	basync.validate_ped(self,2)
	return self.state:is_owner()
end
function mt_ped.__index:is_player()
	basync.validate_ped(self,2)
	return self.server.type == "player"
end
function mt_ped.__index:get_ped()
	basync.validate_ped(self,2)
	if PedIsValid(self.ped) then
		return self.ped
	end
	return -1
end
function mt_ped.__index:get_id()
	basync.validate_ped(self,2)
	return self.id
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
	if self.vehicle and self.vehicle:is_valid() then
		return self.vehicle
	end
end
function mt_ped.__index:get_last_vehicle()
	basync.validate_ped(self,2)
	if self.last_vehicle and self.last_vehicle:is_valid() then
		return self.last_vehicle
	end
end

-- server ped events
RegisterNetworkEventHandler("basync:_createPed",function(id)
	if gPeds[id] then
		error("ped #"..id.." already exists")
	end
	gPeds[id] = setmetatable({
		-- .state is *ONLY* set when the ped gets their first update
		-- .server is *ONLY* set when state is set (and it is set to state.server)
		id = id,
		ped = -1, -- the ped is *ONLY* created when the ped has state
		created = false, -- if the ped *should* exist
		deleted = false, -- if the ped was deleted while owned (makes the ped unable to be created again)
		respawning = false, -- if the ped needs to be re-created
		netbasics = false, -- if the stuff in "set_ped_basics" was applied
		position = {0,0,0,0}, -- smooth position {x,y,z,h}
		-- .transition is set when the ped is transitioning areas (only gPlayer)
		changecar = false,
		-- .vehicle and .last_vehicle are set when the ped is in a vehicle
		seat = 0,
	},mt_ped)
	RunLocalEvent("basync:createdPed",gPeds[id])
end)
RegisterNetworkEventHandler("basync:_deletePed",function(id)
	local ped = gPeds[id]
	if not ped then
		error("ped #"..id.." doesn't exist")
	end
	RunLocalEvent("basync:deletingPed",ped)
	if PedIsValid(ped.ped) and ped.ped ~= gPlayer then
		PedDelete(ped.ped)
	end
	gPeds[id] = nil
	RunLocalEvent("basync:deletedPed",ped)
end)
RegisterNetworkEventHandler("basync:_undeletePed",function(id)
	local ped = gPeds[id]
	if not ped then
		error("ped #"..id.." doesn't exist")
	end
	ped.deleted = false -- server didn't delete the ped, so we'll unmark them
end)
RegisterNetworkEventHandler("basync:_setVehicle",function(id,vid,seat)
	local ped = gPeds[id]
	if not ped then
		error("ped #"..id.." doesn't exist")
	end
	if vid then
		local veh = basync.get_vehicle_from_server(vid,true)
		if not veh then
			error("vehicle #"..vid.." doesn't exist")
		end
		ped.last_vehicle = veh
		ped.vehicle = veh
		ped.seat = seat
	else
		ped.vehicle = nil
	end
end)
RegisterNetworkEventHandler("basync:_updatePeds",function(all_ped_changes)
	local updated = {}
	for _,v in ipairs(all_ped_changes) do
		local id,changes,updates,full = unpack(v)
		local ped = gPeds[id]
		if ped then
			if not ped.state then
				ped.state = create_client_state({})
				ped.server = ped.state.server
			end
			ped.state:apply_changes(changes,updates,full)
			if updates and next(updates) and ped.state:is_owner() then
				updated[id] = updates
			end
		else
			PrintWarning("tried to update non-existant ped: "..id)
		end
	end
	if next(updated) then
		SendNetworkEvent("basync:_updatedPeds",updated)
	end
end)

-- ped spawn safeguard
RegisterLocalEventHandler("PedBeingCreated",function()
	local count = GetPoolUsage("PED")
	while count >= PED_POOL_TARGET do
		local nearest,distance
		local x1,y1,z1 = PlayerGetPosXYZ()
		for _,ped in pairs(gPeds) do
			if PedIsValid(ped.ped) and ped.ped ~= gPlayer then
				local x2,y2,z2 = unpack(ped.server.pos)
				local dx,dy,dz = x2-x1,y2-y1,z2-z1
				local dist = dx*dx+dy*dy+dz*dz
				if not nearest or dist > distance then
					nearest,distance = ped,dist
				end
			end
		end
		if not nearest then
			return -- no peds to delete
		end
		--PrintWarning("delete ped")
		PedDelete(nearest.ped)
		set_ped(nearest,-1)
		count = count - 1
	end
	gCreateCount = gCreateCount + 1
end)

-- main / cleanup
CreateAdvancedThread("PRE_GAME",function() -- runs pre-game so updates are applied before other scripts run
	if SYNC_ENTITIES == "off" then
		return
	end
	while not SystemIsReady() do
		Wait(0)
	end
	if PlayerIsInAnyVehicle() then
		local expire = GetTimer() + 1000
		local veh = PedGetLastVehicle(ped)
		if VehicleIsValid(veh) and PedIsInVehicle(veh) and VEHICLE_SEATS[VehicleGetModelId(veh)] == 0 then
			PedSetActionNode(ped,"/G/VEHICLES/BIKES/GROUND/DISMOUNT/GETOFF/GETOFFVEHICLERIDE","")
		else
			PedWarpOutOfCar(ped)
		end
		while PlayerIsInAnyVehicle() do
			if GetTimer() >= expire then
				SendNetworkEvent("basync:_kickMe","inside local vehicle")
				break
			end
			Wait(0)
		end
	end
	gPlayerWarning = GetTimer()
	AreaClearAllPeds()
	while true do
		gRunningMainUpdate = true
		if SYNC_ENTITIES == "full" then
			if ALT_PED_STOP_METHOD then
				for m in pairs(AUTHORITY_MODELS) do
					PedSetUniqueModelStatus(m,-1)
				end
				AreaOverridePopulation(0)
			else
				StopPedProduction(true)
			end
			hide_peds()
		end
		validate_peds()
		update_player()
		update_visible()
		update_peds()
		gRunningMainUpdate = false
		Wait(0)
	end
end)
function MissionCleanup()
	for _,ped in pairs(gPeds) do
		if PedIsValid(ped.ped) and ped.ped ~= gPlayer then
			PedDelete(ped.ped)
		end
	end
	if SYNC_ENTITIES ~= "off" then
		if ALT_PED_STOP_METHOD then
			for m,s in pairs(AUTHORITY_MODELS) do
				PedSetUniqueModelStatus(m,s)
			end
			AreaRevertToDefaultPopulation()
		else
			StopPedProduction(false)
		end
		PlayerSwapModel("player")
		if FORCE_PLAYER_AI then
			PedSetAITree(gPlayer,"/Global/PlayerAI","Act/PlayerAI.act")
		end
		AreaDisableCameraControlForTransition(false)
		CameraFade(0,1)
	end
end

-- hide unwanted peds
function hide_peds()
	for ped in AllPeds() do
		if gUnwanted[ped] == nil and should_hide_ped(ped) then
			gUnwanted[ped] = not PedIsModel(ped,233) and RunLocalEvent("basync:hidePed",ped)
		end
	end
	for ped,hide in pairs(gUnwanted) do
		if not PedIsValid(ped) then
			gUnwanted[ped] = nil
		elseif hide then
			if SoundSpeechPlaying(ped) then
				SoundStopCurrentSpeechEvent(ped)
			end
			if PedIsInAnyVehicle(ped) then
				local veh = PedGetLastVehicle(ped)
				if VehicleIsValid(veh) and PedIsInVehicle(veh) and VEHICLE_SEATS[VehicleGetModelId(veh)] == 0 then
					PedSetActionNode(ped,"/G/VEHICLES/BIKES/GROUND/DISMOUNT/GETOFF/GETOFFVEHICLERIDE","")
				else
					PedWarpOutOfCar(ped)
				end
			end
			PedSetUsesCollisionScripted(ped,true)
			PedSetEffectedByGravity(ped,false)
			PedSetPosXYZ(ped,0,0,0)
		end
	end
end
function should_hide_ped(ped)
	for _,v in pairs(gPeds) do
		if v.ped == ped then
			return false
		end
	end
	return ped ~= gPlayer
end

-- validate / create peds
function validate_peds() -- create / delete peds
	local player
	local count,peds = 0,{} -- distance based spawn controller (DBSC)
	local space = PED_POOL_TARGET - GetPoolUsage("PED") -- space for DBSC peds
	local area,x1,y1,z1 = AreaGetVisible(),PlayerGetPosXYZ()
	for _,ped in pairs(gPeds) do
		if ped.deleted and not ped.state:is_owner() then
			ped.deleted = false -- we don't own them anymore so just forget it
		end
		if ped.state and not ped.deleted then
			if ped.server.type == "player" and ped.state:is_owner() then -- player ped (set them NOW and don't use DBSC)
				if ped.ped ~= gPlayer then
					if PedIsValid(ped.ped) then
						PedDelete(ped.ped) -- delete the non-player ped (because it SHOULD be gPlayer)
					end
					PlayerSwapModel(PED_MODELS[ped.server.model])
					ped.state:apply_changes({},nil,true)
					set_ped(ped,gPlayer)
					ped.created = true
				elseif not PedIsModel(gPlayer,ped.server.model) and ped.state:was_updated("model") then
					PlayerSwapModel(PED_MODELS[ped.server.model])
					ped.state:apply_changes({},nil,true)
				end
				if not player then
					player = ped
					--space = space + 1
				elseif GetTimer() >= gPlayerWarning then
					SendNetworkEvent("basync:_kickMe","multiple player peds")
					gPlayerWarning = GetTimer() + 1000
				end
			else -- non-player ped (use DBSC)
				local x2,y2,z2 = unpack(ped.server.pos)
				local dx,dy,dz = x2-x1,y2-y1,z2-z1
				if PedIsValid(ped.ped) and ped.ped ~= gPlayer then
					space = space + 1 -- space goes up for each sync ped so it represents how many peds we can have created
				else
					set_ped(ped,-1) -- get rid of invalid ped handle (or get rid of gPlayer if this isn't meant to be the player ped)
					if ped.created and ped.state:is_owner() then
						SendNetworkEvent("basync:_deletePed",ped.id)
						ped.created = false
						ped.deleted = true
					end
				end
				if not ped.deleted then
					local dist = dx*dx+dy*dy+dz*dz
					count = count + 1
					if dist < PED_DESPAWN_DISTANCE then
						peds[count] = {ped,area == ped.server.area,dist}
					else
						peds[count] = {ped,false,dist} -- act like the ped isn't even in this area since they're so far
					end
				end
			end
		end
	end
	table.sort(peds,sort_peds)
	for i = math.min(count,space),1,-1 do
		if not peds[i][2] then
			space = i - 1 -- don't include peds that are not in this area
			break
		end
	end
	for i = math.max(1,space+1),count do
		local ped = peds[i][1]
		if PedIsValid(ped.ped) then
			PedDelete(ped.ped) -- not enough space for these far away peds
			set_ped(ped,-1)
		end
		ped.created = false
	end
	space = math.min(count,space)
	for i = 1,space do
		local ped = peds[i][1]
		if ped.respawning then
			if PedIsValid(ped.ped) then
				PedDelete(ped.ped)
			end
			set_ped(ped,-1)
			ped.respawning = false
		elseif PedIsValid(ped.ped) and not PedIsModel(ped.ped,ped.server.model) and (not ped.state:is_owner() or ped.state:was_updated("model")) then
			PedDelete(ped.ped) -- delete ped so a new one can be made with the correct model instead of swapping
			set_ped(ped,-1)
		end
		if not PedIsValid(ped.ped) and peds[i][3] < PED_SPAWN_DISTANCE then
			local x,y,z = unpack(ped.server.pos)
			local real = PedCreateXYZ(ped.server.model,x,y,z) -- create the closest peds that there is space for
			if PedIsValid(real) then
				PedSetAlpha(real,0,false) -- make the ped fade in on spawn
				ped.state:apply_changes({},nil,true) -- force a full update
				set_ped(ped,real)
			else
				PrintError("failed to create ped")
				set_ped(ped,-1)
			end
		end
		ped.created = true
	end
end
function set_ped(ped,real)
	if ped.ped ~= real then
		ped.ped = real
		RunLocalEvent("basync:assignPed",ped,real)
	end
end
function sort_peds(a,b)
	if a[2] ~= b[2] then
		return a[2] -- put peds in the current area first
	end
	return a[3] < b[3]
end

-- update player ped
function update_player()
	if FORCE_PLAYER_AI and not PedIsDoingTask(gPlayer,"/G/PLAYERAI",true) then
		PedSetAITree(gPlayer,"/Global/PlayerAI","Act/PlayerAI.act")
	end
end

-- update visible peds
function update_visible()
	local count,visible = 0,{}
	for _,ped in pairs(gPeds) do
		if PedIsValid(ped.ped) and ped.server.type ~= "player" then
			count = count + 1
			visible[count] = ped.id
		end
	end
	table.sort(visible)
	if count ~= gVisible.n or is_dif_visible(visible) then
		SendNetworkEvent("basync:_visiblePeds",visible)
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
function update_peds()
	local player
	for _,ped in pairs(gPeds) do
		if ped.state then
			if PedIsValid(ped.ped) then
				local off = set_ped_basics(ped)
				if ped.ped == gPlayer then
					player = ped
				end
				ped.transition = nil -- can get set by "area" or "vehicle"
				set_ped_area(ped)
				set_ped_vehicle(ped)
				if not ped.transition then
					set_ped_pos(ped)
				end
				RunLocalEvent("basync:setPed",ped)
				if off then
					ped.netbasics = false
				end
			end
			ped.state:reset_updated()
		end
	end
	if player and player.transition then
		local a,x,y,z,h = player.transition,unpack(player.position)
		while AreaIsLoading() do
			Wait(0)
		end
		if a ~= AreaGetVisible() then
			CameraFade(0,0)
			PlayerSetPosXYZArea(x,y,z,a)
			AreaDisableCameraControlForTransition(true)
			while AreaIsLoading() or IsStreamingBusy() do
				Wait(0)
			end
			AreaDisableCameraControlForTransition(false)
			PedFaceHeading(gPlayer,h,0)
			CameraFade(500,1)
		else
			PedSetPosXYZ(gPlayer,x,y,z)
			PedFaceHeading(gPlayer,h,0)
		end
		player.transition = nil
	end
end
function set_ped_basics(ped)
	if not ped.state:is_owner() then
		PedSetInfiniteSprint(ped.ped,true)
		PedIgnoreAttacks(ped.ped,true)
		PedIgnoreStimuli(ped.ped,true)
		ped.netbasics = true
	elseif ped.netbasics then
		PedSetInfiniteSprint(ped.ped,false)
		PedIgnoreAttacks(ped.ped,false)
		PedIgnoreStimuli(ped.ped,false)
		return true -- turn off netbasics *after* basync:setPed so event handlers can disable stuff by checking for netbasics without being an owner
	end
	return false
end
function set_ped_area(ped)
	if ped.ped == gPlayer and ped.state:was_updated("area") then
		ped.position = {unpack(ped.server.pos)}
		if AreaGetVisible() == ped.server.area then
			local x,y,z,h = unpack(ped.position)
			PedSetPosXYZ(ped.ped,x,y,z)
			PedFaceHeading(ped.ped,h,0)
		else
			ped.transition = ped.server.area
		end
	end
end
function set_ped_vehicle(ped)
	if ped.changecar or not ped.state:is_owner() or ped.state:was_updated("_vehicle") then
		local veh = ped.vehicle
		if veh and ped.ped == gPlayer and not VehicleIsValid(veh.veh) then
			ped.position = {unpack(veh.server.pos)}
			if AreaGetVisible() == veh.server.area then
				local x,y,z,h = unpack(veh.position)
				PedSetPosXYZ(ped.ped,x,y,z)
				PedFaceHeading(ped.ped,h,0)
			else
				ped.transition = veh.server.area
			end
			ped.changecar = true
		else
			ped.changecar = false
		end
		set_ped_vehicle_now(ped,veh)
	end
end
function set_ped_vehicle_now(ped,veh)
	local last = PedGetLastVehicle(ped.ped)
	if VehicleIsValid(last) and PedIsInVehicle(ped.ped,last) then
		if veh and last == veh.veh then
			return -- already in the right vehicle
		elseif VEHICLE_SEATS[VehicleGetModelId(last)] == 0 then
			PedSetActionNode(ped,"/G/VEHICLES/BIKES/GROUND/DISMOUNT/GETOFF/GETOFFVEHICLERIDE","")
		else
			PedWarpOutOfCar(ped.ped) -- get out of the wrong vehicle
		end
	end
	if veh and VehicleIsValid(veh.veh) then
		local count = VEHICLE_SEATS[VehicleGetModelId(veh.veh)]
		if count then
			local seats = {}
			for other in AllPeds() do
				if PedIsInVehicle(other,veh.veh) then
					if count == 0 then
						PedSetActionNode(other,"/G/VEHICLES/BIKES/GROUND/DISMOUNT/GETOFF/GETOFFVEHICLERIDE","")
					else
						PedWarpOutOfCar(other) -- get everyone out so we can just re-do all seating
					end
				end
			end
			if ALLOW_PASSENGERS and count > 1 then
				for _,other in pairs(gPeds) do
					if other.vehicle == veh and other.seat < count then
						seats[other.seat] = other -- passengers are allowed so assign seats
					end
				end
			else
				seats[0] = ped -- no passengers allowed so just use this ped
			end
			for seat,other in pairs(seats) do
				if PedIsValid(other.ped) then
					if count == 0 then
						PedPutOnBike(other.ped,veh.veh) -- 0 seats means it is a bike
					else
						PedWarpIntoCar(other.ped,veh.veh,seat) -- otherwise it is a car
					end
				end
			end
		end
	end
end
function set_ped_pos(ped)
	local pos = ped.position
	local updated = ped.state:was_updated("pos")
	if (updated or not ped.state:is_owner()) and not PedIsInAnyVehicle(ped.ped) then
		local x1,y1,z1,h1 = unpack(pos)
		local x2,y2,z2,h2 = unpack(ped.server.pos)
		if not updated then
			local dx,dy,dz,dh = x2-x1,y2-y1,z2-z1,math.mod(h2-h1,360)
			if dx*dx+dy*dy+dz*dz < WARP_DISTANCE then
				local amount = GetFrameTime() / SLIDE_TIME_SECS
				while dh <= -180 do
					dh = dh + 360
				end
				while dh > 180 do
					dh = dh - 360
				end
				x2,y2,z2,h2 = x1+dx*amount,y1+dy*amount,z1+dz*amount,h1+dh*amount
			end
		end
		PedSetPosXYZ(ped.ped,x2,y2,z2)
		PedFaceHeading(ped.ped,h2,0)
		pos[1],pos[2],pos[3],pos[4] = x2,y2,z2,h2
	else
		pos[1],pos[2],pos[3],pos[4] = unpack(ped.server.pos) -- instantly match server position
	end
end

-- update state (client -> server)
RegisterLocalEventHandler("basync:_updateServer",function()
	if not gRunningMainUpdate then
		local all_changes = {}
		for id,ped in pairs(gPeds) do
			if PedIsValid(ped.ped) and ped.state:is_owner() then
				local state = {}
				state.model = PedGetModelId(ped.ped)
				if not ped.transition then
					if not ped.changecar then
						local veh,seat = get_ped_vehicle(ped)
						if veh ~= ped.vehicle then
							if veh then
								SendNetworkEvent("basync:_setVehicle",id,veh.id,seat)
							else
								SendNetworkEvent("basync:_setVehicle",id)
							end
						end
					end
					state.area = get_ped_area(ped)
					state.pos = get_ped_pos(ped)
				end
				RunLocalEvent("basync:getPed",ped,state)
				all_changes[id] = ped.state:update_server(state)
			end
		end
		if next(all_changes) then
			SendNetworkEvent("basync:_updatePeds",all_changes)
		end
	end
end)
function get_ped_vehicle(ped)
	local veh = PedGetLastVehicle(ped.ped)
	if VehicleIsValid(veh) and PedIsInVehicle(ped.ped,veh) then
		for other in basync.all_vehicles() do
			if other.veh == veh then
				return other,0
			end
		end
	end
end
function get_ped_area(ped)
	if PedGetFlag(ped.ped,184) then
		return AreaGetVisible()
	end
end
function get_ped_pos(ped)
	local x,y,z = PedGetPosXYZ(ped.ped)
	return {x,y,z,math.deg(PedGetHeading(ped.ped))}
end

-- ped positioning
function PedSetPosXYZ(ped,x2,y2,z2)
	if ped == gPlayer then
		local x1,y1,z1 = PedGetPosXYZ(ped)
		local dx,dy,dz = x2-x1,y2-y1,z2-z1
		if dx * dx + dy * dy + dz * dz < 30 * 30 then
			return _G.PlayerSetPosSimple(x2,y2,z2)
		end
		return _G.PlayerSetPosXYZ(x2,y2,z2)
	end
	return _G.PedSetPosSimple(ped,x2,y2,z2)
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
