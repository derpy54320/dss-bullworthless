-- server gravity
LoadScript("module.lua")

-- register
register_ped_field("gravity",true)

-- check
RegisterLocalEventHandler("basync:setPed",function(k,v)
	if k == "gravity" and type(v) == "boolean" then
		return true
	end
end)

-- api
function mt_ped.__index:get_gravity()
	net.basync.validate_ped(self,2)
	return self.server.gravity
end
function _G.PedGetEffectedByGravity(ped)
	return run(function()
		return ped:get_gravity()
	end)
end
function mt_ped.__index:set_gravity(affected)
	net.basync.validate_ped(self,2)
	if type(affected) ~= "boolean" then
		error("invalid gravity state",2)
	end
	self.server.gravity = affected
	self.state:update_field("gravity")
end
function _G.PedSetEffectedByGravity(ped,affected)
	return run(function()
		ped:set_gravity(affected)
	end)
end
