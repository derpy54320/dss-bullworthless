-- server stats
LoadScript("module.lua")
LoadScript("stats.lua")

-- state
function init_ped_stats(ped)
	local default = {}
	local stats = STATS[ped.server.model] or STATS.STAT_DEFAULT
	for i,v in ipairs(SYNCED) do
		default[i] = stats[v+1]
	end
	ped.server.stats = default
end
if net.basync then
	for ped in net.basync.all_peds() do
		init_ped_stats(ped)
	end
end
RegisterLocalEventHandler("basync:initPed",init_ped_stats)
RegisterLocalEventHandler("ScriptShutdown",function(script)
	if net.basync and script == GetCurrentScript() then
		for ped in net.basync.all_peds() do
			ped.server.dead = nil
			ped.server.health = nil
			ped.server.max_hp = nil
		end
	end
end)

-- count
count = 0
for _ in ipairs(SYNCED) do
	count = count + 1
end

-- check
RegisterLocalEventHandler("basync:setPed",function(k,v)
	if k == "stats" and type(v) == "table" and table.getn(v) == count then -- stats should be a table of the same size as the default
		for _,b in ipairs(v) do
			if type(b) ~= "number" then
				return -- unexpected type
			end
		end
		return true -- this table is just numbers so it is good
	end
end)

-- api
function mt_ped.__index:get_stat(stat) -- returns nil if the stat isn't supported
	net.basync.validate_ped(self,2)
	for i,v in ipairs(SYNCED) do
		if v == stat then
			return self.server.stats[i]
		end
	end
end
function _G.GameGetPedStat(ped,stat)
	return run(function()
		return ped:get_stat(stat)
	end)
end
function mt_ped.__index:set_stat(stat,value) -- returns false if the stat isn't supported
	net.basync.validate_ped(self,2)
	if type(value) ~= "number" then
		error("invalid value",2)
	end
	for i,v in ipairs(SYNCED) do
		if v == stat then
			self.server.stats[i] = value
			self.state:update_field("stats")
			return true
		end
	end
	return false
end
function _G.GameSetPedStat(ped,stat,value)
	return run(function()
		if type(value) == "number" then
			value = value ~= 0
		end
		return ped:set_stat(stat,value)
	end)
end
_G.PedOverrideStat = GameSetPedStat
