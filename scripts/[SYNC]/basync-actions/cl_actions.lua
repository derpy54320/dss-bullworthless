-- client actions
LoadScript("module.lua")
LoadScript("actions.lua")
LoadScript("nodes.lur")

-- action trees
RegisterLocalEventHandler("basync:getPed",function(ped,update)
	if PedMePlaying(ped.ped,"DEFAULT_KEY",true) then
		for tree,file in pairs(ACTION_TREES) do
			if PedIsPlaying(ped.ped,tree,true) then
				update.act_tree = tree
				update.act_tree_file = file
				break
			end
		end
	end
end)
RegisterLocalEventHandler("basync:setPed",function(ped)
	if (ped.state:was_updated("act_tree") or (not ped.state:is_owner() and PedMePlaying(ped.ped,"DEFAULT_KEY",true) and not PedIsPlaying(ped.ped,ped.server.act_tree,true) and not PedIsPlaying(ped.ped,ped.server.act_node,true))) and ACTION_TREES[ped.server.act_tree] then
		PedSetActionTree(ped.ped,ped.server.act_tree,ped.server.act_tree_file)
	end
end)

-- action nodes
function translate_node(node)
	if not string.find(node,"^/G/") then
		return "/G" -- not a full node
	end
	for _,black in ipairs(BLACKLIST_NODES) do
		if string.find(node,black) then
			for _,white in ipairs(WHITELIST_NODES) do
				if string.find(node,white[1]) then
					if white[2] then
						return white[2] -- whitelisted and replaced
					end
					return node -- whitelisted
				end
			end
			return "/G" -- blacklisted
		end
	end
	return node -- not blacklisted
end
RegisterLocalEventHandler("basync:assignPed",function(ped)
	ped.act_node = "/G"
	ped.act_nodes = GetRootActionNode()
	ped.act_count = 0
	ped.act_timer = 0
	-- ped.act_reset can also be set later
end)
RegisterLocalEventHandler("basync:getPed",function(ped,update)
	update.act_node,ped.act_nodes = PedGetActionNode(ped.ped,ped.act_node,ped.act_nodes)
	update.act_timer = PedGetNodeTime(ped.ped)
	if ped.act_node ~= update.act_node then
		ped.act_node = update.act_node -- starting a new node
		ped.act_count = 1
	elseif update.act_timer < ped.act_timer then
		ped.act_count = ped.act_count + 1 -- we're playing the node another time
	end
	update.act_count = ped.act_count
	ped.act_timer = update.act_timer
end)
RegisterLocalEventHandler("basync:setPed",function(ped)
	local updated = ped.state:was_updated("act_node")
	if updated then
		ped.act_count = 0
	end
	if updated or not ped.state:is_owner() then
		local translated = translate_node(ped.server.act_node) -- we use this translated node for PedSetActionNode / PedIsPlaying but nothing else
		local playing = PedIsPlaying(ped.ped,translated,true)
		if not playing then
			if ped.act_reset and GetTimer() >= ped.act_reset then
				ped.act_count = 0
				ped.act_reset = nil
			--[[elseif ped.server.act_timer - ped.act_timer >= 0.1 then
				ped.act_count = 0 -- force a reset if we were meant to play at least 0.1 seconds longer than we did]]
			elseif not ped.act_reset then
				ped.act_reset = GetTimer() + NODE_RESET_DELAY -- force a reset soon (in local time)
			end
		end
		if ped.act_node ~= ped.server.act_node or ped.act_count < ped.server.act_count then
			PedSetActionNode(ped.ped,translated,ped.server.act_node_file)
			playing = PedIsPlaying(ped.ped,translated,true)
			if playing then
				ped.act_count = ped.server.act_count -- we caught up to the server play count
			end
		end
		if playing then
			ped.act_node = ped.server.act_node -- we're playing the server node
			ped.act_timer = PedGetNodeTime(ped.ped)
		end
	end
end)

-- cleanup
function MissionCleanup()
	PedSetActionTree(gPlayer,"","")
end

-- api
function get_nodes(node)
	local list = {n = 0}
	local a,b = string.find(node,"/+") -- find start of first node
	while a do
		a,b = string.find(node,"[^/]+",b+1)
		if a then
			table.insert(list,string.sub(node,a,b))
			a,b = string.find(node,"/+",b+1) -- find start of next node
		end
	end
	return list
end
function mt_ped.__index:get_action_tree()
	net.basync.validate_ped(self,2)
	return self.server.act_tree,self.server.act_tree_file
end
function mt_ped.__index:get_action_node()
	net.basync.validate_ped(self,2)
	return self.server.act_node,self.server.act_node_file
end
function mt_ped.__index:is_playing(node)
	net.basync.validate_ped(self,2)
	if type(node) ~= "string" then
		error("invalid action node",2)
	end
	local playing = get_nodes(self.server.act_node)
	node = get_nodes(string.upper(node))
	if node.n == 0 then
		return false
	end
	for i = 2,node.n do
		if node[i] ~= playing[i] then
			return false
		end
	end
	return true
end
function mt_ped.__index:me_playing(node)
	net.basync.validate_ped(self,2)
	if type(node) ~= "string" then
		error("invalid action node",2)
	end
	local playing = get_nodes(self.server.act_node)
	node = string.upper(node)
	if node == "GLOBAL" then
		return true
	end
	for i = 2,playing.n do
		if playing[i] == node then
			return true
		end
	end
	return false
end
function mt_ped.__index:get_node_time()
	net.basync.validate_ped(self,2)
	return self.server.act_time
end
