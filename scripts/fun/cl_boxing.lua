function main()
	while true do
		if PedMePlaying(gPlayer,"Default_KEY",true) then
			if PlayerIsInAreaXYZ(-711.54,372.19,293.91,1) then
				if IsButtonBeingPressed(8,0) then
					PlayerSetPosSimple(PlayerGetPosXYZ(),374,295)
				else
					SetTextFont("Comic Sans MS")
					SetTextBold()
					SetTextPosition(0.5,0.95)
					SetTextColor(255,255,255,255)
					DrawText("Press JUMP to get in the ring.")
				end
			elseif PlayerIsInAreaXYZ(-711.54,374,295,1) then
				if IsButtonBeingPressed(8,0) then
					PlayerSetPosSimple(PlayerGetPosXYZ(),372.19,293.91)
				else
					SetTextFont("Comic Sans MS")
					SetTextBold()
					SetTextPosition(0.5,0.95)
					SetTextColor(255,255,255,255)
					DrawText("Press JUMP to get out the ring.")
				end
			end
		end
		Wait(0)
	end
end
