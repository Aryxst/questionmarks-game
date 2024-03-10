game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Detect = require(script.Detectors)
local LocalPlayer = game.Players.LocalPlayer
LocalPlayer.CharacterAdded:Wait()
local mouse = LocalPlayer:GetMouse()
-- Instances
local ui = game:GetService("StarterGui")
local character = LocalPlayer.Character
local hrp: BasePart = character:FindFirstChild("HumanoidRootPart")

UIS.MouseIconEnabled = false

task.spawn(function()
	while wait(1) do
		Detect.Player.isFacing()
	end
end)
