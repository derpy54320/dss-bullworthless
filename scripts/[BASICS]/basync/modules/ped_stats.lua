--[[ BASYNC MODULE: PED STATS
	
	summary:
		this module syncs various ped stats
	
	shared:
		ped:get_max_health()   | returns the ped's max health
		ped:get_health()       | returns the ped's health
		ped:get_speed()        | returns the ped's speed
		ped:is_dead()          | returns if the ped is dead
	
	server:
		ped:set_max_health(hp) | set the ped's max health (must be > 0)
		ped:set_health(hp)     | set the ped's health
		ped:set_speed(factor)  | set the ped's speed (100 is normal)
		ped:kill()             | instantly knock the ped out
	
]]

-- .maxhp
module = create_module("maxhp",100)
module:require_type("number")
module:check_func(function(value)
	return value > 0
end)
module:get_func(function(ped)
	return math.max(1,PedGetMaxHealth(ped.ped))
end)
module:set_func(function(ped,value)
	if not ped.state:is_owner() or ped.state:was_updated("maxhp") then
		PedSetMaxHealth(ped.ped,value)
		if PedGetHealth(ped.ped) > value then
			PedSetHealth(ped.ped,value)
		end
	end
end)

-- .hp
module = create_module("hp",100)
module:require_type("number")
module:get_func(function(ped)
	return PedGetHealth(ped.ped)
end)
module:set_func(function(ped,value)
	if not ped.state:is_owner() or ped.state:was_updated("hp") then
		PedSetHealth(ped.ped,math.min(value,ped.server.maxhp))
	end
end)

-- .speed
module = create_module("speed",100)
module:require_type("number")
module:check_func(function(value)
	return value >= 0
end)
module:get_func(function(ped)
	return math.max(0,GameGetPedStat(ped.ped,20))
end)
module:set_func(function(ped,value)
	if not ped.state:is_owner() or ped.state:was_updated("speed") then
		GameSetPedStat(ped.ped,20,value)
	end
end)

-- .dead
module = create_module("dead",false)
module:require_type("boolean")
module:get_func(function(ped)
	return PedIsDead(ped.ped)
end)
module:set_func(function(ped,value)
	if value and (ped.state:was_updated("dead") or not (ped.state:is_owner() or PedIsDead(ped.ped) or PedIsPlaying(ped.ped,"/G/HITTREE",true))) then
		PedSetHealth(ped.ped,0)
		PedApplyDamage(ped.ped,1)
	end
end)

-- shared methods
function mod_shared:get_max_health()
	validate_ped(self,2)
	return self.server.maxhp
end
function mod_shared:get_health()
	validate_ped(self,2)
	return self.server.hp
end
function mod_shared:get_speed()
	validate_ped(self,2)
	return self.server.speed
end
function mod_shared:is_dead()
	validate_ped(self,2)
	return self.server.dead
end

-- server methods
function mod_server:set_max_health(value)
	validate_ped(self,2)
	self.server.maxhp = value
	self.state:update_field("maxhp")
end
function mod_server:set_health(value)
	validate_ped(self,2)
	self.server.hp = value
	self.state:update_field("hp")
end
function mod_server:set_speed(value)
	validate_ped(self,2)
	self.server.speed = value
	self.state:update_field("speed")
end
function mod_server:kill()
	validate_ped(self,2)
	self.server.dead = true
	self.state:update_field("dead")
end
