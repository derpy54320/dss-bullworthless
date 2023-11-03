function main()
	while true do
		if PlayerIsInAreaXYZ(-711.54,372.19,293.91,1) and PedMePlaying(gPlayer,"Default_KEY",true) then
			if IsButtonBeingPressed(8,0) then
				PlayerSetPosSimple(-710,379,295)
			else
				SetTextFont("Comic Sans MS")
				SetTextBold()
				SetTextPosition(0.5,0.95)
				SetTextColor(255,255,255,255)
				DrawText("Press JUMP to get in the ring.")
			end
		end
		Wait(0)
	end
end
