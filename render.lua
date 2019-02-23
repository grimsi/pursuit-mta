local screenWidth, screenHeight = guiGetScreenSize()
count = 600
local lookX = 0
local won = false

function render_logo()
	if( isPedDead(localPlayer) and isPlayerInTeam(localPlayer) == false) then
		setCameraMatrix(1468.8785400391, -919.25317382813, 100.153465271, 1468.388671875 + lookX, -918.42474365234, 100.2)
		dxDrawImage ( screenWidth/2 - 512, screenHeight/2 - 128, 1024, 256, 'pictures/logo.png')
		lookX = lookX + 0.001
	else
		dxDrawImage ( screenWidth - 256 - 100, 0, 256 , 64, 'pictures/logo2.png')
	end
end

function deathMessage()
	if(isPedDead(localPlayer)) then
		dxDrawText( "Wasted!", 0, 0, screenWidth, screenHeight, tocolor ( 255, 0, 0, 255 ), 4, "pricedown", "center", "center" )
	end
end

function handleRendering()
	setTimer(function()
		addEventHandler("onClientRender", root, deathMessage)
	end, 3000, 1)
	fadeCamera ( false, 3.0, 0, 0, 0 )
end

function handleRenderLogo()
	addEventHandler("onClientRender", root, render_logo)
	fadeCamera ( true, 0, 0, 0, 0 )
end

function drawCountdown()
      if (count > 0) then
				leftMinutes, leftSeconds = convertSToMinutesSeconds(count)
		if (count > 60) then
			dxDrawText(("%d:%d"):format(leftMinutes, leftSeconds), 0, 0, screenWidth, screenHeight, tocolor ( 255, 255, 255, 255 ), 2, "pricedown", "center", "top" )
		elseif (count == 60) then
			dxDrawText(("%d:%d"):format(leftMinutes, leftSeconds), 0, 0, screenWidth, screenHeight, tocolor ( 255, 255, 255, 255 ), 2, "pricedown", "center", "top" )
		elseif (count < 60) then
			dxDrawText(("%d:%d"):format(leftMinutes, leftSeconds), 0, 0, screenWidth, screenHeight, tocolor ( 255, 0, 0, 255 ), 2, "pricedown", "center", "top" )
		end
      end
end

function countdown()
	if (count > 0) then
		count = count - 1
		setTimer(countdown, 1000, 1)
	elseif (count == 0) then
		triggerServerEvent("onCountZero", root)
	end
	
	if (count == 60) then
		triggerServerEvent("syncCount", root, count)
	end
end

function syncCountdown_s(counter)
		count = counter
		--outputChatBox("Countdown erfolgreich synchronisiert auf "..count.." Sekunden!", 34, 161, 2)
end

function handleCountdown()
	addEventHandler("onClientRender", root, drawCountdown)
	countdown()
end

function convertSToMinutesSeconds(s)

	local minutes = math.floor(s/60)
	local leftSeconds = s % 60
	
	return minutes, leftSeconds
end

function handleRenderPolice()
	if (won == false) then
		addEventHandler("onClientRender", root, renderPolice)
		won = true
	end
end

function handleRenderGangster()
	if (won == false) then
		addEventHandler("onClientRender", root, renderGangster)
		won = true
	end
end

function renderPolice()
	dxDrawText( "Polizei gewinnt!", 0, screenHeight/4, screenWidth, screenHeight, tocolor ( 0, 0, 255, 255 ), 5, "pricedown", "center")
end

function renderGangster()
	dxDrawText( "Gangster gewinnen!", 0, screenHeight/4, screenWidth, screenHeight, tocolor ( 255, 0, 0, 255 ), 5, "pricedown", "center")
end

function isPlayerInTeam(player, team)
    assert(isElement(player) and getElementType(player) == "player", "Bad argument 1 @ isPlayerInTeam [player expected, got " .. tostring(player) .. "]")
    assert((not team) or type(team) == "string" or (isElement(team) and getElementType(team) == "team"), "Bad argument 2 @ isPlayerInTeam [nil/string/team expected, got " .. tostring(team) .. "]")
    return getPlayerTeam(player) == (type(team) == "string" and getTeamFromName(team) or (type(team) == "userdata" and team or (getPlayerTeam(player) or true)))
end

addEvent("playerWasted", true)
addEventHandler("playerWasted", localPlayer, 
	function()
		handleRendering()
	end
)

addEvent("startCountdown", true)
addEventHandler("startCountdown", localPlayer, handleCountdown)

addEvent("onPolicewin", true)
addEventHandler("onPolicewin", localPlayer, handleRenderPolice)

addEvent("onGangsterwin", true)
addEventHandler("onGangsterwin", localPlayer, handleRenderGangster)

addEvent("syncCount_s", true)
addEventHandler("syncCount_s", localPlayer, syncCountdown_s, counter)

addEventHandler( "onClientResourceStart", getRootElement(), handleRenderLogo)
