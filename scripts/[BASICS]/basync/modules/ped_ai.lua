--[[ BASYNC MODULE: PED AI
	
	summary:
		this module attempts to sync some ped ai and let the server set tasks
	
	config:
		ai nodes can be configured in a way similar to the actions module
	
	shared:
		(n/a)
	
	server:
		(n/a)
	
]]

-- .task
module = create_module("task","/G")
module:require_type("string")
module:get_func(function(ped)
	
end)
module:set_func(function(ped,value)
	
end)

-- shared methods
function mod_shared:get_task()
	validate_ped(self,2)
end

-- server methods
function mod_server:set_task(value)
	validate_ped(self,2)
end
