-- client ped targets
LoadScript("module.lua")

-- events
RegisterLocalEventHandler("basync:deletedPed",function(ped)
	local id = ped.id
	for other in net.basync.all_peds() do
		if other.server.target_ped == id then
			other.server.target_ped = 0 -- remove references to the deleted ped
		end
		if other.server.grapple_ped == id then
			other.server.grapple_ped = 0
		end
	end
end)
RegisterLocalEventHandler("basync:getPed",function(ped,update)
	local target = net.basync.get_ped_from_ped(PedGetTargetPed(ped.ped))
	local grapple = net.basync.get_ped_from_ped(PedGetGrappleTargetPed(ped.ped))
	if target then
		update.target_ped = target.id
	else
		update.target_ped = 0
	end
	if grapple then
		update.grapple_ped = grapple.id
	else
		update.grapple_ped = 0
	end
end)
RegisterLocalEventHandler("basync:setPed",function(ped)
	if not ped.state:is_owner() then
		local target = net.basync.get_ped_from_server(ped.server.target_ped)
		if target then
			if PedIsValid(target.ped) and PedGetTargetPed(ped.ped) ~= target.ped then
				PedLockTarget(ped.ped,target.ped) -- an un-owned ped has a valid target
				ped.locked_target = true
			end
		elseif PedGetTargetPed(ped.ped) ~= -1 then
			PedLockTarget(ped.ped,-1) -- an un-owned ped has no target
			ped.locked_target = nil
		end
	elseif ped.locked_target then
		PedLockTarget(ped.ped,-1) -- reset the ped since they're owned now
		ped.locked_target = nil
	end
end)

-- api
function mt_ped.__index:get_target_ped()
	net.basync.validate_ped(self,2)
	return net.basync.get_ped_from_server(self.server.target_ped)
end
function mt_ped.__index:get_grapple_target_ped()
	net.basync.validate_ped(self,2)
	return net.basync.get_ped_from_server(self.server.grapple_ped)
end
