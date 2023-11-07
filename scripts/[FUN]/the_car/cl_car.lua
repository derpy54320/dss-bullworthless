function main()
	while not SystemIsReady() do
		Wait(0)
	end
	while true do
		if IsButtonBeingPressed(9,0) and PedMePlaying(gPlayer,"DEFAULT_KEY",true) then
			SendNetworkEvent("the_car:hit_button")
		end
		Wait(0)
	end
end
