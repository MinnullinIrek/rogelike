local M = {}
local chars = require 'chars'

local dname = "mover: "

local function print(...) oprint(dname, ...) end


local function interaction(attacker, defender)
	chars.attack(attacker, defender)
end


local Mover = 
{
	coords = {x, y},
	-- unit 
	-- map
	jumpTo = function(self, x, y) 
		local cell = self.map:getCell(x, y)
		if not cell.unit then
			self.map:setUnit(self.coords.x, self.coords.y, nil)
			self.map:setUnit(x, y, self.unit)
			self.coords.x = x
			self.coords.y = y
		else
			interaction(self, cell.unit)
		end
	end
	
}
Mover.__index = Mover

M.heroMover = setmetatable({coords = {x =0, y=0}, 
							jumpTo = function(self, x, y) 
								self.unit:setVisibility(false)
								local cell = self.map:getCell(x, y)
								if not cell.unit then
									self.map:setUnit(self.coords.x, self.coords.y, nil)
									self.map:setUnit(x, y, self.unit)
									self.coords.x = x
									self.coords.y = y
								end
								self.unit:setVisibility(true)
							end}, Mover)



function M.setDir(dir)
	
	local coords = M.heroMover.coords
	
	local dx, dy = 0, 0
	
	if     dir == 'down'     then
		dy = dy + 1
	elseif dir == 'up'       then
		dy = dy - 1
	elseif dir == 'left'     then
		dx = dx - 1
	elseif dir == 'right'    then
		dx = dx + 1
	elseif dir == 'home'     then
		dy = dy - 1
		dx = dx - 1
	elseif dir == 'endus'    then
		dy = dy + 1
		dx = dx - 1
	elseif dir == 'pageUp'   then
		dy = dy - 1
		dx = dx + 1
	elseif dir == 'pageDown' then
		dy = dy + 1
		dx = dx + 1
	end
	
	local x = coords.x + dx
	local y = coords.y + dy
	
	
	
	M.heroMover:jumpTo(x, y) 
end


return M