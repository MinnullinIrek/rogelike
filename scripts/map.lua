local M = {}
local cell = require 'cell'
local Unit = require 'unit'

local dname = "map: "

local function print(...) oprint(dname, ...) end



print("map")
local map = {
	rowCount = 0,
	colCount = 0,	
	cells = {},
	getCell = function(self, row, column)
		self.cells[row] = self.cells[row] or {}
		self.cells[row][column] = self.cells[row][column] or cell.createCell()
		
		return self.cells[row][column]
	end,
	
	setUnit = function(self,  row, column, unit)
		local cell = self:getCell(row, column)
		cell:setUnit(unit)
		if unit and unit.mover then
			unit.mover.coords.x = row
			unit.mover.coords.y = column
			unit.mover.map = self
		end
	end
	
	
}

map.__index = map

function M.setUnit(map, row, column, unit)
	local cell = map:getCell(row, column)
	cell:setUnit(unit)
end

function M.createMap(mapName,rowCount, colCount)
	return setmetatable({mapName=mapName, rowCount = rowCount, colCount=colCount}, map)
end

M.map = M.createMap('first', 100, 100 )

local u = Unit.createRock()

assert(Unit.hero, "Unit.hero is nil")

M.map:setUnit(4, 4, Unit.hero)


return M