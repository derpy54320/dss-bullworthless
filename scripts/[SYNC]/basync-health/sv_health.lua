-- server health
LoadScript("module.lua")
LoadScript("health.lua")

-- state
function init_ped_hp(ped)
	local hp = PEDS[ped.server.model] or 100
	ped.server.dead = false
	ped.server.health = hp
	ped.server.max_hp = hp
end
if net.basync then
	for ped in net.basync.all_peds() do
		init_ped_hp(ped)
	end
end
RegisterLocalEventHandler("basync:initPed",init_ped_hp)
RegisterLocalEventHandler("ScriptShutdown",function(script)
	if net.basync and script == GetCurrentScript() then
		for ped in net.basync.all_peds() do
			ped.server.dead = nil
			ped.server.health = nil
			ped.server.max_hp = nil
		end
	end
end)

-- check
RegisterLocalEventHandler("basync:setPed",function(k,v)
	if k == "dead" then
		if type(v) == "boolean" then
			return true
		end
	elseif k == "health" then
		if type(v) == "number" then
			return true
		end
	elseif k == "max_hp" and type(v) == "number" and v > 0 then
		return true
	end
end)

-- normal api
function mt_ped.__index:is_dead()
	net.basync.validate_ped(self,2)
	return self.server.dead
end
function mt_ped.__index:get_health()
	net.basync.validate_ped(self,2)
	return self.server.health
end
function mt_ped.__index:get_max_health()
	net.basync.validate_ped(self,2)
	return self.server.max_hp
end
function mt_ped.__index:kill()
	net.basync.validate_ped(self,2)
	self.server.dead = true
	self.state:update_field("dead")
end
function mt_ped.__index:revive()
	net.basync.validate_ped(self,2)
	self.server.dead = false
	self.state:update_field("dead")
end
function mt_ped.__index:set_health(hp)
	net.basync.validate_ped(self,2)
	if type(hp) ~= "number" then
		error("invalid health",2)
	end
	self.server.health = hp
	self.state:update_field("health")
end
function mt_ped.__index:set_max_health(hp)
	net.basync.validate_ped(self,2)
	if type(hp) ~= "number" then
		error("invalid max health",2)
	elseif hp <= 0 then
		error("max health must be positive",2)
	end
	self.server.max_hp = hp
	self.state:update_field("max_hp")
end

-- global api
function _G.PedIsDead(ped)
	return run(function()
		return ped:is_dead()
	end)
end
function _G.PedApplyDamage(ped,hp)
	return run(function()
		hp = ped:get_health() - hp
		if hp < 0 then
			ped:set_health(0)
			ped:kill()
		else
			ped:set_health(hp)
		end
	end)
end
function _G.PedGetHealth(ped)
	return run(function()
		return ped:get_health()
	end)
end
function _G.PedGetMaxHealth(ped)
	return run(function()
		return ped:get_max_health()
	end)
end
function _G.PedSetHealth(ped,hp)
	return run(function()
		if hp > ped:get_max_health() then
			ped:set_max_health(hp)
		end
		ped:set_health(hp)
	end)
end
function _G.PedSetMaxHealth(ped,hp)
	return run(function()
		ped:set_max_health(hp)
	end)
end
