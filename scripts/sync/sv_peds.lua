-- SYNC: server peds
s = GetScriptSharedTable()

-- globals:
gPeds = {}
gNextId = 0 -- net IDs are never re-used

-- shared:
s.peds = gPeds

-- ped object:
--[[ ped types
	
	types are only meant to be set by this script, other scripts just create normal peds.
	
	normal: a normal server-sided ped.
	player: this ped belongs to a player and will map to gPlayer for the player that owns the ped.
	converted: the ped was made to convert a local ped from the leader's game and will be mapped to said ped.
	
	non-player peds can be deleted by the owner when the ped becomes invalid.
	non-normal peds are deleted when the owner leaves.
	
]]
mt_ped = {__index = {}}
function sync.createPed()
	local ped = setmetatable({
		id = gNextId, -- key to gPeds
		type = "normal", -- can be "player" if a player ped
		owner = -1, -- owner player
		active = false, -- only active peds go to clients
		state = { -- state that gets sent to the client
			-- basics:
			model = 0,
			area = 0, -- only meaningful for players
			pos = {0,0,0,0},
			dead = false, -- clients will not spawn dead peds
			-- actions:
			act_node = "/Global",
			act_count = 0,
			act_timer = 0,
			-- extra:
			hp = 100,
			maxhp = 100,
			crouch = false,
			weapon = -1,
			throttle = 0,
			speech = 0,
			speechv = 0,
		},
		update = {}, -- updating count for each state field for each player (update[player][field] = count)
		cstate = {}, -- client's current state (cstate[field] = value)
		cupdate = {}, -- update count to send to clients (cupdate[player][field] = count)
	},mt_ped)
	for id in pairs(s.players) do
		ped.update[id] = {} -- [field] = count
		ped.cupdate[id] = {}
	end
	gPeds[gNextId] = ped
	gNextId = gNextId + 1
	return ped
end

-- ped cleanup:
SetScriptCleanup(function()
	gPeds = {} -- will keep old peds from being "valid"
end)

-- ped core:
function mt_ped.__index:setOwner(player)
	F_AssertValid(self)
	if player ~= -1 and not s.players[player] then
		error("bad player",2)
	elseif self.owner ~= player then
		if self.active then
			if self.owner ~= -1 then
				SendNetworkEvent(self.owner,"sync:controlPed",self.id)
			end
			if player ~= -1 then
				SendNetworkEvent(player,"sync:controlPed",self.id,true)
			end
		end
		self.owner = player
	end
end
function mt_ped.__index:isValid()
	return gPeds[self.id] == self
end
function mt_ped.__index:activate()
	F_AssertValid(self)
	if not self.active then
		for id in pairs(s.players) do
			if id == self.owner then
				SendNetworkEvent(id,"sync:createPed",self.id,self.type,true)
			else
				SendNetworkEvent(id,"sync:createPed",self.id,self.type)
			end
		end
		self.active = true
	end
end
function mt_ped.__index:delete()
	F_AssertValid(self)
	if self.active then
		for id in pairs(s.players) do
			SendNetworkEvent(id,"sync:deletePed",self.id)
		end
	end
	gPeds[self.id] = nil
end

-- ped state:
function mt_ped.__index:setModel(model)
	F_AssertValid(self)
	if type(model) ~= "number" then
		error("bad model",2)
	end
	F_SetState(self,"model",model)
end
function mt_ped.__index:setPosition(x,y,z)
	F_AssertValid(self)
	if type(x) ~= "number" or type(y) ~= "number" or type(z) ~= "number" then
		error("bad position",2)
	end
	F_SetState(self,"pos")
	self.state.pos[1],self.state.pos[2],self.state.pos[3] = x,y,z
end
function mt_ped.__index:setHeading(h)
	F_AssertValid(self)
	if type(h) ~= "number" then
		error("bad position",2)
	end
	F_SetState(self,"pos")
	self.state.pos[4] = h
end

-- ped utility:
function F_AssertValid(ped)
	if gPeds[ped.id] ~= ped then
		error("invalid ped",3) -- the function that called the method that would be calling this
	end
end
function F_SetState(ped,key,value)
	if ped.active then -- not even activated yet so no need to use the update system yet
		for id in pairs(s.players) do
			local t = ped.update[id]
			t[key] = (t[key] or 0) + 1
			t = ped.cupdate[id]
			t[key] = (t[key] or 0) + 1
		end
	end
	if value ~= nil then
		ped.state[key] = value
	end
end

-- player events:
RegisterLocalEventHandler("sync:initPlayer",function(player,x,y,z,h)
	local allchanges = {}
	for id,ped in pairs(gPeds) do
		ped.update[player] = {}
		ped.cupdate[player] = {}
		if ped.active then
			allchanges[id] = ped.state
			SendNetworkEvent(player,"sync:createPed",id,ped.type)
		end
	end
	if next(allchanges) then
		SendNetworkEvent(player,"sync:updatePeds",allchanges)
	end
	F_CreatePlayerPed(player,x,y,z,h)
end)
RegisterLocalEventHandler("sync:playerDropped",function(player)
	for _,ped in pairs(gPeds) do
		ped.update[player] = nil
		ped.cupdate[player] = nil
		if ped.owner == player then
			ped.owner = -1
			if ped.type ~= "normal" then
				ped:delete() -- player peds and converted peds die when their owner dies
			end
		end
	end
end)

-- network events:
RegisterNetworkEventHandler("sync:updatedPeds",function(player,allupdates)
	if not s.players[player] then
		return
	elseif type(allupdates) ~= "table" then
		return s.unexpected(player,"bad ped update response")
	end
	for id,updates in pairs(allupdates) do
		local ped = gPeds[id]
		if ped then
			local cu = ped.update[player]
			if type(updates) ~= "table" then
				return s.unexpected(player,"bad ped update response")
			end
			for k,v in pairs(updates) do
				if not cu[k] then
					return s.unexpected(player,"bad ped update response: "..tostring(k))
				end
				cu[k] = cu[k] - v
				if cu[k] <= 0 then
					if cu[k] < 0 then
						return s.unexpected(player,"unexpected ped update response: "..tostring(k))
					end
					cu[k] = nil
				end
			end
		end
	end
end)
RegisterNetworkEventHandler("sync:updatePeds",function(player,allchanges)
	local allcorrects = {}
	if not s.players[player] then
		return
	elseif type(allchanges) ~= "table" then
		return s.unexpected(player,"bad ped update")
	end
	for id,changes in pairs(allchanges) do
		local ped = gPeds[id]
		if ped then
			local corrects = {} -- state that we must correct the client on
			if type(changes) ~= "table" then
				return s.unexpected(player,"bad ped update")
			end
			for k,v in pairs(changes) do
				if type(v) ~= type(ped.state[k]) then
					return s.unexpected(player,"bad ped update: "..tostring(k))
				end
			end
			if ped.owner == player then
				for k,v in pairs(changes) do
					if ped.update[player][k] then
						corrects[k] = ped.state[k] -- state is being updated for this player so don't accept it
					else
						ped.state[k] = v -- accept the change
					end
				end
			else
				for k in pairs(changes) do
					corrects[k] = ped.state[k] -- correct all state because they don't actually own this ped
				end
			end
			if next(corrects) then
				allcorrects[id] = corrects
			end
		end
	end
	if next(allcorrects) then
		SendNetworkEvent(player,"sync:updatePeds",allcorrects)
	end
end)
RegisterNetworkEventHandler("sync:convertPed",function(player,state)
	if not s.players[player] then
		return
	elseif player ~= s.leader then
		return s.unexpected(player,"not leader")
	elseif type(state) ~= "table" then
		return s.unexpected(player,"bad convert argument")
	end
	F_ConvertPed(player,state)
end)
RegisterNetworkEventHandler("sync:deletePed",function(player,id)
	local ped = gPeds[id]
	if not s.players[player] or not ped then
		return
	elseif ped.owner == player and ped.type ~= "player" then
		ped:delete()
	else
		SendNetworkEvent(player,"sync:denyDeletion",id)
	end
end)

-- create peds:
function F_GetPlayerModel(player)
	if GetPlayerName(player) == "Sloth" then
		return math.random(1,2) == 2 and 2 or 48
	elseif GetPlayerName(player) == "derpy54320" then
		return 3
	end
	return math.random(2,48)
end
function F_CreatePlayerPed(player,x,y,z,h)
	local ped = sync.createPed()
	ped.type = "player"
	ped.state.pos = {x,y,z,h}
	if player == s.leader and not GetConfigBoolean(GetScriptConfig(),"dbg_nojimmy") then
		ped.state.model = 0
	else
		ped.state.model = F_GetPlayerModel(player)
	end
	ped:setOwner(player)
	ped:activate()
end
function F_ConvertPed(player,state)
	local ped = sync.createPed()
	ped.type = "converted"
	for k,v in pairs(state) do
		if type(v) ~= type(ped.state[k]) then
			ped:delete()
			return s.unexpected(player,"bad convert argument: "..tostring(k))
		end
		ped.state[k] = v
	end
	SendNetworkEvent(player,"sync:acceptConvert")
	ped:setOwner(player)
	ped:activate()
end

-- main:
function main()
	while true do
		F_SendUpdates()
		Wait(0)
	end
end

-- update clients:
function F_SendUpdates()
	local allchanges = {} -- [id] = {[key] = value}
	for id,ped in pairs(gPeds) do
		local changes = {}
		for k,v in pairs(ped.state) do
			if k == "pos" or F_Different(v,ped.cstate[k]) then
				ped.cstate[k] = F_Copy(v)
				changes[k] = v
			end
		end
		if next(changes) then
			allchanges[id] = changes
		end
	end
	for player in pairs(s.players) do
		local allupdates = {} -- [id] = {[key] = count}
		for id,ped in pairs(gPeds) do
			local updates = ped.cupdate[player]
			if next(updates) then
				allupdates[id] = updates
				ped.cupdate[player] = {} -- reset the count that gets sent to the player (since we're sending it)
			end
		end
		if next(allupdates) then
			SendNetworkEvent(player,"sync:updatePeds",allchanges,allupdates)
		elseif next(allchanges) then
			SendNetworkEvent(player,"sync:updatePeds",allchanges)
		end
	end
end

-- utility:
function F_Different(a,b)
	if type(a) ~= "table" or type(b) ~= "table" then
		return a ~= b
	end
	for k,v in pairs(a) do
		if b[k] == nil then
			return true
		end
	end
	for k,v in pairs(b) do
		if F_Different(a[k],v) then
			return true
		end
	end
	return false
end
function F_Copy(value)
	if type(value) == "table" then
		local t = {}
		for k,v in pairs(value) do
			t[k] = F_Copy(v)
		end
		return t
	end
	return value
end
