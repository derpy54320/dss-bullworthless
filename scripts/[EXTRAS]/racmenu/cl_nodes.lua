sst = GetScriptSharedTable()
LoadScript("utility/nodes.lur")

-- show nodes
function sst.show_action(menu)
	local s,r
	while menu:active() do
		s,r = PedGetActionNode(gPlayer,s,r)
		menu:draw("[ACTIVE]")
		draw_node(s)
		Wait(0)
		if menu:left() then
			break
		end
	end
end
function sst.show_task(menu)
	local s,r
	while menu:active() do
		s,r = PedGetTaskNode(gPlayer,s,r)
		menu:draw("[ACTIVE]")
		draw_node(s)
		Wait(0)
		if menu:left() then
			break
		end
	end
end
function draw_node(s)
	local w,h
	SetTextFont("Arial")
	SetTextBlack()
	SetTextScale(0.9)
	SetTextWrapping(0.7)
	SetTextPosition(0.5,0.85)
	SetTextColor(255,255,255,255)
	w,h = MeasureText(s)
	DrawRectangle(0.5-w/2,0.85,w,h,0,0,0,255)
	DrawText(s)
end

-- set nodes
function sst.set_action()
	return set_node("Set Player Action Node",GetRootActionNode(),"/G",PedSetActionNode)
end
function sst.set_task()
	return set_node("Set Player Task Node",GetRootActionNode(),"/G",PedSetTaskNode)
end
function set_node(title,nodes,str,set)
	local menu = net.menu.create(title,str)
	local count,options = 0,{}
	for k,v in pairs(nodes) do
		count = count + 1
		options[count] = {k,v}
	end
	table.sort(options,function(a,b)
		return a[1] < b[1]
	end)
	while menu:active() do
		local target = PedGetTargetPed(gPlayer)
		if not PedIsValid(target) then
			target = gPlayer
		end
		if menu:option("< set >") and not set(target,str,"") then
			menu:alert("Failed to set node.",2)
		end
		for _,v in ipairs(options) do
			if menu:option(v[1]) then
				set_node(title,v[2],str.."/"..v[1],set)
			end
		end
		menu:draw()
		Wait(0)
	end
end

-- set trees
function sst.set_act_tree()
	local menu = net.menu.create("Set Player Action Tree")
	local count,trees = 0,{}
	for node,nodes in pairs(GetRootActionNode()) do
		for k,v in pairs(nodes) do
			if v.DEFAULT_KEY then
				count = count + 1
				trees[count] = node.."/"..k
			end
		end
		if nodes.DEFAULT_KEY then
			count = count + 1
			trees[count] = node
		end
	end
	table.sort(trees)
	while menu:active() do
		if menu:option("< default >") then
			PedSetActionTree(gPlayer,"","")
		end
		for _,v in ipairs(trees) do
			if menu:option("/G/"..v) then
				if v == "PLAYER" then
					PedSetActionTree(gPlayer,"/G/"..v,"ACT/PLAYER.ACT")
				else
					PedSetActionTree(gPlayer,"/G/"..v,"ACT/ANIM/"..v..".ACT")
				end
			end
		end
		menu:draw()
		Wait(0)
	end
end
function sst.set_ai_tree()
	local menu = net.menu.create("Set Player Action Tree")
	local count,trees = 0,{}
	for node,nodes in pairs(GetRootActionNode()) do
		for k,v in pairs(nodes) do
			if v.GENERALOBJECTIVES or v.OBJECTIVES then
				count = count + 1
				trees[count] = node.."/"..k
			end
		end
		if nodes.GENERALOBJECTIVES or nodes.OBJECTIVES then
			count = count + 1
			trees[count] = node
		end
	end
	table.sort(trees)
	while menu:active() do
		for _,v in ipairs(trees) do
			if menu:option("/G/"..v) then
				if v == "PLAYER" then
					PedSetAITree(gPlayer,"/G/"..v,"ACT/PLAYERAI.ACT")
				else
					PedSetAITree(gPlayer,"/G/"..v,"ACT/AI/"..v..".ACT")
				end
			end
		end
		menu:draw()
		Wait(0)
	end
end

-- search
function search_nodes(results,pattern,prefix,nodes)
	local any = false
	for node,more in pairs(nodes) do
		if not search_nodes(results,pattern,prefix.."/"..node,more) and string.find(node,pattern) then
			table.insert(results,prefix.."/"..node)
			any = true
		end
	end
	return any
end
SetCommand("search_node",function(pattern)
	local results = {}
	search_nodes(results,string.upper(pattern),"/G",GetRootActionNode())
	table.sort(results)
	for _,result in ipairs(results) do
		print(result)
	end
end)
