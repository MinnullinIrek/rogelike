M = {}
local dname = "cell: "

local function print(...) oprint(dname, ...) end




local Cell = 
{
	-- Unit
	-- Bag
	visible = 0,
	setUnit = function(self, unit)
		self.unit = unit
	end,
	
	getChar = function(self)
		if self.visible > 0 then
			if     self.unit then
						return {text = self.unit.ch, colorFg = (self.visible == 1) and color.White or color.LightGray}
			elseif self.bag and #self.bag > 0then
						return {text = '$', colorFg = color.Yellow}
			end
			return {text = '.'}
		else
			return {text = ' '}
		end
		
	end,
	
	putItem = function(self, item)
		self.bag = self.bag or {}
		table.insert(self.bag, item)
	end,
	
	putBag = function(self, bag)
		if self.bag == nil then
			self.bag = bag
		else
			for i, item in ipairs(bag) do
				table.insert(self.bag, item)
			end
			
			while table[0] ~= nil do
				table.remove(0)
			end
		end
		
	end,
}
Cell.__index = Cell

function M.createCell()
	return setmetatable({}, Cell)
end




return M