local RunService = game:GetService("RunService")
local module = {}
local IsStudio = RunService:IsStudio()
function module.Start()
	if IsStudio then
		local MapObjects = workspace.Map:GetDescendants()
		for k, obj: Part in ipairs(MapObjects) do
			if obj.Name == "Spawn" then
				local Highlight = Instance.new("Highlight")
				Highlight.Parent = obj
				Highlight.FillColor = Color3.new(255, 0, 0)
				Highlight.OutlineColor = Color3.new(255, 0, 0)
				Highlight.OutlineTransparency = 0
				Highlight.FillTransparency = 0
				obj.Transparency = 0
			end
		end
	end
end
function module.assertStudio(condition: boolean, cb:() -> ())
	if IsStudio == condition then
		cb()
	end
end
return module