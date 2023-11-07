local gVehicle

function main()
	gVehicle = VehicleCreateXYZ(math.random(272,298),193.604,5.811,5.452,-166.9)
	ClockSet(9,0)
end
RegisterNetworkEventHandler("the_car:hit_button",function(player)
	local ped = net.basync.get_player_ped(player)
	if PedIsValid(ped) and VehicleIsValid(gVehicle) and not PedIsInAnyVehicle(ped) then
		local x1,y1,z1,h = gVehicle:get_position()
		local x2,y2,z2 = ped:get_position()
		local dx,dy,dz = x2-x1,y2-y1,z2-z1
		if dx*dx+dy*dy+dz*dz < 3 * 3 then
			local angle = math.atan2(-dx,dy) - math.pi / 2 - math.rad(h)
			angle = math.mod(angle,math.pi*2)
			while angle > math.pi do
				angle = angle - math.pi * 2
			end
			while angle <= -math.pi do
				angle = angle + math.pi * 2
			end
			if math.abs(angle) <= math.rad(90) then
				get_in(gVehicle,ped,0)
			else
				get_in(gVehicle,ped,1)
			end
		end
	end
end)
function get_in(veh,ped,seat)
	if not veh:get_seat(seat) then
		PedWarpIntoCar(ped,veh,seat)
	end
end
