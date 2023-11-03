function main()
	local player = false
	if PedGetAmmoCount(gPlayer,437) < 1 then
		GiveWeaponToPlayer(437,1)
	end
	while true do
		if (IsKeyBeingPressed("G",0) or IsKeyBeingPressed("G",1)) and PedMePlaying(gPlayer,"DEFAULT_KEY",true) then
			if player then
				PedSetActionTree(gPlayer,"","")
			end
			player = not player
		end
		if player and PedGetWeapon(gPlayer) == -1 and PedMePlaying(gPlayer,"DEFAULT_KEY",true) and not PedIsPlaying(gPlayer,"/G/PLAYER",true) then
			PedSetActionTree(gPlayer,"/Global/Player","Act/Player.act")
		end
		Wait(0)
	end
end
