local gPlayers = {}
local gChallenge

-- player init
RegisterLocalEventHandler("PlayerDropped",function(player)
	gPlayers[player] = nil
	if gChallenge[player] then
		gChallenge[player] = nil
		update_challenge()
	end
end)
RegisterNetworkEventHandler("skate:initPlayer",function(player)
	gPlayers[player] = true
end)

-- start challenge
RegisterNetworkEventHandler("skate:startChallenge",function(player)
	if not gChallenge and gPlayers[player] then
		local area,h = 0,-165
		local count,total = 0,-1
		local x1,y1,z1 = 558.3,73.4,14.5
		local x2,y2,z2 = 565.6,75.3,14.5
		local dx,dy,dz = x2-x1,y2-y1,z2-z1
		gChallenge = {}
		for _ in pairs(gPlayers) do
			total = total + 1
		end
		for p in pairs(gPlayers) do
			local ratio = count / total
			gChallenge[p] = {ready = false,playing = true,score = 0}
			SendNetworkEvent(p,"skate:getReady",area,x1+dx*ratio,y1+dy*ratio,z1+dz*ratio,h)
			count = count + 1
		end
		if not next(gChallenge) then
			gChallenge = nil
		end
	end
end)
RegisterNetworkEventHandler("skate:imReady",function(player)
	local state = gChallenge[player]
	if state then
		state.ready = true
		for _,other in pairs(gChallenge) do
			if not other.ready then
				return
			end
		end
		CreateThread(function()
			for i = 3,0,-1 do
				for p in pairs(gChallenge) do
					if i == 0 then
						SendNetworkEvent(p,"skate:showText","GO!",3000)
					else
						SendNetworkEvent(p,"skate:showText",i,3000)
						Wait(1000)
					end
				end
			end
			for p in pairs(gChallenge) do
				SendNetworkEvent(p,"skate:startChallenge")
				for c in pairs(gChallenge) do
					SendNetworkEvent(p,"skate:startPlayer",c,GetPlayerName(c))
				end
			end
		end)
	end
end)
RegisterNetworkEventHandler("skate:imDone",function(player,score)
	local state = gChallenge[player]
	if state and type(score) == "number" and score > 0 then
		for p in pairs(gChallenge) do
			SendNetworkEvent(p,"skate:finishPlayer",player,score)
			SendNetworkEvent(p,"skate:showText",GetPlayerName(player).." finished!",3000)
		end
		state.score = math.floor(score)
		state.playing = false
		update_challenge()
	end
end)

-- update challenge
function update_challenge()
	local winner,biggest
	for _,data in pairs(gChallenge) do
		if data.playing then
			return
		end
	end
	for player,data in pairs(gChallenge) do
		if data.playing then
			winner,biggest = player,data.score
			break
		elseif not winner or data.score > biggest then
			winner,biggest = player,data.score
		end
	end
	if winner then
		local text = GetPlayerName(winner).." won with a time of "..get_time(biggest).."!"
		for p in pairs(gChallenge) do
			SendNetworkEvent(p,"skate:showText",text,8000)
		end
	end
	for p in pairs(gChallenge) do
		SendNetworkEvent(p,"skate:finishChallenge",text,8000)
	end
	gChallenge = nil
end
function get_time(ms)
	local s = math.floor(ms / 1000)
	local m = math.floor(s / 60)
	if m == 0 then
		return s
	elseif s < 10 then
		return m..":0"..math.mod(s,60)
	end
	return m..":"..math.mod(s,60)
end
