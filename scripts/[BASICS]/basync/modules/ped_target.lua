--[[ BASYNC MODULE: PED STATS
	
	summary:
		this module syncs peds' targets
	
	shared:
		ped:get_target()   | returns the ped's target ped if it is valid
	
]]

-- .target
module = create_module("target",100)
module:require_type("number")
module:get_func(function(ped)
	local target = basync.get_ped_by_ped(PedGetTargetPed(ped.ped))
	if target then
		return target.id
	end
	return 0
end)
module:set_func(function(ped,id)
	if not ped.state:is_owner() then
		local target = basync.get_ped_from_server(id)
		if target and PedIsValid(target.ped) then
			if PedGetTargetPed(ped.ped) ~= target.ped then
				PedLockTarget(ped.ped,target.ped,3)
			end
		elseif PedGetTargetPed(ped.ped) ~= -1 then
			PedLockTarget(ped.ped,-1)
		end
	end
end)

-- shared methods
function mod_shared:get_target()
	validate_ped(self,2)
	if self.server.target then
		local ped = basync.get_ped_from_player(self.state.owner,self.server.target)
		if ped then
			return ped
		end
	end
end
