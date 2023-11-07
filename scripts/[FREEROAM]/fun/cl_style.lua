function main()
	while true do
		if PedMePlaying(gPlayer,"OFFENSE",true) then
			PedSetActionNode(gPlayer,"/G","")
		elseif PedMePlaying(gPlayer,"DEFAULT_KEY",true) then
			if PedIsPlaying(gPlayer,"/G/PLAYER/DEFAULT_KEY",true) then
				PedSetActionTree(gPlayer,"","")
			elseif IsButtonBeingPressed(6,0) then
				PedSetActionNode(gPlayer,"/G/PLAYER/ATTACKS/STRIKES/LIGHTATTACKS/LEFT1","")
			elseif IsButtonBeingPressed(7,0) then
				PedSetActionNode(gPlayer,"/G","")
			elseif IsButtonBeingPressed(15,0) then
				PedSetFlag(gPlayer,2,not PedGetFlag(gPlayer,2))
			end
		end
		Wait(0)
	end
end
