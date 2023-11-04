RegisterLocalEventHandler("PlayerSleepCheck",function()
	return true
end)
function main()
	while not SystemIsReady() do
		Wait(0)
	end
	while true do
		if PlayerGetPhysicalState() ~= 0 then
			PlayerChangePhysicalState(0)
		end
		Wait(0)
	end
end
