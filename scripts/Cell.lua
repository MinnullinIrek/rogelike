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
		if self.visible == 1 then
			if self.unit then
				return {text = self.unit.ch, colorFg = (self.visible == 1) and (self.unit.colorFg or color.White) or color.LightGray}
			elseif self.bag and #self.bag > 0 then
				return {text = '$', colorFg = color.Yellow}
			end
		elseif self.seen then
			if self.unit then
				return {text = self.unit.ch, colorFg = color.LightGray}
			end
		end
		return {text = ' '}
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
-- Cell.__newindex = function(self, key, value)
	-- if(key == 'visible') then
		-- rawset (self, 'seen', self.seen or value == 1)
	-- end	
	-- rawset (self, key, value)
-- end

function M.createCell()
	return setmetatable({}, Cell)
end




return M