LoadScript("models.lua")

RegisterLocalEventHandler("menu:openMain",function(add)
	add("Swap Model","Swap your player model.",M_SwapModel)
end)
function M_SwapModel()
	local menu =  dsl.menu.create("Swap Model")
	while menu:active() do
		for i = 0,258 do
			local model = PED_MODELS[i]
			if model and menu:option(model) then
				PlayerSwapModel(model)
				break
			end
		end
		menu:draw()
		Wait(0)
	end
end
