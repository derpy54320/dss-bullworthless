-- server ped targets
LoadScript("module.lua")

-- register
register_ped_field("target_ped",0) -- the client will make un-owned peds lock onto their target
register_ped_field("grapple_ped",0) -- the client does nothing with grapple targets (it's just synced so the server can know)

-- dereference
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

-- check
RegisterLocalEventHandler("basync:setPed",function(k,v)
	if (k == "target_ped" or k == "grapple_ped") and type(v) == "number" and math.floor(v) == v then
		return true
	end
end)

-- api
function mt_ped.__index:get_target_ped()
	net.basync.validate_ped(self,2)
	return net.basync.get_ped_from_player(self.server.target_ped)
end
function _G.PedGetTargetPed(ped)
	return run(function()
		return ped:get_target_ped()
	end)
end
function mt_ped.__index:set_target_ped(target) -- useless when the ped has an owner
	net.basync.validate_ped(self,2)
	if not net.basync.is_ped_valid(target) then
		error("invalid target",2)
	end
	self.server.target_ped = target.id
end
function _G.PedLockTarget(ped,target)
	return run(function()
		ped:set_target_ped(target)
	end)
end
function mt_ped.__index:get_grapple_target_ped()
	net.basync.validate_ped(self,2)
	return net.basync.get_ped_from_player(self.server.grapple_ped)
end
function _G.PedGetGrappleTargetPed(ped)
	return run(function()
		return ped:get_grapple_target_ped()
	end)
end
