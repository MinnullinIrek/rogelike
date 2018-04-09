local M = {}
local cell = require 'cell'
local Unit = require 'unit'


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

M.map:setUnit(4, 4, Unit.hero)


return M