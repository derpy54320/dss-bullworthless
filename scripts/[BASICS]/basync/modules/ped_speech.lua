--[[ BASYNC MODULE: PED SPEECH
	
	summary:
		this module syncs ped speech
	
	shared:
		(n/a)
	
	server:
		(n/a)
	
]]

-- .speech
module = create_module("speech",0)
module:require_type("table")
module:get_func(function(ped)
	
end)
module:set_func(function(ped,value)
	
end)

-- shared methods
function mod_shared:get_speech()
	validate_ped(self,2)
end

-- server methods
function mod_server:play_speech(value)
	validate_ped(self,2)
end
