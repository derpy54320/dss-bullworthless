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
		elseif PedMePlaying(gPlayer,"DEFAULT_KEY",true) and check_action_tree() then
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
function check_action_tree()
	for _,v in ipairs(gOverrides) do
		if PedIsPlaying(gPlayer,v[1],true) then
			PedSetActionTree(gPlayer,v[2],v[3])
			return false
		end
	end
	return true
end
gOverrides = {
	{"/G/PLAYER","",""},
	{"/G/CV_MALE_A","/GLOBAL/GS_MALE_A","ACT/ANIM/GS_MALE_A.ACT"},
}
