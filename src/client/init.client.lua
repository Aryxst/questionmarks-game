local UIS = game:GetService("UserInputService")
local RS = game:GetService("ReplicatedStorage")
local ClientCall = RS.Events.ClientCall
local Detect = require(script.Detectors)
local LocalPlayer = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
if LocalPlayer.UserId ~= require(RS.Shared.Constants).CREATOR_ID then
	game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
end
LocalPlayer.CharacterAdded:Wait()
-- Instances
local character = LocalPlayer.Character
local hrp: BasePart = character:FindFirstChild("HumanoidRootPart")

UIS.MouseIconEnabled = false

--[[ task.spawn(function()
	while wait(1) do
		Detect.Player.isFacing()
	end
end) ]]

ClientCall.OnClientEvent:Connect(function(...)
	local event = { ... }
	print(event)
	if event[1] == "focuspart" then
		game:GetService("RunService").RenderStepped:Connect(function()
			camera.CFrame = CFrame.lookAt(camera.CFrame.Position, workspace.body.Position)
		end)
	end
end)
