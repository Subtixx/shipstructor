--- Object init event.
-- Gets executed when this object is placed.
-- @param virtual if this is a virtual call?
function init(virtual)
	if virtual then return end

	-- Set handler for UI message
	message.setHandler("checkController", checkController)
end

--- Object update event
-- Gets executed when this object updates.
-- @param dt delta time, time is specified in *.object as scriptDelta (60 = 1 second)
function update(dt)
end

--- Object on container action event.
-- Gets executed when a player "does" things in the container
-- For example place item in slot, then this function gets called
function containerCallback()
	-- Check valid pod here, if it's not valid "spit" the item back out.
	local podItem = world.containerItemAt(entity.id(), 0) -- << Get item in itemSlot 0

	if podItem == nil then return end -- << Not a valid item, jump out

	if not validatePod(podItem) then -- << Not a valid pod, spit it out
		if world.containerConsume(entity.id(), podItem) then
			if world.spawnItem(podItem, entity.position()) == nil then -- << If the item was not spawned, readd to the container
				world.containerAddItems(entity.id(), podItem)
			end
		end
	end
end

-- Custom functions here

--- Message function, when user clicks button on UI
function checkController()
	-- This is the message that gets send when the button in the GUI is pressed
	-- One could just "re-check" here if it's a valid pod.
	if not validatePod() then return end -- << Don't do anything with the 
end

--- Function to check if the item is a valid pod
-- @param itm The item to check
-- @return true if the item is valid, false otherwise
function validatePod(itm)
	-- Do pod checking here.
	return true
end