--[[ local Players = game:GetService("Players") ]]
local RS = game:GetService("ReplicatedStorage")
local TS = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
--[[ local Getter = require(script.Getter) ]]
local Events = require(script.Events)
do
	task.wait(2)
	local Pathfinding = require(RS.Shared.Pathfinding)
	local body = workspace.body
	Pathfinding.draw({
		startPosition = workspace.start.Position,
		finishPosition = workspace.finish.Position,
		-- cb runs for every waypoint created
		cb = function(waypoint)
			local part = Instance.new("Part")
			part.Position = waypoint.Position
			part.Size = Vector3.new(0.5, 0.5, 0.5)
			part.Color = Color3.new(1, 0, 1)
			part.Anchored = true
			part.CanCollide = false
			part.Parent = workspace

			local tween = TS:Create(
				body,
				TweenInfo.new(5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
				{ CFrame = CFrame.new(part.CFrame.X, body.CFrame.Y, part.CFrame.Z) }
			)
			tween:Play()

			tween.Completed:Wait()
		end,
	})
end
task.spawn(function()
	local sounds: { Sound } = SoundService.Jumpscares:GetChildren()
	while true do
		local selectedSound: Sound = sounds[math.random(1, #sounds)]
		local soundDelay = selectedSound:GetAttribute("delay") or 60
		print(selectedSound)
		task.wait(soundDelay)
		selectedSound:Play()
		local attr: string = selectedSound:GetAttribute("event")
		print("ATTRIBUTE: %s", attr)
		if attr then
			local EventFunction = Events[attr:lower()]
			if EventFunction then
				EventFunction()
			else
				print(('No event bound to sound "%s"'):format(selectedSound.Name))
			end
		end
	end
end)