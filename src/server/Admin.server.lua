--[[ local gameObjects = game:GetService("ReplicatedStorage")["Game_Objects"] ]]
local PREFIX = "!"
game.Players.PlayerAdded:Connect(function(player: Player)
	player.Chatted:Connect(function(message)
		if player.UserId == game.CreatorId and message:sub(1, 1) == PREFIX then
			local args = message:split(" ")
			local cmd_name = args[1]:sub(2)
			local character = player.Character
			if cmd_name == "togglecam" then
				player.CameraMode = player.CameraMode == Enum.CameraMode.Classic and Enum.CameraMode.LockFirstPerson
					or Enum.CameraMode.Classic
			elseif cmd_name == "speed" then
				local hum: Humanoid? = character:FindFirstAncestorOfClass("Humanoid")
				if character and hum then
					hum.WalkSpeed = tonumber(args[2]) or 16
				end
			end
		end
	end)
end)
