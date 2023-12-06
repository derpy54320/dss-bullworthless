-- state utility

local server = {}
local client = {}
local mt_server = {__index = server}
local mt_client = {__index = client}
local dif_value
local copy_value

-- server state object
function create_server_state(state) -- state table should not use "_owned" (as that is reserved)
	if type(state) ~= "table" then
		error("expected state table",2)
	end
	return setmetatable({
		owner = -1, -- player owner (or -1 for nobody)
		full = {}, -- players that need a full update (because they're new)
		server = state, -- server state
		client = {}, -- client state (what was sent to tracked players)
		updating = {}, -- fields that the owner must update before their values can be used
		updates = {}, -- update counts to send to the owner (reset when sent)
	},mt_server)
end

-- state methods
function server:update_field(key) -- add to the update count for a certain field
	if self.owner ~= -1 then
		self.updating[key] = (self.updating[key] or 0) + 1
	end
	self.updates[key] = (self.updates[key] or 0) + 1
end
function server:update_fields(...) -- update multiple fields at once
	for _,v in ipairs(arg) do
		self:update_field(v)
	end
end

-- player methods
function server:set_owner(player)
	if player ~= self.owner then
		self.updating = {_owner = 1} -- the "_owner" update is special, as it means no fields can be updated
		self.updates = {_owner = 1}
		self.owner = player
	end
end
function server:require_update(player) -- require a full update for this player next update
	self.full[player] = true
end
function server:clear_player(player) -- clear references to this player (doesn't clear from tracked players)
	if self.owner == player then
		self.owner = -1
	end
	self.full[player] = nil
end

-- update methods
function server:update_player(player) -- return a table of changes and a table of updates
	local changes
	if self.full[player] then
		changes = {} -- use the whole server table for a full update
		for k,v in pairs(self.server) do
			changes[k] = v
		end
	else
		changes = {} -- or just include differences
		for k,v in pairs(self.server) do
			if dif_value(v,self.client[k]) then
				changes[k]  = v
			end
		end
	end
	if self.updates._owner then
		changes._owner = player == self.owner -- set "_owner" if needed
	else
		changes._owner = nil
	end
	if self.full[player] then
		return changes,self.updates,true
	elseif next(self.updates) then
		return changes,self.updates -- make sure to process changes BEFORE considering to send updates so _owner is applied
	elseif next(changes) then
		return changes
	end
end
function server:finish_update()
	if next(self.updates) then
		self.updates = {}
	end
	if next(self.full) then
		self.full = {}
	end
	self.client = copy_value(self.server)
end
function server:process_updates(player,updates) -- adjust field update counters since the player applied some updates
	if player == self.owner then
		for k,v in pairs(updates) do
			if self.updating[k] then
				self.updating[k] = self.updating[k] - v
				if self.updating[k] <= 0 then
					self.updating[k] = nil
				end
			end
		end
	end
end
function server:apply_changes(player,changes) -- make sure you assert the validity of the changes table first
	if player == self.owner and not self.updating._owner then
		for k,v in pairs(changes) do
			if not self.updating[k] then
				self.server[k] = v
			end
		end
	end
end

-- client state object
function create_client_state(state)
	if type(state) ~= "table" then
		error("expected state table",2)
	end
	state._owner = false
	return setmetatable({
		server = state,
		updated = {}, -- things that were just updated
	},mt_client)
end
function client:is_owner()
	return self.server._owner
end
function client:apply_changes(changes,updates,full) -- apply changes from the server's update_player method
	for k,v in pairs(changes) do
		self.server[k] = v
	end
	if full then
		for k in pairs(self.server) do
			self.updated[k] = true
		end
	elseif updates then
		for k in pairs(updates) do
			self.updated[k] = true
		end
	end
end
function client:was_updated(key)
	return self.updated[key] or false
end
function client:reset_updated()
	self.updated = {}
end
function client:update_server(state) -- return a table with new values *if* there are any
	local changes = {}
	for k,v in pairs(state) do
		if dif_value(v,self.server[k]) then
			changes[k] = v
		end
	end
	if next(changes) then
		return changes
	end
end

-- utility (not visible to other scripts)
function dif_value(a,b)
	if type(a) ~= "table" or type(b) ~= "table" then
		return a ~= b
	end
	for k,v in pairs(a) do
		if dif_value(v,b[k]) then
			return true
		end
	end
	for k in pairs(b) do
		if a[k] == nil then
			return true
		end
	end
	return false
end
function copy_value(x)
	if type(x) == "table" then
		local t = {}
		for k,v in pairs(x) do
			t[copy_value(k)] = copy_value(v)
		end
		return t
	end
	return x
end
