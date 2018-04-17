M = {}
local dname = "cell: "

local function print(...) oprint(dname, ...) end



local Cell = 
{
	-- Unit
	-- Bag
	setUnit = function(self, unit)
		self.unit = unit
	end,
	
	getChar = function(self)
		return (self.unit or {}).ch or '.'
	end,
}
Cell.__index = Cell

function M.createCell()
	return setmetatable({}, Cell)
end




return M