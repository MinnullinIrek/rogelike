M = {}

local Cell = 
{
	-- Unit
	-- Bag
}

function M.createCell(unit)
	return setmetatable({}, Cell)
end


return M