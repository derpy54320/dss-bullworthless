-- server actions
LoadScript("module.lua")
LoadScript("actions.lua")

-- state
function init_ped_act(ped)
	local tree = PEDS[ped.server.model]
	if tree then
		ped.server.act_tree,ped.server.act_tree_file = unpack(tree)
	else
		ped.server.act_tree = "/G/GS_MALE_A"
		ped.server.act_tree_file = "GS_MALE_A.ACT"
	end
	ped.server.act_node = ped.server.act_tree.."/DEFAULT_KEY"
	ped.server.act_node_file = ped.server.act_tree_file
	ped.server.act_count = 1
	ped.server.act_timer = 0
end
if net.basync then
	for ped in net.basync.all_peds() do
		init_ped_act(ped)
	end
end
RegisterLocalEventHandler("basync:initPed",init_ped_act)
RegisterLocalEventHandler("ScriptShutdown",function(script)
	if net.basync and script == GetCurrentScript() then
		for ped in net.basync.all_peds() do
			ped.server.act_tree = nil
			ped.server.act_tree_file = nil
			ped.server.act_node = nil
			ped.server.act_node_file = nil
			ped.server.act_count = nil
			ped.server.act_timer = nil
		end
	end
end)

-- check
RegisterLocalEventHandler("basync:setPed",function(k,v)
	if k == "act_node" or k == "act_node_file" or k == "act_tree" or k == "act_tree_file" then
		if type(v) == "string" and not string.find(v,"%l") then
			return true -- we're good with anything as long as it is an uppercase string, the client performs more extensive safety checks
		end
	elseif (k == "act_count" or k == "act_timer") and type(v) == "number" and v >= 0 then
		return true
	end
end)

-- api
function fix_node(node) -- replace the first /NODE/ with /G/
	local a,b = string.find(node,"^/+")
	if a then
		a,b = string.find(node,"[^/]+",b+1)
		if a then
			return string.sub(node,1,a-1).."G"..string.sub(node,b+1)
		end
	end
	return node
end
function get_nodes(node) -- get a table of each /NODE/
	local list = {n = 0}
	local a,b = string.find(node,"^/+") -- find start of first node
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
function mt_ped.__index:set_action_tree(tree,file)
	net.basync.validate_ped(self,2)
	if type(tree) ~= "string" then
		error("invalid action tree",2)
	elseif file ~= nil and type(file) ~= "string" then
		error("invalid action file",2)
	end
	self.server.act_tree = string.upper(fix_node(tree))
	if file then
		self.server.act_tree_file = string.upper(file)
	else
		self.server.act_tree_file = ""
	end
	self.state:update_field("act_tree")
end
function mt_ped.__index:set_action_node(node,file)
	net.basync.validate_ped(self,2)
	if type(node) ~= "string" then
		error("invalid action node",2)
	elseif file ~= nil and type(file) ~= "string" then
		error("invalid action file",2)
	end
	self.server.act_node = string.upper(fix_node(node))
	if file then
		self.server.act_node_file = string.upper(file)
	else
		self.server.act_node_file = ""
	end
	self.server.act_count = 1
	self.server.act_timer = 0
	self.state:update_field("act_node")
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
function _G.PedGetActionTree(ped)
	return run(function()
		return ped:get_action_tree()
	end)
end
function _G.PedGetActionNode(ped)
	return run(function()
		return ped:get_action_node()
	end)
end
function _G.PedSetActionTree(ped,tree,file)
	return run(function()
		ped:set_action_tree(tree,file)
	end)
end
function _G.PedSetActionNode(ped,node,file)
	return run(function()
		ped:set_action_node(node,file)
	end)
end
function _G.PedIsPlaying(ped,node)
	return run(function()
		return ped:is_playing(node)
	end)
end
function _G.PedMePlaying(ped,node)
	return run(function()
		return ped:me_playing(node)
	end)
end
function _G.PedGetNodeTime(ped)
	return ped:get_node_time()
end
