RegisterLocalEventHandler("menu:openMain",function(add)
	--if net.admin and net.admin.is_admin() then
		add("Switch Area","Switch to another area.",M_Areas)
	--end
end)
function MissionCleanup()
	AreaDisableCameraControlForTransition(false)
end
function M_Areas()
	local menu = net.menu.create("Switch Area")
	local areas = {}
	for k,v in pairs(shared.areaTable) do
		areas[k] = v
	end
	table.sort(areas,function(a,b)
		if a.zone == b.zone then
			return string.lower(a.name) < string.lower(b.name)
		end
		return a.zone < b.zone
	end)
	areas.size = areas.size - 1
	while menu:active() do
		for index = 0,areas.size do
			local area = areas[index]
			if menu:option(area.name,"["..area.zone.."]") then
				local expire = GetTimer() + 500
				CameraFade(500,0)
				repeat
					menu:draw(true)
					Wait(0)
				until not AreaIsLoading() and GetTimer() >= expire
				PlayerSetPosXYZArea(area.x,area.y,area.z,area.zone)
				AreaDisableCameraControlForTransition(true)
				while AreaIsLoading() do
					menu:draw(true)
					Wait(0)
				end
				AreaDisableCameraControlForTransition(false)
				PedFaceHeading(gPlayer,area.h,0)
				CameraFade(500,1)
				break
			end
		end
		menu:draw()
		Wait(0)
	end
end
