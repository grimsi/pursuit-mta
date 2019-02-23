function winconditions()
	if ( countPlayersInTeam(gangster) == 0 ) then
		policewin()	
	elseif ( countPlayersInTeam(polizei) == 0 ) then
		gangsterwin()
	end
end

function restart()
	triggerEvent("onResourceRestart", root)
end

function policewin()
	setTimer(restart, 5000, 1)
	for i,player in ipairs(getElementsByType("player")) do
		setTimer(function()
					killPed(player)
				end
				, 4000, 1)
		triggerClientEvent(player, "onPolicewin", player)
	end
end

function gangsterwin()
	setTimer(restart, 5000, 1)
	for i,player in ipairs(getElementsByType("player")) do
		setTimer(function()
					killPed(player)
				end
				, 4000, 1)
		triggerClientEvent(player, "onGangsterwin", player)
	end
end

function syncCountdown(counter)
	for i,player in ipairs(getElementsByType("player")) do
		triggerClientEvent(player, "syncCount_s", player, counter)
	end
end
	
addEvent("onCountZero", true)
addEventHandler("onCountZero", resourceRoot, gangsterwin)

addEvent("onCheckWin", true)
addEventHandler("onCheckWin", resourceRoot, winconditions)

addEvent("syncCount", true)
addEventHandler	("syncCount", resourceRoot, syncCountdown, counter)