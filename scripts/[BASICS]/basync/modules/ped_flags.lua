--[[ BASYNC MODULE: PED FLAGS
	
	summary:
		this module syncs selected ped flags
	
	config:
		set which flags you want to be synced by editing the FLAGS table
	
	shared:
		ped:get_flag(flag)        | returns the value of the ped's flag
	
	server:
		ped:set_flag(flag, value) | sets the value of the ped's flag
	
]]
local FLAGS = {
	{2,false}, -- crouch
}

-- init
local init = {}
local flags = {}
for i,v in ipairs(FLAGS) do
	init[v[1]] = v[2]
	flags[i] = v[1]
end

-- .flags
module = create_module("flags",init)
module:require_type("table")
module:check_func(function(value)
	for _,v in ipairs(value) do
		if type(v) ~= "boolean" then
			return false
		end
	end
	return true
end)
module:get_func(function(ped)
	local value = {}
	for i,f in ipairs(flags) do
		value[i] = PedGetFlag(ped.ped,f)
	end
	return value
end)
module:set_func(function(ped,value)
	if not ped.state:is_owner() or ped.state:was_updated("flags") then
		for i,f in ipairs(flags) do
			if PedGetFlag(ped.ped,f) ~= value[i] then
				PedSetFlag(ped.ped,f,value[i])
			end
		end
	end
end)

-- shared methods
function mod_shared:get_flag(flag)
	validate_ped(self,2)
	for i,f in ipairs(flags) do
		if f == flag then
			return self.server.flags[i]
		end
	end
	error("unsupported flag",2)
end

-- server methods
function mod_server:set_flag(flag,value)
	validate_ped(self,2)
	if type(value) ~= "boolean" then
		error("invalid flag value",2)
	end
	for i,f in ipairs(flags) do
		if f == flag then
			self.server.flags[i] = value
			self.state:update_field("flags")
		end
	end
	error("unsupported flag",2)
end
