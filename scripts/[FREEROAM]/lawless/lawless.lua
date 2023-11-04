function main()
	while not SystemIsReady() do
		Wait(0)
	end
	while true do
		if PlayerGetPunishmentPoints() > 200 then
			PlayerSetPunishmentPoints(200)
		end
		Wait(0)
	end
end
