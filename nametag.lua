root = getRootElement ()
players = getElementsByType ("player")
 
function ResourceStart ( name, root )
    for k,v in ipairs ( players ) do
        setPlayerNametagShowing (v, false)
    end
end
addEventHandler("onResourceStart", root, ResourceStart)
 
function PlayerJoin ()
	setPlayerNametagShowing (source, false)
end
addEventHandler("onPlayerJoin", root, PlayerJoin)