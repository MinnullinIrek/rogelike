local M = {}



print("map")
local map = {
	rowCount = 0,
	colCount = 0,	
	cells = {}
}

function M.setUnit(map, row, column, unit)
	cells[row] = cells[row] or {}
	cells[row][column] = unit
end

function M.createMap(mapName,rowCount, colCount)
	return setmetatable({mapName=mapName, rowCount = rowCount, colCount=colCount}, map)
	
end

return M