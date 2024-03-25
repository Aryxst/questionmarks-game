local module = {Player = {}}

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local CONSTANTS = { maxRayDistance = 400 }
function module.Player.isFacing()
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	raycastParams.FilterDescendantsInstances = { player.Character }

	local raycastResult = workspace:Raycast(
		workspace.CurrentCamera.CFrame.Position, -- Ray origin (camera position)
		(mouse.Hit.p - workspace.CurrentCamera.CFrame.Position).Unit * CONSTANTS.maxRayDistance, -- Ray direction and length
		raycastParams -- Raycast parameters
	)

	if raycastResult then
--[[ 		print(
			("Hit something: %s, which is %.1f studs away!"):format(raycastResult.Instance.Name, raycastResult.Distance)
		) ]]
	else
		--[[ print("Didn't hit anything") ]]
	end
end
return module
