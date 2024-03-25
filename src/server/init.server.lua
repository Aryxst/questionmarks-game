local RS = game:GetService("ReplicatedStorage")
local TS = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local Dev = require(script.Dev)
local Events = require(script.Events)
local Pathfinding = require(RS.Shared.Pathfinding)
local ClientCall = RS.Events.ClientCall
Dev.Start()
task.spawn(function()
	task.wait(5)
	local spots = workspace.Map.Spots:GetChildren()
	local body = workspace.body
	body.CanCollide = false
	Dev.assertStudio(true, function()
		body.Transparency = 0

		local Highlight = Instance.new("Highlight", body)
		Highlight.FillColor = Color3.new(255, 0, 0)
		Highlight.OutlineColor = Color3.new(255, 0, 0)
		Highlight.OutlineTransparency = 0
		Highlight.FillTransparency = 0
		ClientCall:FireAllClients("focuspart")
	end)
	Pathfinding.Draw({
		steps = {
			spots[math.random(1, #spots)].Position + Vector3.new(0, body.Position.Y),
			spots[math.random(1, #spots)].Position + Vector3.new(0, body.Position.Y),
		},
		-- cb runs for every waypoint created
		cb = function(data, waypoint, prev, i, max)
			-- basically the loop is finished

			if not (waypoint and waypoint.Position) then
				return
			end
			local pos = waypoint.Position
			local part = Instance.new("Part")
			part.Position = pos
			part.Size = Vector3.new(0.5, 0.5, 0.5)
			part.Color = Color3.new(1, 0, 1)
			part.Anchored = true
			part.CanCollide = false
			part.Parent = workspace
			Dev.assertStudio(false, function()
				part.Transparency = 1
			end)

			local distance = math.abs((prev.Position - waypoint.Position).Magnitude)
			if distance ~= 0 then
				print(("Current Step: %s, Next waypoint distance: %.2f studs"):format(i .. "/" .. max, distance))
			end
			local tween = TS:Create(
				body,
				TweenInfo.new(
					math.abs((body.Position - pos).Magnitude) / 30,
					Enum.EasingStyle.Sine,
					Enum.EasingDirection.Out
				),
				{ CFrame = CFrame.new(pos.X, body.CFrame.Y, pos.Z) }
			)
			tween:Play()

			tween.Completed:Wait()
			part:Destroy()
		end,
	})
end)

task.spawn(function()
	local sounds: { Sound } = SoundService.Jumpscares:GetChildren()
	while true do
		local selectedSound: Sound = sounds[math.random(1, #sounds)]
		local soundDelay = selectedSound:GetAttribute("delay") or 60
		print(selectedSound)
		task.wait(soundDelay)
		Dev.assertStudio(false, function()
			selectedSound:Play()
		end)
		local attr: string = selectedSound:GetAttribute("event")
		print("EVENT ATTRIBUTE: " .. (attr or "none"))
		if attr then
			local EventFunction = Events[attr:lower()]
			if EventFunction then
				EventFunction()
			else
				print(('No event bound to sound "%s"!'):format(selectedSound.Name))
			end
		end
	end
end)
