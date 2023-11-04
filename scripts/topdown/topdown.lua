function MissionCleanup()
	CameraReset()
	CameraDefaultFOV()
	CameraReturnToPlayer()
end
function main()
	while not SystemIsReady() do
		Wait(0)
	end
	while true do
		if F_Button() then
			F_Camera()
		end
		Wait(0)
	end
end
function F_Button()
	return IsKeyBeingPressed("G",0) or IsKeyBeingPressed("G",1)
end
function F_Camera()
	local d = 15
	local p,h = math.rad(55),0
	local x1,y1,z1 = F_Position(h)
	local p_low,p_high = math.rad(15),math.rad(85)
	CameraSetActive(4)
	while CameraGetActive() == 4 do
		local x2,y2,z2 = F_Position(h)
		local dx,dy,dz = x2-x1,y2-y1,z2-z1
		local dist = math.sqrt(dx*dx+dy*dy+dz*dz)
		if dist > 0 then
			local amount = GetFrameTime() / 0.2
			x1,y1,z1 = x1+dx*amount,y1+dy*amount,z1+dz*amount
		end
		CameraSetXYZ(x1-d*math.cos(p)*math.sin(h),y1+d*math.cos(p)*math.cos(h),z1+d*math.sin(p),x1,y1,z1)
		Wait(0)
		if F_Button() then
			CameraReset()
			CameraDefaultFOV()
			CameraReturnToPlayer()
			break
		end
		p = p - GetStickValue(19,0) * GetFrameTime()
		if p < p_low then
			p = p_low
		elseif p > p_high then
			p = p_high
		end
		h = h + GetStickValue(18,0) * GetFrameTime()
		while h > math.pi do
			h = h - math.pi * 2
		end
		while h <= -math.pi do
			h = h + math.pi * 2
		end
	end
end
function F_Position(h)
	local d = -1
	local x,y,z = PlayerGetPosXYZ()
	return x-d*math.sin(h),y+d*math.cos(h),z+1
end
