-- client flags
LoadScript("module.lua")
LoadScript("flags.lua")

-- events
RegisterLocalEventHandler("basync:getPed",function(ped,update)
	local flags = {}
	for i,v in ipairs(FLAGS) do
		flags[i] = PedGetFlag(ped.ped,v[1])
	end
	update.flags = flags
end)
RegisterLocalEventHandler("basync:setPed",function(ped)
	if not ped.state:is_owner() or ped.state:was_updated("flags") then
		for i,v in ipairs(FLAGS) do
			PedSetFlag(ped.ped,v[1],ped.server.flags[i])
		end
	end
end)

-- api
function mt_ped.__index:get_flag(flag) -- returns nil if the flag isn't supported
	net.basync.validate_ped(self,2)
	for i,v in ipairs(FLAGS) do
		if v[1] == flag then
			return self.server.flags[i]
		end
	end
end
