-- SYNC: client players
s = GetScriptSharedTable()

-- shared:
s.players = {}
s.player = -1
s.leader = false

-- globals:
gList = {}
gLeader = -1

-- events:
RegisterNetworkEventHandler("sync:addPlayer",function(id,name)
	if name then
		s.players[id] = name
	else
		s.players[id] = GetPlayerName(id)
		s.player = id
	end
	F_UpdateList()
end)
RegisterNetworkEventHandler("sync:removePlayer",function(id)
	if id == s.player then
		error("tried to remove local player")
	end
	s.players[id] = nil
	F_UpdateList()
end)
RegisterNetworkEventHandler("sync:setLeader",function(id)
	s.leader = id == s.player
	gLeader = id
end)

-- utility:
function F_UpdateList()
	gList = {}
	for id,name in pairs(s.players) do
		table.insert(gList,{id,name})
	end
	table.sort(gList,function(a,b)
		return string.lower(a[2]) < string.lower(b[2])
	end)
end

-- main:
function main()
	while not SystemIsReady() do
		Wait(0)
	end
	SendNetworkEvent("sync:connectPlayer",math.deg(PedGetHeading(gPlayer)),PlayerGetPosXYZ())
	while s.player == -1 do
		Wait(0)
	end
	CreateDrawingThread("T_Players")
end
function T_Players()
	local formatting
	SetTextAlign("L")
	SetTextFont("Georgia")
	SetTextBlack()
	SetTextScale(0.9)
	SetTextColor(230,230,230,255)
	formatting = PopTextFormatting()
	while true do
		if IsGamePaused() then
			local y = 0.02 -- margin
			local x = y / GetDisplayAspectRatio()
			local padding = 0.01 -- on each side
			local linebreak = 0.005
			local maxw,maxh,width,height = 0,0
			for _,v in ipairs(gList) do
				SetTextFormatting(formatting)
				width,height = MeasureText(v[2])
				if width > maxw then
					maxw = width
				end
				maxh = maxh + height + linebreak
			end
			if maxw < 0.475 / GetDisplayAspectRatio() then
				maxw = 0.475 / GetDisplayAspectRatio()
			end
			DrawRectangle(x,y,maxw+(padding*2)/GetDisplayAspectRatio(),maxh+padding*2,0,0,0,192)
			for _,v in ipairs(gList) do
				SetTextFormatting(formatting)
				if v[1] == gLeader then
					SetTextItalic()
				end
				SetTextPosition(x+padding/GetDisplayAspectRatio(),y+padding)
				width,height = DrawText(v[2])
				y = y + height + linebreak
			end
		end
		Wait(0)
	end
end
