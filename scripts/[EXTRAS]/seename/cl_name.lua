function main()
	while not SystemIsReady() do
		Wait(0)
	end
	while true do
		local target = PedGetTargetPed(gPlayer)
		if PedIsValid(target) and net.basync then
			local ped = net.basync.get_ped_by_ped(target)
			if ped then
				local name = get_name(ped)
				SetTextFont("Arial")
				SetTextBlack()
				SetTextColor(230,230,50,255)
				SetTextOutline()
				SetTextAlign("C","C")
				SetTextPosition(0.5,0.95)
				DrawText("["..name.."]")
			end
		end
		Wait(0)
	end
end
function get_name(ped)
	if not ped:is_player() then
		local real = ped:get_ped()
		if PedIsValid(real) then
			local name = PedGetName(real)
			local localized = GetLocalizedText(name)
			if localized then
				return localized
			end
			return string.sub(localized,3)
		end
	end
	return ped:get_name()
end
