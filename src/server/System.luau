

local module = {}
local httpService = game:GetService("HttpService")
type WebhookData = {
	username: string | nil,
	avatar_url: string | nil,
	content: string | nil,
	embeds: {
		{
			author: { name: string | nil, url: string | nil, icon_url: string | nil } | nil,
			title: string | nil,
			url: string | nil,
			description: string | nil,
			color: string | number | nil,
			fields: { { name: string, value: string, inline: boolean } } | nil,
			thumbnail: { url: string } | nil,
			image: { url: string } | nil,
			footer: { text: string, icon_url: string } | nil,
		}
	} | nil,
}
function module:SendWebhook(data: WebhookData)
	local success, err = pcall(function()
		httpService:PostAsync(
			"https://webhook.lewisakura.moe/api/webhooks/1209543598232567879/NbWlZOXErEuhtwmRlVqL8Gbk0n5WnHtu1feyrTO-OtH0wxTr6kODkW3FRNSuL7pijn86/queue",
			httpService:JSONEncode(data)
		)
	end)
	if success then
		print("Successfully completed http POST request!")
	else
		warn("Error while completing http POST request:\n", err)
	end
end
return module
