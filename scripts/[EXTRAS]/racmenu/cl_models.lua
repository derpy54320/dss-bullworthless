sst = GetScriptSharedTable()
LoadScript("utility/models.lua")

function sst.swap_model()
	local menu = net.menu.create("Swap Model")
	while menu:active() do
		for i = 0,258 do
			local model = PED_MODELS[i]
			if model and menu:option(model) then
				PlayerSwapModel(model)
			end
		end
		menu:draw()
		Wait(0)
	end
end
