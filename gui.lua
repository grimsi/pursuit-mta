addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), 
	function ()
		createMenuPursuit ()
	end
)

function createMenuPursuit ()
	local sW, sH = guiGetScreenSize()
	frmMenuPursuit = guiCreateWindow(sW/2 - 200,sH - 170, 400, 150, "Pursuit by Cr4zyPi3t", false)
	guiWindowSetSizable(frmMenuPursuit,false)
	
	cmdClose = guiCreateButton(0.32,0.82,0.4,0.15,"Schließen",true,frmMenuPursuit)
	guiSetProperty( cmdClose, "HoverTextColour", "FF00FF00" )
	addEventHandler ( "onClientGUIClick", cmdClose, closeWindow, false )
		
	setPolizei = guiCreateButton(0.01,0.2,0.49,0.6,"Polizei",true,frmMenuPursuit)
	guiSetProperty( setPolizei , "HoverTextColour", "FF0000FF" )
	addEventHandler ( "onClientGUIClick", setPolizei, spawnPolizei, false )
	
	setGangster = guiCreateButton(0.52,0.2,0.49,0.6,"Gangster",true,frmMenuPursuit)
	guiSetProperty( setGangster , "HoverTextColour", "FFFF0000" )
	addEventHandler ( "onClientGUIClick", setGangster, spawnHandlanger, false )
	
	guiSetVisible ( frmMenuPursuit, true )
	showCursor ( true )
	guiSetInputEnabled ( true )
end

function closeWindow (button, state)
	if(button == "left" and state == "up") then
		if guiGetVisible ( frmMenuPursuit ) == false then
			guiSetVisible ( frmMenuPursuit, true )
			showCursor ( true )
			guiSetInputEnabled ( true )
		else
			guiSetVisible ( frmMenuPursuit, false )
			showCursor ( false )
			guiSetInputEnabled ( false )
		end
	end
end

function bindWindow2()
	closeWindow("left", "up")
end

bindKey("F1", "down", bindWindow2)

function spawnHandlanger()
	triggerServerEvent( "setHandlanger", resourceRoot, localPlayer)
end

function spawnPolizei()
	triggerServerEvent( "setPolizei", resourceRoot, localPlayer)
end