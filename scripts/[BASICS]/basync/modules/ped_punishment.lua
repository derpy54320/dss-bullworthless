--[[ BASYNC MODULE: PED PUNISHMENT
	
	summary:
		this module syncs player punishment levels (peds are just left alone)
	
	shared:
		ped:get_punishment_points()       | returns the ped's punishment points
	
	server:
		ped:set_punishment_points(points) | set the ped's punishment points
	
]]

-- .punish
module = create_module("punish",0)
module:require_type("number")
module:check_func(function(value)
	return value >= 0 and value <= 300
end)
module:get_func(function(ped)
	if ped.ped == gPlayer then
		return PlayerGetPunishmentPoints()
	end
end)
module:set_func(function(ped,value)
	if not ped.state:is_owner() or ped.state:was_updated("punish") then
		if ped.ped == gPlayer then
			PlayerSetPunishmentPoints(value)
		elseif ped.type == "player" then
			PedSetPunishmentPoints(value)
		end
	end
end)

-- shared methods
function mod_shared:get_punishment_points()
	validate_ped(self,2)
	return self.server.punish
end

-- server methods
function mod_server:set_punishment_points(value)
	validate_ped(self,2)
	if self.type == "player" then
		self.server.punish = value
		self.state:update_field("punish")
	end
end
