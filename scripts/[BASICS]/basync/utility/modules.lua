-- module utility

local mt_module = {__index = {}}
local forbid_fields = {_owner=true,type=true,name=true,model=true,pos=true,area=true,veh_id=true,veh_seat=true}
local validate_module

-- global
gModules = {}
function create_module(key,value)
	if key == nil then
		error("expected server state key",2)
	elseif forbid_fields[key] then
		error("reserved server state key",2)
	elseif gModules[key] then
		error("duplicate server state key",2)
	end
	gModules[key] = setmetatable({value = value},mt_module)
	return gModules[key]
end
function load_modules(prefix,cl,sh,sv)
	for name in AllConfigStrings(GetScriptConfig(),"client_file") do
		if string.find(name,"^modules/"..prefix) then
			mod_client,mod_shared,mod_server = cl,sh,sv
			LoadScript(name)
			module,mod_client,mod_shared,mod_server = nil
		end
	end
end

-- methods
function mt_module.__index:require_type(tname) -- require this type (can be a table of strings too)
	validate_module(self,2)
	if type(tname) ~= "string" then
		error("expected type name",2)
	end
	self.tname = tname
end
function mt_module.__index:check_func(func) -- acceptable = func(value): should return true if the value is acceptable
	validate_module(self,2)
	if type(func) ~= "function" then
		error("expected function",2)
	end
	self.check = func
end
function mt_module.__index:get_func(func) -- value = func(ped): remember ped is a sync ped object and *not* a normal ped (use ped.ped for the normal ped)
	validate_module(self,2)
	if type(func) ~= "function" then
		error("expected function",2)
	end
	self.get = func
end
function mt_module.__index:set_func(func) -- func(ped,value): ped is a sync ped object
	validate_module(self,2)
	if type(func) ~= "function" then
		error("expected function",2)
	end
	self.set = func
end

-- internal
function validate_module(mod,level)
	if type(mod) ~= "table" or getmetatable(mod) ~= mt_module then
		error("invalid module",level+1)
	end
end
