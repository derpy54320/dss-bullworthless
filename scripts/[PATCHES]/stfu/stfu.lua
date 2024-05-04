function main()
	for net_ped in net.basync.all_peds() do
		local ped = net_ped:get_ped()
		if net_ped:is_player() and PedIsValid(ped) and SoundSpeechPlaying(ped) then
			SoundStopAmbientSpeechEvent(ped)
		end
		Wait(0)
	end
end
