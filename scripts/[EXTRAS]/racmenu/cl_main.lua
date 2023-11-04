sst = GetScriptSharedTable(true)

RegisterLocalEventHandler("menu:openMain",function(add)
	add("RAC-ATTACK MENU","Use the RAC-ATTACK menu!!!",rac_main_menu)
end)
function rac_main_menu()
	return rac_menu("RAC-ATTACK",{
		{"Action / AI Nodes",{
			{"Show Player Action Node",sst.show_action},
			{"Show Player Task Node",sst.show_task},
			{"Set Player Action Node",sst.set_action},
			{"Set Player Task Node",sst.set_task},
			{"Set Player Action Tree",sst.set_act_tree},
			{"Set Player AI Tree",sst.set_ai_tree},
		}},
		{"Swap Model",sst.swap_model},
	})
end
function rac_menu(name,options)
	local menu = net.menu.create(name)
	while menu:active() do
		for _,v in ipairs(options) do
			if menu:option(v[1]) then
				local f = v[2]
				if type(f) == "table" then
					rac_menu(v[1],f)
				elseif type(f) == "function" then
					f(menu)
				else
					menu:alert("Invalid menu option.",3)
				end
				break
			end
		end
		menu:draw()
		Wait(0)
	end
end
