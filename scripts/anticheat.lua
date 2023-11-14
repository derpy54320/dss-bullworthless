RegisterLocalEventHandler("PlayerConnecting",function(player,hashes)
	if not IsHash(hashes.scripts,"2DE6E966") then
		return KickPlayer(player,"you are running a modded scripts.img")
	end
	for _,hash in ipairs(hashes) do
		if not is_okay(hash) then
			return KickPlayer(player,"you are running a forbidden script")
		end
	end
end)
function is_okay(hash)
	for _,v in ipairs(gAllowed) do
		if IsHash(hash,v) then
			return true
		end
	end
	return false
end
gAllowed = {
	"E7111155", -- window
	"CA061299", -- server_browser (dsl8)
	"A42C6B23", -- server_browser (dsl9)
	"D7D1AB0E", -- server_browser (legacy)
}
