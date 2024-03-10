local module = {}
function module.Spawns()--[[ : { Part } ]]
	local MapObjects = workspace.Map:GetDescendants()
	local res = {}
	for k, obj: Instance in ipairs(MapObjects) do
		if obj:IsA("Part") and obj.Name == "Spawn" then
			table.insert(res, obj)
		end
	end
	return res
end

return module
