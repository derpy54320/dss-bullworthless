function main()
	while not SystemIsReady() do
		Wait(0)
	end
	while true do
		local target = PedGetTargetPed(gPlayer)
		if PedIsValid(target) and net.basync then
			local ped = net.basync.get_ped_by_ped(target)
			if ped then
				SetTextFont("Arial")
				SetTextBlack()
				SetTextColor(230,230,50,255)
				SetTextOutline()
				SetTextAlign("C","C")
				SetTextPosition(0.5,0.95)
				DrawText("["..ped:get_name().."]")
			end
		end
		Wait(0)
	end
end
