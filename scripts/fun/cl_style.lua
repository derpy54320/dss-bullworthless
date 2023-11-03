function main()
	local player = false
	if PedGetAmmoCount(gPlayer,437) < 1 then
		GiveWeaponToPlayer(437,1)
	end
	while true do
		if IsKeyBeingPressed("G",0) then
			if player then
				PedSetActionTree(gPlayer,"","")
			end
			player = not player
		end
		if player and PedGetWeapon(gPlayer) == -1 and PedMePlaying(gPlayer,"DEFAULT_KEY",true) and not PedIsPlaying(gPlayer,"/G/PLAYER",true) then
			PedSetActionTree(gPlayer,"/Global/Player","Act/Player.act")
		elseif IsButtonBeingPressed(8,0) and PedIsPlaying(gPlayer,"/G/PLAYER/JUMPACTIONS/JUMP",true) and (PedMePlaying(gPlayer,"RUNJUMP",true) or PedMePlaying(gPlayer,"SPRINTJUMP",true)) then
			PlayerSetPosSimple(PedGetOffsetInWorldCoords(gPlayer,0,1,0))
		end
		Wait(0)
	end
end
