local System = require(script.Parent.System)
local Players = game:GetService("Players")
local logs = {}

Players.PlayerAdded:Connect(function(player: Player)
	logs[player.Name] = tick()
end)
Players.PlayerRemoving:Connect(function(player: Player)
	local elapsedSinceJoin = tick() - logs[player.Name]
	System:SendWebhook({
		username = "Roblox Logger",
		content = "",
		embeds = {
			{
				author = {
					name = `{player.Name}(AKA {player.DisplayName})`,
					url = `https://www.roblox.com/users/{player.UserId}/profile`,
				},
				fields = {
					{ name = "Player UserId", value = player.UserId, inline = true },
					{
						name = "Time Played",
						value = string.format("%.2f minutes(%d seconds)", elapsedSinceJoin / 60, elapsedSinceJoin),
						inline = true,
					},
				},
			},
		},
	})

	logs[player.Name] = nil
end)
