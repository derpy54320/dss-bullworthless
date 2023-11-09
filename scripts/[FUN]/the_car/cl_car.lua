gBlip = -1
gAdded = 0

RegisterLocalEventHandler("menu:openMain",function(add)
	add("Call Mechanic","\"I'm Johnny on the spot! Need some wheels?",M_SpawnVehicle)
end)
function main()
	while not SystemIsReady() do
		Wait(0)
	end
	while true do
		if IsButtonBeingPressed(9,0) and PedMePlaying(gPlayer,"DEFAULT_KEY",true) then
			SendNetworkEvent("the_car:hit_button")
		end
		if gBlip ~= -1 and GetTimer() - gAdded >= 15000 then
			BlipRemove(gBlip)
			gBlip = -1
		end
		Wait(0)
	end
end
function MissionCleanup()
	if gBlip ~= -1 then
		BlipRemove(gBlip)
	end
end
function M_SpawnVehicle()
	local cars = {275,276,284,285,286,288,289,290,291,292,293,294,295,296,297,298}
	local menu = net.menu.create("Call Mechanic","Call in a car from your non-existant garage.")
	while menu:active() do
		for _,m in ipairs(cars) do
			if menu:option(VEHICLE_MODELS[m]) then
				local x,y,z = VehicleFindRandomSpawnPosition()
				if x == 9999 then
					menu:alert("Sorry, your car isn't available right now.",3)
				elseif PlayerGetMoney() < 5000 then
					menu:alert("You don't have enough money for a car.",3)
				else
					SendNetworkEvent("the_car:spawn_car",m,AreaGetVisible(),x,y,z)
					SoundPlay2D("BuyItem")
					PlayerAddMoney(-5000)
					if gBlip ~= -1 then
						BlipRemove(gBlip)
					end
					gBlip = BlipAddXYZ(x,y,z,4,0,1)
					gAdded = GetTimer()
					return
				end
				break
			end
		end
		menu:draw()
		Wait(0)
	end
end
VEHICLE_MODELS = {
	[272] = "bmxrace",[273] = "retro",[274] = "crapbmx",[275] = "bikecop",[276] = "Scooter",[277] = "bike",[278] = "custombike",
	[279] = "banbike",[280] = "mtnbike",[281] = "oladbike",[282] = "racer",[283] = "aquabike",[284] = "Mower",[285] = "Arc_3",
	[286] = "taxicab",[287] = "Arc_2",[288] = "Dozer",[289] = "GoCart",[290] = "Limo",[291] = "Dlvtruck",[292] = "Foreign",
	[293] = "cargreen",[294] = "70wagon",[295] = "policecar",[296] = "domestic",[297] = "Truck",[298] = "Arc_1"
}
