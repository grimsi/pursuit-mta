function bindmaverick (player, seat, jacked)
	if getElementModel(source) == 497 then
		if not isKeyBound(player, "k", "down", kufe_on) then
			bindKey(player, "k", "down", kufe_on)
		end
	end
end

function kufe_on (player)
local vehicle = getPedOccupiedVehicle(player)
		if vehicle then
			if not getElementAttachedTo(vehicle) then
				if getElementModel(vehicle) == 497 then
					removePedFromVehicle(player)
					attachElements(player, vehicle, 1.3, 0.6, 0.2)
					unbindKey(player, "k", "down", kufe_on)
					bindKey(player, "k", "down", kufe_down)
					setPedWeaponSlot ( player, 5 )
				end
			else
				outputChatBox("Kufe ist schon besetzt!", 255, 0, 0)
			end
	end
end

function kufe_down (player)
		detachElements(player)
		unbindKey(player, "k", "down", kufe_down)
		bindKey(player, "k", "down", kufe_on)
end

addEventHandler ("onPlayerWasted", getRootElement(), 
function()
	detachElements(source)
end
)

addEventHandler ("onVehicleEnter", getRootElement(),bindmaverick)