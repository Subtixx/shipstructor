function init(args)
	object.setInteractive(true)
end

function onInteraction(args)
	if (not readerBusy()) then
		-- Options for read process
		local readerOptions = {}
		readerOptions.readerPosition = object.toAbsolutePosition({ 0.0, 0.0 })
		readerOptions.spawnPrinterPosition = object.toAbsolutePosition({ 0, 4 })
		readerOptions.breakStuff = config.getParameter("miab_breakStuff", true)
		readerOptions.clearOnly = config.getParameter("miab_clearOnly", false)
		readerOptions.plotJSON = config.getParameter("miab_dumpJSON", false)
		readerOptions.printerCount = config.getParameter("miab_printerCount", 1)
		readerOptions.areaToIgnore = config.getParameter("miab_fixed_area_to_ignore_during_scan_bounding_box", nil) -- [left, bottom, right, top]
		readerOptions.animationDuration = 3
		readerOptions.areaToScan = config.getParameter("miab_fixed_area_to_scan_bounding_box", nil) -- [left, bottom, right, top]
		
		if (readerOptions.areaToScan ~= nil) then
			-- start reading process
			readStart(readerOptions)
		end
	end
end

function update(dt)
	-- this needs to be polled until done
	if (self.miab == nil) then return end -- not initialized
	
	if (self.miab.readingStage) then -- only accessed during read
		if (self.miab.readingStage == READBUILDING) then
			scanBuilding()
			if (self.miab.breakStuff) then destroyBlocks() end
			self.miab.readingStage = SPITOUTPRINTER
		elseif (self.miab.readingStage == SPITOUTPRINTER) then
			if (self.miab.breakStuff) then destroyBlocks() end
			-- spawnPrinterItem()
			produceJSONOutput()
			if (not self.miab.breakStuff) then object.smash() end
			self.miab.readingStage = READSUCCESS
		elseif (self.miab.readingStage == READSUCCESS) then
			self.miab = nil -- reset scanner state
			self.scaned_configTable = blueprint.toConfigTable() -- save scanned table
			blueprint.Init({0, 0}) -- reset blueprint
			
			-- Start to configure writing process
			local writerOptions = {}
			local area_to_scan_bounding_box = config.getParameter("miab_fixed_area_to_scan_bounding_box", nil)
			writerOptions.writerPosition = ({area_to_scan_bounding_box[1],area_to_scan_bounding_box[2]})
			printInit(writerOptions)
			donePrinting = false -- flag to end polling	
		end
	end
	
	if (self.miab.buildingStage) then -- only accessed during write
		if (not donePrinting) then
			-- needs to be polled
			if (self.miab.buildingStage == PRINTINITIALISE) then -- read the Blueprint to be built
				readBlueprint()
			elseif (self.miab.buildingStage == PREVIEWBUILDAREA) then -- display the build area indicator
				self.miab.buildingStage = PLACEBLOCKS
			elseif (self.miab.buildingStage == PLACEBLOCKS) then -- place scaffolding + blocks
				printBlocks()
			elseif (self.miab.buildingStage == PLACETILEMODS) then -- place mods on tiles
				printTileMods()
			elseif (self.miab.buildingStage == REMOVESCAFFOLD) then -- remove scaffolding
				clearScaffolding()
			elseif (self.miab.buildingStage == PLACEOBJECTS) then -- place objects
				printObjects()
			elseif (self.miab.buildingStage == PRINTOBSTRUCTED) then -- area was obstructed
				FloatObstructed()
			elseif (self.miab.buildingStage == PRINTUNANCHORED) then -- area was in a void, no blocks could be placed
				FloatUnanchored()
			elseif (self.miab.buildingStage == PRINTSUCCESS) then
				donePrinting = true
			end
		else
			object.smash()
		end	
	end
end
