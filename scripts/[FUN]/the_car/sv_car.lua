local gVehicles = {}

function main()
	table.insert(gVehicles,VehicleCreateXYZ(290,193.575,6.883,5.454,164.3))
	table.insert(gVehicles,VehicleCreateXYZ(291,202.151,6.377,5.502,3.4))
	table.insert(gVehicles,VehicleCreateXYZ(297,198.894,-10.013,5.595,177.5))
end
RegisterNetworkEventHandler("the_car:hit_button",function(player)
	local ped = net.basync.get_player_ped(player)
	if PedIsValid(ped) and not PedIsInAnyVehicle(ped) then
		for _,veh in ipairs(gVehicles) do
			if VehicleIsValid(veh) then
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
	end
end)
function get_in(veh,ped,seat)
	if not veh:get_seat(seat) then
		PedWarpIntoCar(ped,veh,seat)
	end
end
