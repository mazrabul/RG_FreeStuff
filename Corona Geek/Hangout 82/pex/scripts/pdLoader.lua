local function pdLoader( group, x, y, name, params )

	local params 	= params or {}
	local width 	= params.width or 200
	local height 	= params.height or width
	local scale 	= params.scale or 1
	local ex 		= params.ex or 0
	local ey 		= params.ey or 0
	local imageRoot	= params.imageRoot or ""
	local altTexture = params.altTexture

	local sample = display.newContainer( group, width, height)
	sample.x = x
	sample.y = y

	local tmp = display.newRect( sample, 0, 0, width, height )
	tmp.x = 0
	tmp.y = 0
	tmp:setFillColor( 0,0,0,0 )
	tmp:setStrokeColor( 1, 1, 0, 1 )
	tmp.strokeWidth = 4

	-- Load and Display Particle(s)
	print("Loading particle data file: " .. imageRoot .. name .. ".json")
	local data = table.load( imageRoot .. name .. ".json", system.ResourceDirectory )		
	if( altTexture ) then
		data.textureFileName = altTexture 
	end

	data.textureFileName = imageRoot .. data.textureFileName

	if( data.particleLifespan and data.particleLifespan == 0) then
		print( "Fixing data.particleLifespan, must be non-zero ", data.particleLifespan, " Changing to 0.0001 ")
		data.particleLifespan = 0.0001
	end

	data.textureImageData = nil -- Test!  This field not used by Corona

	table.dump(data)	

	local emitter = display.newEmitter( data )
	emitter.x = ex
	emitter.y = ey
	
	sample:insert( emitter )

	return sample
end

return pdLoader