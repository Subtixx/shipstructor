--[[ 

This script is highy experimental please help if you know how to lua better than I

The Ship tether will work as follows (planed not implemented):

1) player will insert valid ship pod
2) Big red button in GUI can now be pressed to start ship replacement
3) Cinimatic of variable length being played (based on a value stored in provided ship pod)
4) shit tether now scans the shipworld  (the scan is stored in a new ship pod)
5) ship tether breaks ship (and prints the contents of the orriginal pod)
6) cinimatic ends (player now has shiney new ship)

--]]


-- on button press check if the item is a valid ship pod (read a value in the item)
function shipthetherGUI()
	world.sendEntityMessage(pane.sourceEntity(), "checkController")

-- If a ship pod then trigger new function
end

function shiptetherCinematic()
-- Play a Cinimatic for a certian amount of time based on "cinimaticLength" stored in item file 
end
