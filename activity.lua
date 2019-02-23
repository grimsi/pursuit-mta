local activitycount = 0

function activitycheck()
	if (getPlayerCount() == 1) then
		activitycount = activitycount+1
		if (activitycount == 3) then
			triggerEvent("onResourceRestart", root)
			outputChatBox("Keine Akivität!", getRootElement())
		end
	else 
		activitycheck = 0
	end
	--setTimer(activitycheck, 300000, 1)
	setTimer(activitycheck, 30000, 1)
end

addEventHandler("onResourceStart", resourceRoot, activitycheck)