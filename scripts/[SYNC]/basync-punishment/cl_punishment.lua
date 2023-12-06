-- client punishment
LoadScript("module.lua")

-- events
RegisterLocalEventHandler("basync:getPed",function(ped,update)
	if ped.ped == gPlayer then
		update.trouble = PlayerGetPunishmentPoints()
	end
end)
RegisterLocalEventHandler("basync:setPed",function(ped)
	if ped.server.trouble ~= -1 and (not ped.state:is_owner() or ped.state:was_updated("trouble")) then
		PedSetPunishmentPoints(ped.ped,ped.server.trouble)
	end
end)

-- api
function mt_ped.__index:get_punishment_points()
	net.basync.validate_ped(self,2)
	return self.server.trouble
end
