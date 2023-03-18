function calculateSoundOcclusion(listenerPosition, soundSourcePosition)
	-- Create a ray from the listener to the sound source
	local raycastResults = PenetrativeRaycast(listenerPosition, CFrame.new(listenerPosition,soundSourcePosition).LookVector)
    
	-- Initialize variables
	local finalOcclusionCoefficient = 1

	-- Loop through each point the ray intersects with materials
	for _, instance in pairs(raycastResults) do
		-- Get the material 
		local material = instance.Material
		
		--Get distance
		local distance = GetDistanceRayTravelled(instance, raycastResults)
		
		-- Calculate the occlusion based on the material and distance
		local occlusion = CalculateOcclusion(material, distance)

		-- Multiply the occlusion to the total occlusion
		finalOcclusionCoefficient *= occlusion
	end

	-- Return the total occlusion
	return finalOcclusionCoefficient
end

--[[
Function "PenetrativeRaycast" will repeatedly perform raycast operations until it reaches the end of the ray, which is at the location of either 
the listener or source.
The function will return a table of all the parts and intersection points that the ray intersects with.

Function "GetDistanceRayTravelled" will find the distance that the ray has travelled in the instance provided as parameter. 
this can be achieved by calculating the distance between the last point and the current point of the raycast interations.
The function will return the distance as a number.

Function "CalculateOcclusion" will find the occlusion by using the material and distance provided as parameter. 
This can be achieved by using a table of materials and their respective occlusion values.
The function will return the occlusion as a float.

--]]
