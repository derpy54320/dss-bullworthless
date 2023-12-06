-- server flags
LoadScript("module.lua")
LoadScript("flags.lua")

-- register
count = 0
default = {}
for i,v in ipairs(FLAGS) do
	count = count + 1
	default[i] = v[2]
end
register_ped_field("flags",default)

-- check
RegisterLocalEventHandler("basync:setPed",function(k,v)
	if k == "flags" and type(v) == "table" and table.getn(v) == count then -- flags should be a table of the same size as the default
		for _,b in ipairs(v) do
			if type(b) ~= "boolean" then
				return -- unexpected type
			end
		end
		return true -- this table is just booleans so it is good
	end
end)

-- api
function mt_ped.__index:get_flag(flag) -- returns nil if the flag isn't supported
	net.basync.validate_ped(self,2)
	for i,v in ipairs(FLAGS) do
		if v[1] == flag then
			return self.server.flags[i]
		end
	end
end
function _G.PedGetFlag(ped,flag)
	return run(function()
		return ped:get_flag(flag)
	end)
end
function mt_ped.__index:set_flag(flag,value) -- returns false if the flag isn't supported
	net.basync.validate_ped(self,2)
	if type(value) ~= "boolean" then
		error("invalid state",2)
	end
	for i,v in ipairs(FLAGS) do
		if v[1] == flag then
			self.server.flags[i] = value
			self.state:update_field("flags")
			return true
		end
	end
	return false
end
function _G.PedSetFlag(ped,flag,value)
	return run(function()
		if type(value) == "number" then
			value = value ~= 0
		end
		return ped:set_flag(flag,value)
	end)
end
