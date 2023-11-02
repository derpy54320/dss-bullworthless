local cleanup = {}

-- add
function add_cleanup_object(script,obj)
	local list = cleanup[script]
	if list then
		local index = 1
		while index <= list.n do
			if list[index]:is_valid() then
				index = index + 1
			else
				table.remove(list,index)
			end
		end
		table.insert(list,obj)
	else
		cleanup[script] = {n = 1,obj}
	end
end

-- cleanup
RegisterLocalEventHandler("ScriptDestroyed",function(script)
	local list = cleanup[script]
	if list then
		for _,obj in ipairs(list) do
			if obj:is_valid() then
				obj:delete()
			end
		end
	end
end)
