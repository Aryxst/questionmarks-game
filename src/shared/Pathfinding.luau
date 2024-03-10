
local module = {}
local PathfindingService = game:GetService("PathfindingService")
-- This model contains a start, end and three paths between the player can walk on: Snow, Metal and LeafyGrass
function module.draw(data: {
	startPosition: Vector3,
	finishPosition: Vector3,
	properties: { any } | nil,
	cb: (waypoint: PathWaypoint) -> any,
})
	-- Create a path that avoids Snow and Metal materials
	-- This will ensure the path created avoids the Snow and Metal paths and guides
	-- the user towards the LeafyGrass path
	local path = PathfindingService:CreatePath(data.properties or {
		AgentRadius = 3,
		AgentHeight = 6,
		AgentCanJump = false,
		-- defaults to 4, math.huge attempts to create as less waypoints as possible
		WaypointSpacing = math.huge,
		Costs = {
			Snow = math.huge,
			Metal = math.huge,
		},
	})

	-- Compute the path
	local success, errorMessage = pcall(function()
		path:ComputeAsync(data.startPosition, data.finishPosition)
	end)

	-- Confirm the computation was successful
	if success and path.Status == Enum.PathStatus.Success then
		-- For each waypoint, create a part to visualize the path
		for _, waypoint in path:GetWaypoints() do
			data.cb(waypoint)
		end
	else
		print(`Path unable to be computed, error: {errorMessage}`)
	end
end
return module
