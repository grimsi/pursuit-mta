local windowcreated = false

function createMenuAdmin ()
	if( windowcreated == false) then
		local sW, sH = guiGetScreenSize()
		frmMenuAdmin = guiCreateWindow(sW/2 - 200,sH/10, 400, 150, "Pursuit - Adminpanel", false)
		guiWindowSetSizable(frmMenuAdmin,false)
			
		--schliessen = guiCreateButton(0.32,0.82,0.4,0.15,"Schließen",true,frmMenuAdmin)
		schliessen = guiCreateButton(0.32,0.82,0.4,0.15,"Schließen",true,frmMenuAdmin)
		guiSetProperty( schliessen, "HoverTextColour", "FF00FF00" )
		addEventHandler ( "onClientGUIClick", schliessen, triggerWindow, false )
				
		--starten = guiCreateButton(0.01,0.2,0.49,0.6,"Starten",true,frmMenuAdmin)
		starten = guiCreateButton(0.01,0.2,0.5,0.3,"Starten",true,frmMenuAdmin)
		guiSetProperty( starten , "HoverTextColour", "FF00FFFF" )
		addEventHandler ( "onClientGUIClick", starten, start, false )
			
		--neustarten = guiCreateButton(0.52,0.2,0.49,0.6,"Neu starten",true,frmMenuAdmin)
		neustarten = guiCreateButton(0.01,0.51,0.5,0.3,"Neu starten",true,frmMenuAdmin)
		guiSetProperty( neustarten , "HoverTextColour", "FFFFFF00" )
		addEventHandler ( "onClientGUIClick", neustarten, restart, false )
		
		countBox = guiCreateEdit( 0.55, 0.25, 0.29, 0.2, "600", true, frmMenuAdmin )
		guiEditSetMaxLength ( countBox, 3 )
		
		setCount = guiCreateButton(0.85, 0.25,0.2,0.2,"OK",true,frmMenuAdmin)
		guiSetProperty( setCount , "HoverTextColour", "FF00FF00" )
		addEventHandler ( "onClientGUIClick", setCount, setCountdown, false )
		
		fehlertext = guiCreateLabel(0.55,0.51,0.40,0.4,"Fehler: Nur Ziffern erlaubt!", true, frmMenuAdmin)
		erfolgreichtext = guiCreateLabel(0.55,0.51,0.40,0.4,"Countdown geändert", true, frmMenuAdmin)
		guiSetProperty( fehlertext , "TextColour", "FFFF0000" )
		guiSetProperty( erfolgreichtext , "TextColour", "FF00FF00" )
		guiSetVisible ( fehlertext, false )
		guiSetVisible ( erfolgreichtext, false )
			
		guiSetVisible ( frmMenuAdmin, true )
		showCursor ( true )
		guiSetInputEnabled ( true )
		windowcreated = true
	end
end


function triggerWindow (button, state)
	if(button == "left" and state == "up") then
		if guiGetVisible ( frmMenuAdmin ) == false then
			guiSetVisible ( frmMenuAdmin, true )
			showCursor ( true )
			guiSetInputEnabled ( true )
		else
			guiSetVisible ( frmMenuAdmin, false )
			showCursor ( false )
			guiSetInputEnabled ( false )
		end
	end
end

function start()
	--outputChatBox("Spiel wird gestartet", 0, 255, 255)
	triggerServerEvent( "onAllowPlayerSpawn", resourceRoot, localPlayer, "gangster" )
end

function restart()
	outputChatBox("Spiel wird neu gestartet", 255, 255, 0)
	setTimer (restart_resource, 1000, 1)
end

function restart_resource()
	triggerServerEvent( "onResourceRestart", resourceRoot, localPlayer)
 end

function bindWindow()
	triggerWindow("left", "up")
end

function setCountdown()
	if (checkEdit(countBox) == true) then
		counter = tonumber(guiGetText(countBox))
		triggerServerEvent("syncCount", root, counter)
		setTimer(
			function()
				--outputChatBox("Countdown erfolgreich auf "..count.." Sekunden gesetzt", 34, 161, 2)
				guiSetVisible(erfolgreichtext, true)
				guiSetVisible(fehlertext, false)
			end, 100, 1)
	else
		--outputChatBox("Fehler: Du darfst nur Ziffern eingeben", 255, 0, 0)
		guiSetVisible(erfolgreichtext, false)
		guiSetVisible(fehlertext, true)
	end
end

function checkEdit(edit)
    local text = guiGetText(edit)
    if not tonumber(text) then 
		return false
	else
		return true
	end
    local text = tonumber(text)
    --if text < 1 or text < 601 then return true else return false end
end

addEvent( "onAllowAdminPanel", true)
addEventHandler( "onAllowAdminPanel" , localPlayer,
		function ()
			createMenuAdmin()
			bindKey("F2", "down", bindWindow)
		end
)

addEventHandler( "onClientResourceStart", root,
function()
	triggerServerEvent("onBindAdminKey", resourceRoot, localPlayer)
end
)