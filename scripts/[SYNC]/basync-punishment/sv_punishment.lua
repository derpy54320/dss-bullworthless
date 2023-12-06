-- server punishment
LoadScript("module.lua")

-- register
register_ped_field("trouble",0)

-- check
RegisterLocalEventHandler("basync:setPed",function(k,v)
	if k == "trouble" and type(v) == "number" and v >= 0 then
		return true -- allow if setting punishment to a number
	end
end)

-- api
function mt_ped.__index:get_punishment_points()
	net.basync.validate_ped(self,2)
	return self.server.trouble
end
function _G.PedGetPunishmentPoints(ped)
	return run(function()
		return ped:get_punishment_points()
	end)
end
function mt_ped.__index:set_punishment_points(points)
	net.basync.validate_ped(self,2)
	if type(points) ~= "number" or points < 0 then
		error("invalid points",2)
	end
	self.server.trouble = points
	self.state:update_field("trouble")
end
function _G.PedSetPunishmentPoints(ped,points)
	return run(function()
		ped:set_punishment_points(points)
	end)
end
