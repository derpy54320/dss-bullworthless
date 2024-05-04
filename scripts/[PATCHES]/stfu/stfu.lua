function main()
	while true do
		for net_ped in net.basync.all_peds() do
			local ped = net_ped:get_ped()
			if net_ped:is_player() and PedIsValid(ped) and SoundSpeechPlaying(ped) then
				SoundStopCurrentSpeechEvent(ped)
			end
		end
		Wait(0)
	end
end
