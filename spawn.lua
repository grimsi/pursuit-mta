function spawn(player)
	if not isElement(player) then return end
		setPlayerBlurLevel ( player, 0 )
		takeAllWeapons(player)
			if (getPlayerTeam(player) == polizei) then
				spawnPlayer ( player, 1556+math.random(1,25), -1701+math.random(1,10), 8.43, 90, math.random(280,285), 0, 0)
				fadeCamera(player, true)
				setCameraTarget(player, player)
				setPlayerWantedLevel ( player, 0 )
				setPedArmor ( player, 100 )
				giveWeapon(player, 31, 200)
				giveWeapon(player, 23, 97, true)
			elseif (getPlayerTeam(player) == handlanger) then
				spawnPlayer ( player, 1369+math.random(1,3), -1632+math.random(1,20), 15.52, 90, math.random(138,140), 0, 0)
				fadeCamera(player, true)
				setCameraTarget(player, player)
				setPedArmor ( player, 50 )
				giveWeapon(player, 24, 200)
				giveWeapon(player, 32, 200, true)
				setPlayerWantedLevel ( player, 3 )
				giveWeapon(player, 39, 2)
				giveWeapon(player, 40, 1)
			elseif (getPlayerTeam(player) == gangster) then
				spawnPlayer ( player, 1369+math.random(1,3), -1632+math.random(1,20), 15.52, 90, 292, 0, 0)
				fadeCamera(player, true)
				setCameraTarget(player, player)
				setPedArmor ( player, 100 )
				giveWeapon(player, 30, 300)
				giveWeapon(player, 24, 300)
				giveWeapon(player, 32, 300, true)
				giveWeapon(player, 39, 2)
				giveWeapon(player, 40, 1)
				setPlayerWantedLevel ( player, 6 )
				gangsterMarker = createMarker ( 0, 0, 0, "arrow", .75, 255, 0, 0, 170 )
				attachElements ( gangsterMarker, player, 0, 0, 2 )
			end
		fadeCamera(player, true)
		setCameraTarget(player, player)
end

function enableAdminPanel(player)
		local accName = getAccountName ( getPlayerAccount ( player ) )
		if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) then
			triggerClientEvent(player, "onAllowAdminPanel", player)
			unbindKey(player, "F2", "down", enableAdminPanel)
		else
			outputChatBox("Du bist kein Admin", player, 255, 0, 0) 
		end
end

function bindAdminPanelKey(thePlayer)
	bindKey(thePlayer, "F2", "down", enableAdminPanel, thePlayer)
end

function setGangster()
	if not (countPlayersInTeam (handlanger) == 0) then
		--theGangster = getRandomPlayer()
		--if (getPlayerTeam(theGangster) == handlanger) then
			handlangerPlayers = getPlayersInTeam(handlanger)
			theGangster = handlangerPlayers[math.random(1, countPlayersInTeam(handlanger))]
			setPlayerTeam(theGangster, gangster)
			outputChatBox("#FF0000"..getPlayerName ( theGangster ).." #FFFFFFist der Gangster!", getRootElement(), 0, 0, 0, true)
			for i,player in ipairs(getElementsByType("player")) do
				spawn(player)
				triggerClientEvent(player, "startCountdown", player)
			end
		--end
	else
		outputChatBox("Es gibt noch keine Gangster!", getRootElement())
	end
end

function checkStart()
	if ((countPlayersInTeam(polizei) + countPlayersInTeam(handlanger)) == getPlayerCount() ) then
		triggerEvent("onAllowPlayerSpawn", root)
	end
end

addEvent( "onAllowPlayerSpawn",true )
addEventHandler( "onAllowPlayerSpawn", resourceRoot, 
	function(player)
		setGangster()
	end
)

addEventHandler ( "onPlayerWasted", root, 
function ()
	--fadeCamera ( source, false, 3.0, 0, 0, 0 )
	triggerClientEvent(source, "playerWasted", source)
	setPlayerTeam(source, gefallene)
	triggerEvent("onCheckWin", root)
end
)

addEventHandler("onResourceStart", resourceRoot,
	function()
	for i = 1, 20, 1 do
			outputChatBox( " " )
	end
	polizei = createTeam ( "Polizei", 0,0,255 )
	gangster = createTeam ( "Gangster", 255,0,0 )
	handlanger = createTeam ( "Handlanger", 255, 0, 0)
	gefallene = createTeam ( "Gefallene", 0, 0, 0)
		for i,player in ipairs(getElementsByType("player")) do
			killPed(player)
			--outputChatBox("Pursuit wurde gestartet!", player, 0, 255, 0)
			outputChatBox("Drücke 'F9' für Hilfe", player, 0, 0, 255)
			outputChatBox("Das Spiel startet, sobald jeder Spieler ein Team gewählt hat!", player, 0, 255, 0)
		end
	end
)

addEvent("onBindAdminKey", true)
addEventHandler ("onBindAdminKey", resourceRoot, 
function()
	bindAdminPanelKey(client)
end
)

addEvent("setPolizei", true)
addEventHandler ("setPolizei", resourceRoot, 
function()
	if isPedDead(client) then
		if not ( getPlayerTeam(client) == gefallene ) then
			setPlayerTeam(client, polizei)
			checkStart()
		else
			outputChatBox("Du kannst dein Team nach Spielstart nicht wechseln!", client, 255, 0, 0)
		end
	else
		outputChatBox("Du kannst dein Team nach Spielstart nicht wechseln!", client, 255, 0, 0)
	end
end
)

addEvent("setHandlanger", true)
addEventHandler ("setHandlanger", resourceRoot, 
function()
	if isPedDead(client) then
		if not ( getPlayerTeam(client) == gefallene ) then
			setPlayerTeam(client, handlanger)
			checkStart()
		else
			outputChatBox("Du kannst dein Team nach Spielstart nicht wechseln!", client, 255, 0, 0)
		end
	else
		outputChatBox("Du kannst dein Team nach Spielstart nicht wechseln!", client, 255, 0, 0)
	end
end
)

addEvent("onResourceRestart", true)
addEventHandler("onResourceRestart", resourceRoot,
function()
		 if ( hasObjectPermissionTo ( getThisResource (), "function.restartResource") ) then
			restartResource( getResourceFromName( 'pursuit' ) )
		else
			outputChatBox("Fehler: Resource hat keine Adminrechte!", client, 255, 0, 0)
		end
		
end
)