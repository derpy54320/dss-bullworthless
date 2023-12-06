-- client stats
LoadScript("module.lua")
LoadScript("stats.lua")

-- events
RegisterLocalEventHandler("basync:getPed",function(ped,update)
	local stats = {}
	for i,v in ipairs(SYNCED) do
		stats[i] = GameGetPedStat(ped.ped,v)
	end
	update.stats = stats
end)
RegisterLocalEventHandler("basync:setPed",function(ped)
	if not ped.state:is_owner() or ped.state:was_updated("stats") then
		for i,v in ipairs(SYNCED) do
			GameSetPedStat(ped.ped,v,ped.server.stats[i])
		end
	end
end)
RegisterLocalEventHandler("PedStatOverriding",function(real,stat,value)
	for i,v in ipairs(SYNCED) do
		if v == stat then
			if net.basync then
				local ped = net.basync.get_ped_from_ped(real)
				if ped and not ped:is_owner() and ped.server.stats[i] ~= value then
					return true
				end
			end
			break
		end
	end
end)

-- cleanup
function MissionCleanup()
	PedSetStatsType(gPlayer,"STAT_PLAYER")
end

-- api
function mt_ped.__index:get_stat(stat) -- returns nil if the stat isn't supported
	net.basync.validate_ped(self,2)
	for i,v in ipairs(SYNCED) do
		if v == stat then
			return self.server.stats[i]
		end
	end
end
