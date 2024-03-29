LoadScript("unique.lua")

-- config
SPAWN_DISTANCE = GetConfigNumber(GetScriptConfig(),"spawn_distance",0) ^ 2
DESPAWN_DISTANCE = GetConfigNumber(GetScriptConfig(),"despawn_distance",0) ^ 2
SPAWN_LIMIT_TOTAL = GetConfigNumber(GetScriptConfig(),"spawn_limit_total",0)
SPAWN_LIMIT_NEAR = GetConfigNumber(GetScriptConfig(),"spawn_limit_near",0)
SPAWN_NEAR_DIST = GetConfigNumber(GetScriptConfig(),"spawn_near_dist",0) ^ 2
SPAWN_SPACING = GetConfigNumber(GetScriptConfig(),"spawn_spacing",0) ^ 2
STYLES = {"/GLOBAL/G_STRIKER_A","/GLOBAL/P_STRIKER_A","/GLOBAL/G_GRAPPLER_A","/GLOBAL/P_STRIKER_B","/GLOBAL/BOSS_DARBY","/GLOBAL/RUSSELL_102","/GLOBAL/CRAZY_BASIC"}

-- globals
gPlayers = {}
gPeds = {n = 0}

-- player events
RegisterNetworkEventHandler("sheldon_world:initPlayer",function(player)
	local ids = {}
	validate_peds()
	for i,ped in ipairs(gPeds) do
		ids[i] = ped:get_id()
	end
	SendNetworkEvent(player,"sheldon_world:setPeds",ids)
	gPlayers[player] = true
end)
RegisterLocalEventHandler("PlayerDropped",function(player)
	gPlayers[player] = nil
end)

-- spawn events
RegisterNetworkEventHandler("sheldon_world:spawnPed",function(player,area,x,y,z)
	if gPlayers[player] then
		validate_peds()
		if gPeds.n < SPAWN_LIMIT_TOTAL and is_spawn_clear(area,x,y,z) and is_player_uncluttered(player) then
			local model = get_random_model()
			if model then
				local ped = net.basync.create_ped(model)
				local id = ped:get_id()
				if model == 66 then
					ped:set_act_tree(STYLES[math.random(1,table.getn(STYLES))])
				end
				ped:set_area(area)
				ped:set_position(x,y,z)
				for p in pairs(gPlayers) do
					SendNetworkEvent(p,"sheldon_world:addPed",id)
				end
				table.insert(gPeds,ped)
			end
		end
	end
end)
function is_spawn_clear(area,x1,y1,z1)
	for _,ped in net.basync.all_player_peds() do
		if ped:get_area() == area then
			local x2,y2,z2 = ped:get_position()
			local dx,dy,dz = x2-x1,y2-y1,z2-z1
			if dx*dx+dy*dy+dz*dz < SPAWN_DISTANCE then
				return false
			end
		end
	end
	for ped in net.basync.all_peds() do
		if not ped:is_player() and ped:get_area() == area then
			local x2,y2,z2 = ped:get_position()
			local dx,dy,dz = x2-x1,y2-y1,z2-z1
			if dx*dx+dy*dy+dz*dz < SPAWN_SPACING then
				return false
			end
		end
	end
	return true
end
function is_player_uncluttered(player)
	local ped = net.basync.get_player_ped(player)
	if ped then
		local count = 0
		local area,x1,y1,z1 = ped:get_area(),ped:get_position()
		for _,other in ipairs(gPeds) do
			if other:get_area() == area then
				local x2,y2,z2 = other:get_position()
				local dx,dy,dz = x2-x1,y2-y1,z2-z1
				if dx*dx+dy*dy+dz*dz < SPAWN_NEAR_DIST then
					count = count + 1
					if count >= SPAWN_LIMIT_NEAR then
						return false
					end
				end
			end
		end
		return true
	end
	return false
end
function get_random_model()
	local count,models = 0,{}
	if math.random(1,100) <= 98 then
		return 66
	end
	for i,v in ipairs(gUniqueModelStatus) do
		if v > 0 then
			local m = i - 1
			if v == 1 then
				for ped in net.basync.all_peds() do
					if ped:get_model() == m then
						m = nil
						break
					end
				end
			end
			if m then
				count = count + 1
				models[count] = m
			end
		end
	end
	if count ~= 0 then
		return models[math.random(1,count)]
	end
end

-- main
function main()
	while true do
		validate_peds()
		for i,ped in ipairs(gPeds) do
			if not is_ped_needed(ped) then
				ped:delete()
				table.remove(gPeds,i)
				break
			end
		end
		Wait(0)
	end
end
function is_ped_needed(ped)
	local area,x1,y1,z1 = ped:get_area(),ped:get_position()
	for _,player in net.basync.all_player_peds() do
		if player:get_area() == area then
			local x2,y2,z2 = player:get_position()
			local dx,dy,dz = x2-x1,y2-y1,z2-z1
			if dx*dx+dy*dy+dz*dz < DESPAWN_DISTANCE then
				return true
			end
		end
	end
	return false
end

-- utility
function validate_peds()
	local index = 1
	while index <= gPeds.n do
		if gPeds[index]:is_valid() then
			index = index + 1
		else
			table.remove(gPeds,index)
		end
	end
end
