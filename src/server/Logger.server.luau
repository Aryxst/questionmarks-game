local System = require(script.Parent.System)
local Players = game:GetService("Players")
local httpService = game:GetService("HttpService")
local logs = {}
local function getPlayerThumbnail(UserId: number): {
	data: { [number]: { targetId: number, state: "Completed" | "Pending", imageUrl: string, version: string } },
}
	local start = tick()
	local url = "https://thumbnails.roproxy.com/v1/users/avatar?userIds="
		.. tostring(UserId)
		.. "&size=420x420&format=Png&isCircular=false"
	local res = httpService:GetAsync(url)
	repeat
		task.wait()
	until res
	print("--[[ Requesting player thumbnail done in " .. string.format("%.3f", tick() - start) .. "s! ]]--")
	return httpService:JSONDecode(res)
end
Players.PlayerAdded:Connect(function(player: Player)
	logs[player.Name] = tick()
end)
Players.PlayerRemoving:Connect(function(player: Player)
	do
		local url = "www.roblox.com/users/" .. player.UserId
		local elapsedSinceJoin = tick() - logs[player.Name]
		System:SendWebhook({
			username = "Roblox Logger",
			content = player.Name
				.. " just left the game and played "
				.. string.format("%.2f minutes(%d seconds)", elapsedSinceJoin / 60, elapsedSinceJoin)
				.. "!",
			embeds = { { image = { url = getPlayerThumbnail(player.UserId).data[1].imageUrl } } },
		})
		logs[player.Name] = nil
	end
end)