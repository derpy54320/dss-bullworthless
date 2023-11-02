--[[ BASYNC MODULE: PED ACTIONS
	
	summary:
		this module attempts to sync some ped action nodes and action trees
		you will have to load anim groups and act trees in other scripts
		instability is expected
	
	config:
		there are lots of tables that control which action nodes are allowed
		you may have to fine tune this to find your desired balance between sync and stability
	
	shared:
		ped:get_act_tree()     | returns the ped's action tree
		ped:get_act_node()     | returns the ped's action node
	
	server:
		ped:set_act_tree(tree) | sets the ped's action tree
		ped:set_act_node(node) | sets the ped's action node
	
]]
local ACTION_TREES = { -- allowed action trees
	-- by default, this table contains all action trees with a DEFAULT_KEY node
	["/GLOBAL/1_02B/CONSTANTINOSIDLE"] = true,
	["/GLOBAL/1_03_DAVIS"] = true,
	["/GLOBAL/2_07_GORD"] = true,
	["/GLOBAL/AMBIENT/SPECTATOR"] = true,
	["/GLOBAL/AN_DOG"] = true,
	["/GLOBAL/AN_RAT"] = true,
	["/GLOBAL/AUTHORITY"] = true,
	["/GLOBAL/BASKETBALL/BASKETBALL"] = true,
	["/GLOBAL/BAT"] = true,
	["/GLOBAL/BOOKS/BOOKS"] = true,
	["/GLOBAL/BOSS_DARBY"] = true,
	["/GLOBAL/BOSS_RUSSELL"] = true,
	["/GLOBAL/BOXINGPLAYER"] = true,
	["/GLOBAL/B_STRIKER_A"] = true,
	["/GLOBAL/CRAZY_BASIC"] = true,
	["/GLOBAL/CV_DRUNK"] = true,
	["/GLOBAL/CV_FEMALE_A"] = true,
	["/GLOBAL/CV_MALE_A"] = true,
	["/GLOBAL/CV_OLD"] = true,
	["/GLOBAL/DO_EDGAR"] = true,
	["/GLOBAL/DO_GRAPPLER_A"] = true,
	["/GLOBAL/DO_MELEE_A"] = true,
	["/GLOBAL/DO_STRIKER_A"] = true,
	["/GLOBAL/EDGARSHIELD"] = true,
	["/GLOBAL/FIGHT_TUTORIAL"] = true,
	["/GLOBAL/FLASHLIGHT/FLASHLIGHT"] = true,
	["/GLOBAL/GS_FAT_A"] = true,
	["/GLOBAL/GS_FEMALE_A"] = true,
	["/GLOBAL/GS_MALE_A"] = true,
	["/GLOBAL/GUN/GUN"] = true,
	["/GLOBAL/G_GRAPPLER_A"] = true,
	["/GLOBAL/G_JOHNNY"] = true,
	["/GLOBAL/G_MELEE_A"] = true,
	["/GLOBAL/G_RANGED_A"] = true,
	["/GLOBAL/G_STRIKER_A"] = true,
	["/GLOBAL/HF_SPECTATOR"] = true,
	["/GLOBAL/HOBO_BLOCKER"] = true,
	["/GLOBAL/JBROOM"] = true,
	["/GLOBAL/J_DAMON"] = true,
	["/GLOBAL/J_GRAPPLER_A"] = true,
	["/GLOBAL/J_MASCOT"] = true,
	["/GLOBAL/J_MELEE_A"] = true,
	["/GLOBAL/J_STRIKER_A"] = true,
	["/GLOBAL/J_TED"] = true,
	["/GLOBAL/KICKMESIGN/KICKMESIGN"] = true,
	["/GLOBAL/LE_ORDERLY_A"] = true,
	["/GLOBAL/NEMESIS"] = true,
	["/GLOBAL/NONWEAPON/NONWEAPON"] = true,
	["/GLOBAL/NORTON"] = true,
	["/GLOBAL/NPC1_09"] = true,
	["/GLOBAL/NPC_CHEER_A"] = true,
	["/GLOBAL/N_EARNEST"] = true,
	["/GLOBAL/N_RANGED_A"] = true,
	["/GLOBAL/N_STRIKER_A"] = true,
	["/GLOBAL/N_STRIKER_B"] = true,
	["/GLOBAL/PLAYER"] = true,
	["/GLOBAL/P_BIF"] = true,
	["/GLOBAL/P_GRAPPLER_A"] = true,
	["/GLOBAL/P_STRIKER_A"] = true,
	["/GLOBAL/P_STRIKER_B"] = true,
	["/GLOBAL/RUSSELL_102"] = true,
	["/GLOBAL/SHIELDS"] = true,
	["/GLOBAL/SIMPLELOCO"] = true,
	["/GLOBAL/SLASHER"] = true,
	["/GLOBAL/SLEDGEHAMMER"] = true,
	["/GLOBAL/SLINGSHOT/SLINGSHOT"] = true,
	["/GLOBAL/SNOWSHOVEL/SNOWSHOVEL"] = true,
	["/GLOBAL/SPECIAL_ITEMS"] = true,
	["/GLOBAL/SPRAYCAN"] = true,
	["/GLOBAL/TE_FEMALE_A"] = true,
	["/GLOBAL/TE_SECRETARY"] = true,
	["/GLOBAL/THROWN/THROWN"] = true,
	["/GLOBAL/TO_SIAMESE"] = true,
	["/GLOBAL/UMBRELLA"] = true,
	["/GLOBAL/WATERPIPE"] = true,
	["/GLOBAL/WCAMERA/WCAMERA"] = true,
	["/GLOBAL/WFIREEXT"] = true,
	["/GLOBAL/WRESTLINGACT"] = true,
	["/GLOBAL/WRESTLINGNPC"] = true,
}
local NODE_BLACKLIST = { -- patterns for unallowed nodes
	-- nodes should be in all caps and start with "/G" not "/GLOBAL"
	"^/G/TAGS",
	"^/G/VEHICLES/SKATEBOARD",
	"^/G/AMBIENT/TALKING/TALKING/GEN/SPEECHANIMS/SPAWNS",
}

-- .tree
module = create_module("tree","/GLOBAL/PLAYER")
module:require_type("string")
module:check_func(function(value)
	return ACTION_TREES[value]
end)
module:get_func(function(ped)
	if PedMePlaying(ped.ped,"DEFAULT_KEY",true) then
		for value in pairs(ACTION_TREES) do
			if PedIsPlaying(ped.ped,value,true) then
				return value
			end
		end
	end
end)
module:set_func(function(ped,value)
	if ped.state:was_updated("tree") or (not ped.state:is_owner() and PedMePlaying(ped.ped,"DEFAULT_KEY",true) and not PedIsPlaying(ped.ped,value,true)) then
		PedSetActionTree(ped.ped,value,"")
	end
end)

-- .node
module = create_module("node","/G")
module:require_type("string")
module:get_func(function(ped)
	local s,t = PedGetActionNode(ped.ped,ped.node_s,ped.node_t)
	for _,v in ipairs(NODE_BLACKLIST) do
		if string.find(s,v) then
			ped.node_s,ped.node_t = nil
			return "/G"
		end
	end
	ped.node_s,ped.node_t = s,t
	return s
end)
module:set_func(function(ped,value)
	if ped.state:was_updated("actnode") or (not ped.state:is_owner() and not PedIsPlaying(ped.ped,value,true)) then
		for _,black in ipairs(NODE_BLACKLIST) do
			if string.find(value,black) then
				return
			end
		end
		PedSetActionNode(ped.ped,value,"")
	end
end)

-- shared methods
function mod_shared:get_act_tree()
	validate_ped(self,2)
	return self.server.tree
end
function mod_shared:get_act_node()
	validate_ped(self,2)
	return self.server.node
end

-- server methods
function mod_server:set_act_tree(tree)
	validate_ped(self,2)
	if type(tree) ~= "string" then
		error("invalid action tree",2)
	end
	self.server.tree = tree
	self.state:update_field("tree")
end
function mod_server:set_act_node(node)
	validate_ped(self,2)
	if type(node) ~= "string" then
		error("invalid action node",2)
	end
	self.server.node = node
	self.state:update_field("node")
end
