function main()
	for net_ped in net.basync.all_peds() do
		local ped = net_ped:get_ped()
		if net_ped:is_player() and PedIsValid(ped) and SoundSpeechPlaying(ped) then
			print("shut the fuck up "..net_ped:get_name())
			SoundStopCurrentSpeechEvent(ped)
		end
		Wait(0)
	end
end
