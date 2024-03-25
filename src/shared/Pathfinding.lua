local module = {}
local PathfindingService = game:GetService("PathfindingService")
type agentParameters = {
	AgentRadius: number | nil,
	AgentHeight: number | nil,
	AgentCanJump: boolean | nil,
	WaypointSpacing: number | nil,
	Costs: { [string]: number },
}
type Data = {
	-- TODO: add a steps property {pos1, pos2, pos3} instead of startPosition and finishPosition
	-- Its just if next in steps then module.Draw(...) its quite easy, but i dont care now
	steps: { Vector3 },
	properties: agentParameters | nil,
	cb: (data: Data, waypoint: PathWaypoint, prev: PathWaypoint, i: number, max: number) -> any,
}

function module.Draw(data: Data)
	if #data.steps < 1 then
		warn("Expected at least two steps, got one!")
		return
	end
	local jobName = tostring(buffer.fromstring(tostring(tick())))
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
	print(("-"):rep(100))
	print(`Started path moving job {jobName}`)
	local start = tick()
	for i = 1, #data.steps do
		if not data.steps[i + 1] then
			return
		end
		-- Compute the path
		local success, errorMessage = pcall(function()
			path:ComputeAsync(data.steps[i], data.steps[i + 1])
		end)
		-- Confirm the computation was successful
		if success and path.Status == Enum.PathStatus.Success then
			-- For each waypoint, create a part to visualize the path
			local _ = path:GetWaypoints()

			for k, waypoint in _ do
				if not waypoint then
					return
				end
				data.cb(data, _[k + 1], waypoint, k, #_ - 1)
			end
			print(("Done with path moving job %s, took %.2fs!\n"):format(jobName, tick() - start), ("-"):rep(100))
		else
			print(`Path unable to be computed, error: {errorMessage}`)
		end
	end
end
return module
