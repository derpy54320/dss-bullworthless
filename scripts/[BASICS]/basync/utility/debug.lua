-- debug utility

local get_str

function get_str(indent,x)
	if type(x) == "string" then
		return "\""..x.."\""
	elseif type(x) == "table" then
		local s,n = "{",0
		for _,value in ipairs(x) do
			s = s.."\n"..string.rep("  ",indent+1)..get_str(indent+1,value)..","
			n = n + 1
		end
		for key,value in pairs(x) do
			if type(key) ~= "number" or key ~= math.floor(key) or key < 1 or key > n then
				if type(key) == "string" then
					s = s.."\n"..string.rep("  ",indent+1)..key.." = "..get_str(indent+1,value)..","
				else
					s = s.."\n"..string.rep("  ",indent+1).."["..get_str(indent+1,key).."] = "..get_str(indent+1,value)..","
				end
			end
		end
		return s == "{" and s.."}" or string.sub(s,1,-2).."\n"..string.rep("  ",indent).."}"
	end
	return tostring(x)
end
function get_debug_string(value)
	return get_str(0,value)
end
