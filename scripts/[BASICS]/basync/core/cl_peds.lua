-- client ped sync
basync = GetScriptNetworkTable()
shared = GetScriptSharedTable(true)
LoadScript("utility/debug.lua")
LoadScript("utility/models.lua")
LoadScript("utility/modules.lua")
LoadScript("utility/nodes.lur")
LoadScript("utility/state.lua")

-- TODO: fix PedWarpOutOfCar with bikes

-- config
SYNC_ENTITIES = string.lower(GetConfigString(GetScriptConfig(),"sync_entities","off"))
PED_POOL_TARGET = GetConfigNumber(GetScriptConfig(),"ped_pool_target",0)
PED_SPAWN_DISTANCE = GetConfigNumber(GetScriptConfig(),"ped_spawn_distance",0) ^ 2
PED_DESPAWN_DISTANCE = GetConfigNumber(GetScriptConfig(),"ped_despawn_distance",0) ^ 2
ALT_PED_STOP_METHOD = GetConfigBoolean(GetScriptConfig(),"alt_ped_stop_method",false)
ALLOW_PASSENGERS = GetConfigBoolean(GetScriptConfig(),"allow_passengers",false)
FORCE_PLAYER_AI = GetConfigBoolean(GetScriptConfig(),"force_player_ai",false)
SLIDE_TIME_SECS = GetConfigNumber(GetScriptConfig(),"slide_time_ms",0) / 1000

-- data
AUTHORITY_MODELS = {[49]=1,[50]=1,[51]=1,[52]=1,[53]=1,[83]=1,[97]=1,[158]=1,[234]=0,[238]=1}
VEHICLE_SEATS = {
	-- 0 = bike, 1 = car, 2+ = car w/ passenger(s)
	[272] = 0, -- bmxrace
	[273] = 0, -- retro
	[274] = 0, -- crapbmx
	[275] = 1, -- bikecop
	[276] = 1, -- Scooter
	[277] = 0, -- bike
	[278] = 0, -- custombike
	[279] = 0, -- banbike
	[280] = 0, -- mtnbike
	[281] = 0, -- oladbike
	[282] = 0, -- racer
	[283] = 0, -- aquabike
	[284] = 1, -- Mower
	[285] = 1, -- Arc_3
	[286] = 2, -- taxicab
	[287] = 1, -- Arc_2
	[288] = 1, -- Dozer
	[289] = 1, -- GoCart
	[290] = 2, -- Limo
	[291] = 2, -- Dlvtruck
	[292] = 2, -- Foreign
	[293] = 2, -- cargreen
	[294] = 2, -- 70wagon
	[295] = 2, -- policecar
	[296] = 2, -- domestic
	[297] = 2, -- Truck
	[298] = 1, -- Arc_1
}

-- globals
mt_ped = {__index = {}}
gDebugControlPed = -1
gPlayerWarning = 0 -- warning timer for duplicate player ped
gPlayerPed = setmetatable({},mt_ped) -- invalid player ped
gUnwanted = {} -- unwanted peds
gVisible = {} -- who the server thinks we see
gPeds = {}

-- load modules
load_modules("ped_",false,mt_ped.__index)

-- shared api
function basync.get_player_ped()
	if gPlayerPed:is_valid() and gPlayerPed.state:is_owner() and gPlayerPed.server.type == "player" then
		return gPlayerPed
	end
end
function basync.get_ped_by_ped(ped)
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

-- ped objects
function create_ped(id)
	return setmetatable({
		-- .state is *ONLY* set when the ped gets their first update
		-- .server is *ONLY* set when state is set (and it is set to state.server)
		id = id,
		ped = -1, -- the ped is *ONLY* created when the ped has state
		created = false, -- if the ped *should* exist
		deleted = false, -- if the ped was deleted while owned (makes the ped unable to be created again)
		netbasics = false, -- if the stuff in "set_ped_basics" was applied
		position = {0,0,0,0}, -- smooth position {x,y,z,h}
		-- .transition is set when the ped is transitioning areas (only gPlayer)
		changecar = false,
		-- .vehicle is set when the ped is in a vehicle
		seat = 0,
	},mt_ped)
end
function validate_ped(ped,level)
	if type(ped) ~= "table" or getmetatable(ped) ~= mt_ped or gPeds[ped.id] ~= ped or not ped.state then
		error("invalid ped",level+1)
	end
end
function mt_ped:__tostring()
	if gPeds[self.id] == self then
		return "ped: "..tostring(self.id)
	end
	return "invalid ped"
end
function mt_ped.__index:is_valid(pre)
	if type(self) ~= "table" or getmetatable(self) ~= mt_ped then
		error("expected ped object",2)
	end
	return (pre or self.state) and gPeds[self.id] == self
end
function mt_ped.__index:is_owner()
	validate_ped(self,2)
	return self.state:is_owner()
end
function mt_ped.__index:is_player()
	validate_ped(self,2)
	return self.server.type == "player"
end
function mt_ped.__index:get_ped()
	validate_ped(self,2)
	if PedIsValid(self.ped) then
		return self.ped
	end
	return -1
end
function mt_ped.__index:get_id()
	validate_ped(self,2)
	return self.id
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
	if self.vehicle and self.vehicle:is_valid() then
		return self.vehicle
	end
end

-- server ped events
RegisterNetworkEventHandler("basync:_createPed",function(id)
	if gPeds[id] then
		error("ped #"..id.." already exists")
	end
	gPeds[id] = create_ped(id)
end)
RegisterNetworkEventHandler("basync:_deletePed",function(id)
	local ped = gPeds[id]
	if not ped then
		error("ped #"..id.." doesn't exist")
	end
	if PedIsValid(ped.ped) and ped.ped ~= gPlayer then
		PedDelete(ped.ped)
	end
	gPeds[id] = nil
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
		nearest.ped = -1
		count = count - 1
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
	gPlayerWarning = GetTimer()
	AreaClearAllPeds()
	while true do
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
		Wait(0)
	end
end)
function MissionCleanup()
	if PedIsValid(gDebugControlPed) then
		PedSetControllerID(gPlayer,0)
		PedStop(gDebugControlPed)
		gDebugControlPed = -1
	end
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
		PedSetActionTree(gPlayer,"","")
		PedSetAITree(gPlayer,"/Global/PlayerAI","Act/PlayerAI.act")
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
				PedWarpOutOfCar(ped)
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
					setup_player(ped.server.model)
					set_ped(ped,gPlayer)
					ped.created = true
				elseif not PedIsModel(gPlayer,ped.server.model) and ped.state:was_updated("model") then
					setup_player(ped.server.model)
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
		if PedIsValid(ped.ped) and not PedIsModel(ped.ped,ped.server.model) and (not ped.state:is_owner() or ped.state:was_updated("model")) then
			PedDelete(ped.ped) -- delete ped so a new one can be made with the correct model instead of swapping
			set_ped(ped,-1)
		end
		if not PedIsValid(ped.ped) and peds[i][3] < PED_SPAWN_DISTANCE then
			local x,y,z = unpack(ped.server.pos)
			local real = PedCreateXYZ(ped.server.model,x,y,z) -- create the closest peds that there is space for
			if PedIsValid(real) then
				PedSetAlpha(real,0,false) -- make the ped fade in on spawn
				set_ped(ped,real)
				ped.state:apply_changes({},nil,true) -- force a full update
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
		RunLocalEvent("basync:updatePed",ped)
	end
end
function setup_player(model)
	PlayerSwapModel(PED_MODELS[model])
	PedSetActionTree(gPlayer,"","")
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
				if ped.ped == gPlayer then
					player = ped
				end
				ped.transition = nil -- can get set by "area" or "vehicle"
				set_ped_basics(ped)
				set_ped_area(ped)
				set_ped_vehicle(ped)
				if not ped.transition then
					set_ped_pos(ped)
				end
				for k,v in pairs(gModules) do
					if v.set then
						local s,m = pcall(v.set,ped,ped.server[k])
						if not s then
							PrintError(m)
						end
					end
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
			PedWarpOutOfCar(gPlayer)
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
	if ped.ped ~= gPlayer then
		for f = 0,11 do
			if PedGetPedToTypeAttitude(ped.ped,f) ~= 2 then
				PedSetPedToTypeAttitude(ped.ped,f,2)
			end
		end
		if PedGetPedToTypeAttitude(ped.ped,13) ~= 2 then
			PedSetPedToTypeAttitude(ped.ped,13,2)
		end
	end
	if not ped.state:is_owner() then
		if PedGetWeapon(ped.ped) ~= -1 then
			PedClearAllWeapons(ped.ped)
			PedSetWeapon(ped.ped,-1)
		end
		PedSetEffectedByGravity(ped.ped,false)
		PedIgnoreAttacks(ped.ped,true)
		PedIgnoreStimuli(ped.ped,true)
		ped.netbasics = true
	elseif ped.netbasics then
		PedSetEffectedByGravity(ped.ped,true)
		PedIgnoreAttacks(ped.ped,false)
		PedIgnoreStimuli(ped.ped,false)
		ped.netbasics = false
	end
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
		if ped.ped == gPlayer and veh and not VehicleIsValid(veh.veh) then
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
		update_ped_vehicle(ped,veh)
	end
end
function set_ped_pos(ped)
	local pos = ped.position
	local updated = ped.state:was_updated("pos")
	if (updated or not ped.state:is_owner()) and not PedIsInAnyVehicle(ped.ped) then
		local x1,y1,z1,h1 = unpack(pos)
		local x2,y2,z2,h2 = unpack(ped.server.pos)
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
		PedSetPosXYZ(ped.ped,x2,y2,z2)
		PedFaceHeading(ped.ped,h2,0)
		pos[1],pos[2],pos[3],pos[4] = x2,y2,z2,h2
	else
		pos[1],pos[2],pos[3],pos[4] = unpack(ped.server.pos) -- instantly match server position
	end
end

-- update state (client -> server)
RegisterLocalEventHandler("basync:_updateServer",function()
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
			for k,v in pairs(gModules) do
				if v.get then
					local s,m = pcall(v.get,ped)
					if s then
						state[k] = m
					else
						PrintError(m)
					end
				end
			end
			all_changes[id] = ped.state:update_server(state)
		end
	end
	if next(all_changes) then
		SendNetworkEvent("basync:_updatePeds",all_changes)
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
	return ped.server.area
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

-- ped vehicles
function update_ped_vehicle(ped,veh)
	local last = PedGetLastVehicle(ped.ped)
	if VehicleIsValid(last) and PedIsInVehicle(ped.ped,last) then
		if veh and last == veh.veh then
			return -- already in the right vehicle
		end
		PedWarpOutOfCar(ped.ped) -- get out of the wrong vehicle
	end
	if veh and VehicleIsValid(veh.veh) then
		local count = VEHICLE_SEATS[VehicleGetModelId(veh.veh)]
		if count then
			local seats = {}
			for other in AllPeds() do
				if PedIsInVehicle(other,veh.veh) then
					PedWarpOutOfCar(other) -- get everyone out so we can just re-do all seating
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

-- debug cutoff
if not GetConfigBoolean(GetScriptConfig(),"debugging",false) then
	return
end

-- debug menu
function shared.run_ped_menu()
	local menu = net.menu.create("Basync Peds","Re-open this menu to show new peds.")
	local peds = {}
	for _,ped in pairs(gPeds) do
		table.insert(peds,ped)
	end
	table.sort(peds,function(a,b)
		if a.state and b.state and (a.server.type == "player") ~= (b.server.type == "player") then
			return a.server.type == "player" -- players first
		end
		return a.id < b.id -- then sort by id
	end)
	while menu:active() do
		for _,ped in ipairs(peds) do
			if ped:is_valid() then
				local name
				if ped.state then
					name = ped.server.name
				else
					name = "uninitialized ped"
				end
				if menu:option(name,"["..ped.id.."]") then
					specific_ped_menu(ped.id,ped,name)
					break
				end
			end
		end
		menu:draw()
		Wait(0)
	end
end
function shared.spawn_ped_menu()
	local menu = net.menu.create("Summon Basync Ped")
	while menu:active() do
		for i = 0,258 do
			local model = PED_MODELS[i]
			if model and menu:option(model) then
				local h,x,y,z = PedGetHeading(gPlayer),PlayerGetPosXYZ()
				SendNetworkEvent("basync:_spawnPed",i,AreaGetVisible(),x-math.sin(h),y+math.cos(h),z,math.deg(h))
				break
			end
		end
		menu:draw()
		Wait(0)
	end
end
function specific_ped_menu(id,ped,name)
	local menu = net.menu.create("["..id.."] "..name)
	while menu:active() and gPeds[id] == ped do
		if menu:option("Show Full Server Data") then
			SendNetworkEvent("basync:_debugPed",id)
		elseif menu:option("Show Full Client Data") then
			local backup_1 = ped.server
			local backup_2 = ped.node_t
			ped.server = nil
			ped.node_t = nil
			shared.draw_debug_string("gPeds["..id.."] = "..get_debug_string(ped))
			ped.server = backup_1
			ped.node_t = backup_2
		elseif menu:option("Teleport To Ped") and not AreaIsLoading() then
			if ped.state then
				local dist = -0.5
				local a,x,y,z,h = ped.server.area,unpack(ped.server.pos)
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
				PedFaceHeading(gPlayer,h,0)
				CameraFade(500,1)
			else
				menu:alert("Ped position unknown.",3)
			end
		elseif menu:option("Control Local Ped",get_control_ped_status(ped.ped)) then
			if PedIsValid(ped.ped) then
				if PedIsValid(gDebugControlPed) then
					PedStop(gDebugControlPed)
				end
				if ped.ped == gPlayer or ped.ped == gDebugControlPed then
					PedSetControllerID(gPlayer,0)
					gDebugControlPed = -1
				else
					PedSetControllerID(ped.ped,0)
					gDebugControlPed = ped.ped
				end
			end
		elseif menu:option("Delete Local Ped","["..ped.ped.."]") then
			if ped.ped == gPlayer then
				menu:alert("Please do not delete yourself.",3)
			elseif ped.ped ~= -1 then
				if PedIsValid(ped.ped) then
					PedDelete(ped.ped)
				end
				set_ped(ped,-1)
			end
		end
		menu:help("owner: "..tostring(ped.state:is_owner()))
		menu:draw()
		Wait(0)
	end
end
function get_control_ped_status(ped)
	if ped == gPlayer then
		return gDebugControlPed == -1 and "[ON]" or "[OFF]"
	elseif ped ~= -1 then
		return gDebugControlPed == ped and "[ON]" or "[OFF]"
	end
	return "[N/A]"
end

-- debug events
RegisterNetworkEventHandler("basync:_debugPed",function(str)
	if str then
		shared.draw_debug_string(str)
	else
		PrintWarning("Failed to show server data because the network id wasn't a valid ped.")
	end
end)
