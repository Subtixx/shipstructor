--[[

This script is highly experimental please help if you know how to lua better than I

The Ship tether will work as follows (planed not implemented):

1) player will insert valid ship pod
2) Big red button in GUI can now be pressed to start ship replacement
3) cinematic of variable length being played (based on a value stored in provided ship pod)
4) shit tether now scans the ship world  (the scan is stored in a new ship pod)
5) ship tether breaks ship (and prints the contents of the original pod)
6) cinematic ends (player now has shinny new ship)

--]]


-- on button press check if the item is a valid ship pod (read a value in the item)
function shipthetherGUI()
	world.sendEntityMessage(pane.sourceEntity(), "checkController")

-- If a ship pod then trigger new function
end

function shiptetherCinematic()
-- Play a Cinematic for a certain amount of time based on "cinematicLength" stored in item file
end
