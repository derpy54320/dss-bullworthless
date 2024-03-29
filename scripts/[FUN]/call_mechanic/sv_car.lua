gVehicles = {}

function main()
	table.insert(gVehicles,VehicleCreateXYZ(290,193.575,6.883,5.454,164.3))
	table.insert(gVehicles,VehicleCreateXYZ(291,202.151,6.377,5.502,3.4))
	table.insert(gVehicles,VehicleCreateXYZ(297,198.894,-10.013,5.595,177.5))
	table.insert(gVehicles,VehicleCreateXYZ(286,496.918,-204.536,4.174,4.9))
	table.insert(gVehicles,VehicleCreateXYZ(285,526.072,504.845,19.615,86.6))
	table.insert(gVehicles,VehicleCreateXYZ(287,511.537,505.133,19.615,97.6))
	table.insert(gVehicles,VehicleCreateXYZ(298,518.221,496.925,19.615,-2.3))
end
RegisterNetworkEventHandler("the_car:spawn_car",function(player,model,area,x,y,z)
	local car = net.basync.create_vehicle(model)
	car:set_position(x,y,z)
	car:set_area(area)
end)
RegisterNetworkEventHandler("the_car:hit_button",function(player)
	local ped = net.basync.get_player_ped(player)
	if PedIsValid(ped) and not PedIsInAnyVehicle(ped) then
		for veh in net.basync.all_vehicles() do
			local x1,y1,z1,h = veh:get_position()
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
					get_in(veh,ped,0)
				else
					get_in(veh,ped,1)
				end
				break
			end
		end
	end
end)
function get_in(veh,ped,seat)
	if not veh:get_seat(seat) then
		PedWarpIntoCar(ped,veh,seat)
		return
	end
	for seat = 0,4 do
		if not veh:get_seat(seat) then
			PedWarpIntoCar(ped,veh,seat)
			break
		end
	end
end
