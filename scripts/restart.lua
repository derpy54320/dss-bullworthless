-- the linux server is configured to automatically restart the server when it exits

gRestarting = false

function main()
	local ms = 6 * 60 * 60000
	Wait(ms - 5 * 60000)
	gRestarting = true
	for i = 5,2,-1 do
		notify("Server restarting in "..i.." minutes.")
		Wait(60000)
	end
	notify("Server restarting in 1 minute.")
	Wait(60000)
	notify("Server restarting!")
	Wait(1000)
	QuitServer()
	TerminateCurrentScript()
end
function notify(text)
	if net.chat then
		net.chat.notify(-1,text)
	end
end
RegisterLocalEventHandler("PlayerListing",function(player,listing)
	if gRestarting then
		listing.info = "The server is restarting, check back in a few minutes!"
	end
end)
RegisterLocalEventHandler("PlayerConnecting",function(player)
	if gRestarting then
		KickPlayer(player,"The server is restarting, try again in a few minutes!")
	end
end)
