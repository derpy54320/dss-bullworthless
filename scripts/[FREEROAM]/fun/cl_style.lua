function main()
	while true do
		if PedMePlaying(gPlayer,"OFFENSE",true) then
			PedSetActionNode(gPlayer,"/G","")
		elseif PedMePlaying(gPlayer,"DEFAULT_KEY",true) then
			if PedIsPlaying(gPlayer,"/G/PLAYER/DEFAULT_KEY",true) then
				PedSetActionTree(gPlayer,"","")
			elseif IsButtonBeingPressed(6,0) then
				if PedMePlaying(gPlayer,"SPRINT",true) then
					PedSetActionNode(gPlayer,"/G/PLAYER/ATTACKS/STRIKES/RUNNINGATTACKS/HEAVYATTACKS","")
				else
					PedSetActionNode(gPlayer,"/G/PLAYER/ATTACKS/STRIKES/LIGHTATTACKS/LEFT1","")
				end
			elseif IsButtonBeingPressed(7,0) then
				PedSetActionNode(gPlayer,"/G","")
			elseif IsButtonBeingPressed(9,0) then
				local x,y,z = PlayerGetPosXYZ()
				if PedFindInAreaXYZ(x,y,z,3) then
					PedSetActionNode(gPlayer,"/G/ACTIONS/GRAPPLES/FRONT/GRAPPLES/GRAPPLEATTEMPT","")
				end
			elseif IsButtonBeingPressed(15,0) then
				PedSetFlag(gPlayer,2,not PedGetFlag(gPlayer,2))
			end
		end
		Wait(0)
	end
end
