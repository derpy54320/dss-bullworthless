-- server movement
LoadScript("module.lua")

-- register
register_ped_field("throttle",0)

-- check
RegisterLocalEventHandler("basync:setPed",function(k,v)
	if k == "throttle" and type(v) == "number" then
		return true -- throttle is only valid when its value is a number
	end
end)

-- api
function mt_ped.__index:get_throttle()
	net.basync.validate_ped(self,2)
	return self.server.throttle
end
function _G.PedGetThrottle(ped)
	return run(function()
		return ped:get_throttle()
	end)
end
function mt_ped.__index:set_throttle(value) -- only really has a chance to take effect if the ped isn't owned
	net.basync.validate_ped(self,2)
	if type(value) ~= "number" then
		error("invalid throttle",2)
	end
	self.server.throttle = value
end
function _G.PedSetThrottle(ped,value)
	return run(function()
		ped:set_throttle(value)
	end)
end
