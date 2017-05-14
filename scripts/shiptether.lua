function init()
	shipstructorScannerOptions = world.getObjectParameter(pane.sourceEntity(), "checkController") 
	if shipstructorScannerOptions = checkController then
	local items = world.containerItems(entity.id())
	for k, v in pairs(items) do
        world.logInfo("Item: %s", v)
    end

end


