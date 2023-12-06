-- client movement
LoadScript("module.lua")

-- events
RegisterLocalEventHandler("basync:getPed",function(ped,update)
	if PedMePlaying(ped.ped,"DEFAULT_KEY",true) then -- ped is always valid during a basync:getPed event
		update.throttle = PedGetThrottle(ped.ped)
	else
		update.throttle = 0 -- don't care about the throttle when not playing DEFAULT_KEY
	end
end)
RegisterLocalEventHandler("PedUpdateThrottle",function(real)
	if net.basync then
		local ped = net.basync.get_ped_from_ped(real)
		if ped and ped.state and not ped.state:is_owner() then
			if PedMePlaying(real,"DEFAULT_KEY",true) then
				PedSetThrottle(real,ped.server.throttle) -- an unowned network ped, let's sync their throttle
			else
				PedSetThrottle(real,0) -- unless they're not playing DEFAULT_KEY, then we don't care
			end
		end
	end
end)

-- api
function mt_ped.__index:get_throttle()
	net.basync.validate_ped(self,2)
	return self.server.throttle
end
