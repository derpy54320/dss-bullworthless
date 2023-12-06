-- client health
LoadScript("module.lua")

-- events
RegisterLocalEventHandler("basync:getPed",function(ped,update)
	if ped.killing and GetTimer() - ped.killing >= 5000 then
		ped.killing = nil
	end
	if not ped.killing and not ped.respawning then
		update.dead = PedIsDead(ped.ped)
	end
	update.health = PedGetHealth(ped.ped)
	update.max_hp = math.max(1,PedGetMaxHealth(ped.ped))
end)
RegisterLocalEventHandler("basync:setPed",function(ped)
	if not ped.state:is_owner() or ped.state:was_updated("dead") then
		if not ped.server.dead then
			if PedIsDead(ped.ped) then
				ped.respawning = true -- respawn the ped because that's the only way to make them not dead
			end
			ped.killing = nil
		elseif not PedIsDead(ped.ped) then
			PedSetHealth(ped.ped,0)
			if not PedIsPlaying(ped.ped,"/G/HITTREE",true) then
				PedApplyDamage(ped.ped,1) -- knock the ped out
				ped.killing = GetTimer()
			end
		end
	end
end)
RegisterLocalEventHandler("basync:setPed",function(ped)
	if not ped.state:is_owner() or ped.state:was_updated("health") then
		if ped.ped == gPlayer then
			PlayerSetHealth(ped.server.health)
		else
			PedSetHealth(ped.ped,ped.server.health)
		end
	end
end)
RegisterLocalEventHandler("basync:setPed",function(ped)
	if not ped.state:is_owner() or ped.state:was_updated("max_hp") then
		PedSetMaxHealth(ped.ped,ped.server.max_hp)
	end
end)

-- cleanup
function MissionCleanup()
	PedSetMaxHealth(gPlayer,200)
	PlayerSetHealth(200)
end

-- api
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
