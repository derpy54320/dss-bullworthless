-- SYNC: mission shit
s = GetScriptSharedTable()

RegisterNetworkEventHandler("sync:printedText",function(player,...)
	if player == s.leader then
		for id in pairs(s.players) do
			if id ~= player then
				SendNetworkEvent(id,"sync:printText",unpack(arg))
			end
		end
	end
end)
