function feuergeben ( playerSource )
	local CurrentVehicle = getPedOccupiedVehicle(playerSource)
	if CurrentVehicle then
		destroyElement(CurrentVehicle)
	end
    local x, y, z = getElementPosition ( playerSource )
    local feuer = createVehicle ( 432, x, y, z + 1)
	warpPedIntoVehicle ( playerSource, feuer )
	outputChatBox(getPlayerName( playerSource ).." hat einen Cheat aktiviert!", getRootElement(), 255, 1, 218)
end

function biergeben ( playerSource )
	local CurrentVehicle = getPedOccupiedVehicle(playerSource)
	if CurrentVehicle then
		destroyElement(CurrentVehicle)
	end
    local x, y, z = getElementPosition ( playerSource )
    local bier = createVehicle ( 411, x, y, z + 1)
	addVehicleUpgrade ( bier, 1083 )
	warpPedIntoVehicle ( playerSource, bier )
	outputChatBox(getPlayerName( playerSource ).." hat einen Cheat aktiviert!", getRootElement(), 255, 1, 218)
end

function essengeben ( playerSource )
	setElementModel(playerSource, 205)
	outputChatBox(getPlayerName( playerSource ).." hat einen Cheat aktiviert!", getRootElement(), 255, 1, 218)
end

function partymachen (playerSource)
	local skins = {249, 252, 264, 241, 232, 178, 167, 130, 82, 81, 260}
	for k,v in ipairs ( players ) do
		setElementModel(v, skins[math.random(1, 11)])
        setPlayerNametagShowing (v, true)
    end
	outputChatBox(getPlayerName( playerSource ).." hat einen Cheat aktiviert!", getRootElement(), 255, 1, 218)
end

addCommandHandler ( "gibmirbier", biergeben)
addCommandHandler ( "ichbrauchfeuer", feuergeben)
addCommandHandler ( "ichhabehunger", essengeben)
addCommandHandler ( "party", partymachen)