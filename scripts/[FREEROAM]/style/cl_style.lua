function MissionCleanup()
	PedSetActionTree(gPlayer,"","")
end
function main()
	local thread
	while not SystemIsReady() do
		Wait(0)
	end
	while true do
		if PedIsModel(gPlayer,0) then
			if thread then
				PedSetActionTree(gPlayer,"","")
				TerminateThread(thread)
				thread = nil
			end
		elseif not thread then
			thread = CreateThread(custom_style)
		end
		Wait(0)
	end
end
function custom_style()
	while true do
		if PedMePlaying(gPlayer,"OFFENSE",true) then
			PedSetActionNode(gPlayer,"/G","")
		elseif PedMePlaying(gPlayer,"DEFAULT_KEY",true) then
			for _,v in ipairs(gOverrides) do
				if PedIsPlaying(gPlayer,v[1],true) then
					reset_action_tree()
					break
				end
			end
			if IsButtonBeingPressed(6,0) then
				if PedMePlaying(gPlayer,"SPRINT",true) then
					PedSetActionNode(gPlayer,"/G/PLAYER/ATTACKS/STRIKES/RUNNINGATTACKS/HEAVYATTACKS","")
				else
					PedSetActionNode(gPlayer,"/G/PLAYER/ATTACKS/STRIKES/LIGHTATTACKS/LEFT1","")
				end
			elseif IsButtonBeingPressed(7,0) then
				PedSetActionNode(gPlayer,"/G","")
			elseif IsButtonBeingPressed(9,0) and PedIsValid(PedGetTargetPed(gPlayer)) then
				PedSetActionNode(gPlayer,"/G/ACTIONS/GRAPPLES/FRONT/GRAPPLES/GRAPPLEATTEMPT","")
			elseif IsButtonBeingPressed(15,0) then
				PedSetFlag(gPlayer,2,not PedGetFlag(gPlayer,2))
			end
		end
		Wait(0)
	end
end
function reset_action_tree()
	PedSetActionTree(gPlayer,"","") -- restore default *then* apply an override if needed
	for _,v in ipairs(gOverrides) do
		if v[2] and PedIsPlaying(gPlayer,v[1],true) then
			PedSetActionTree(gPlayer,v[2],"")
			break
		end
	end
end
gOverrides = {
	{"/G/PLAYER"},
	{"/G/CV_MALE_A","/G/GN_MALE_A"},
}
