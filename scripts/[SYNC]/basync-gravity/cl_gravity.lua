-- client gravity
LoadScript("module.lua")

-- events
RegisterLocalEventHandler("basync:getPed",function(ped,update)
	update.gravity = PedGetFlag(ped.ped,1) -- if on the ground
end)
RegisterLocalEventHandler("basync:setPed",function(ped)
	if ped.state:was_updated("gravity") then
		PedSetEffectedByGravity(ped.ped,ped.server.gravity) -- just set it because it was updated
	elseif not ped.state:is_owner() then
		PedSetEffectedByGravity(ped.ped,ped.server.gravity and not PedIsPlaying(ped.ped,"/G/HITTREE",true)) -- an unowned ped
	elseif ped.netbasics then
		PedSetEffectedByGravity(ped.ped,true) -- we're claiming ownership so turn on gravity
	end
end)

-- cleanup
function MissionCleanup()
	PedSetEffectedByGravity(gPlayer,true)
end

-- api
function mt_ped.__index:get_gravity()
	net.basync.validate_ped(self,2)
	return self.server.gravity
end
