--[[ BASYNC MODULE: PED STATS
	
	summary:
		this module syncs ped throttle when peds are playing DEFAULT_KEY
	
	shared:
		ped:get_throttle() | returns the ped's throttle value
	
]]

-- .throttle
module = create_module("throttle",0)
module:require_type("number")
module:get_func(function(ped)
	if PedMePlaying(ped.ped,"DEFAULT_KEY",true) then
		return PedGetThrottle(ped.ped)
	end
	return 0
end)
RegisterLocalEventHandler("PedUpdateThrottle",function(actual_ped)
	local ped = basync.get_ped_by_ped(actual_ped)
	if ped and ped.state and not ped.state:is_owner() then
		PedSetThrottle(actual_ped,ped.server.throttle)
	end
end)

-- shared methods
function mod_shared:get_throttle()
	validate_ped(self,2)
	return self.server.throttle
end
