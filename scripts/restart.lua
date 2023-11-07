-- the linux server is configured to automatically restart the server when it exits

function main()
	local ms = 6 * 60 * 60000
	Wait(ms - 5 * 60000)
	for i = 5,1,-1 do
		notify("Server restarting in "..i.." seconds.")
		Wait(60000)
	end
	notify("Server restarting!")
	Wait(1000)
	QuitServer()
end
function notify(text)
	if net.chat then
		net.chat.notify(-1,text)
	end
end
