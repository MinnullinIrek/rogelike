local M = {}
local cell = require 'cell'
local Unit = require 'unit'
local level = require 'level'
local Game = require 'game'

local dname = "map: "

local function print(...) oprint(dname, ...) end

trock = Unit.createRock()

print("map")
local map = {
	rowCount = 0,
	colCount = 0,	
	-- cells = {},
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


function loadLevel(i)
	local mp = setmetatable({mapName=mapName, rowCount = rowCount, colCount=colCount, cells = {}}, map)
	local level = level.level[i]
	
	for i, line in ipairs(level.str) do
		local start = 1
		while start <= string.len(line) do
			local ch = string.sub (line, start, start)

			local unit = nil
			if ch ~= ' ' then 
				if ch == '@' then
					mp:setUnit(start, i, Unit.hero)
					Unit.hero:setVisibility(true)
				elseif ch == '#' then
					unit = trock
				else
					local temp = level[ch]			
					if(temp and temp.__type == 'unit') then
						unit = Unit.createUnit(temp.name, ch, temp.__type)
						table.insert(Game.units, unit)
					elseif(temp and temp.__type == 'item') then
						--[[item = Item.createItem()]]
					end
				end
			end
			
			if unit then
				print('mp:setUnit(rock)')
				mp:setUnit( start,i, unit)
			end
			start = start + 1
		end
	end
	return mp
end

function M.createMap(mapName,rowCount, colCount)
	-- return setmetatable({mapName=mapName, rowCount = rowCount, colCount=colCount, cells = {}}, map)
	return loadLevel(1)
end

M.map = M.createMap('first', 100, 100 )

local u = Unit.createRock()

assert(Unit.hero, "Unit.hero is nil")

-- M.map:setUnit(4, 4, Unit.hero)


return M