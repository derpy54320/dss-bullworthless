-- SYNC: mission shit
s = GetScriptSharedTable()

function F_SetupHook(func)
	HookFunction(func,function(args,results)
		if s.leader then
			SendNetworkEvent("sync:printedText",func,unpack(args))
		end
	end)
end
for _,func in ipairs({"TextPrint","TextPrintBig","TextPrintF","TextPrintString"}) do
	F_SetupHook(func)
end
RegisterNetworkEventHandler("sync:printText",function(func,...)
	if not s.leader then
		_G[func](unpack(arg))
	end
end)
