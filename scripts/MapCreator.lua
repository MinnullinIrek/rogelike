local M = {}

local Map = require 'map'
require 'utils'
local Unit = require 'Unit'
local Game = require 'game'

trock = Unit.createRock()

function M.createMap(sizeX, sizeY)
	local mp = Map.createEmptyMap(rowCount, colCount)
	
	for i = 1, sizeX do
		for j = 1, sizeY do
			local result = randomGame2(100,20, 1)
			if result == 2 then
				mp:setUnit( i, j, trock)
			elseif result == 3 then
				local unit = Unit.createEnemy('name', 'E', 'unit')
				table.insert(Game.units, unit)
				mp:setUnit( i, j, unit)
			end
		
		end
	end	
	mp:setUnit(1, 1, Unit.hero)
	return mp
end

Map.map = M.createMap( 100, 100 )
assert(Map.map , "no map")

return M