local M = {}

local dname = "unit: "

local function print(...) oprint(dname, ...) end

local Mover 	= require 'mover'
local Inventory = require 'inventory'
local Item 		= require 'item'
local Body 		= require 'body'
local Chars 	= require 'chars'
local Event     = require 'event'
local text 		= require 'text'
local Log       = require 'logus'
local T			= require 'texts'
local Timer     = require 'timer'
require 'utils'

local rockSymb = '#'


local Unit = 
{
	name 	  = '0',
	ch 		  = '0',
	utype 	  = '0',
	
	-- chars = Chars.createChar('finalChar', {value = {100, 100, }})
	
	-- chars = {
		-- hp     = {name = 'hp    ',100, 100},
		-- cot    = {name = 'cot   ',100, 100},
		-- energy = {name = 'energy',100, 100},	
	-- }
	-- mover
	-- inventory
	die = function(self)
		
		text.putMessage(string.format("%s died!", self.name))
		local x, y = self.mover.coords.x, self.mover.coords.y 
		local cell = self.mover.map:getCell(x, y)
		ai.mobs[self]   = nil
		Log.putMessage(string.format("%d %d!", x, y))
		cell.unit  = nil
		self.mover = nil
		self.chars = nil
		
	end,
}

Unit.__index = Unit

function createUnit(name, ch, utype)
	utype = utype or 'unit'
	local unit = setmetatable({name = name, ch = ch,  __type = utype, chars = Chars.createAllChars()}, Unit)
	
	
	
	local mover = Mover.createMover()
	unit.mover = mover
	mover.unit = unit
	
	
	return unit
end

function M.createRock()
	return createUnit('rock', rockSymb, 'rock' )
end


function createMob(name, ch, utype, color)
	local mob = setmetatable(
			{
				name  = name, 
				ch    = ch, 
				utype = utype, 
				chars = Chars.createAllChars(),
				-- colourFg = color.Red,
				colorFg = color,
				
			},
		Unit)
	
	local temp = {}
	local i = 1
	for name, ch in pairs(mob.chars) do
		temp[i] = name
		i = i + 1
	end
	
	for i, name in ipairs(temp) do
		mob.chars[i] = {name = name, value = mob.chars[name]}
	end
	
	Event.subscribe(mob.chars.finalChar.hp, 'value', 
													function()
														local maxV = mob.chars.finalChar.hp.maxValue
														local val  = mob.chars.finalChar.hp.value
														local level = ''
														if name == 'kobold' then
															Log.putMessage(string.format('kobold hp = %d', val))
														end
														
														if mob.chars.finalChar.hp.value <= 0 then 
															Event.unsubscribe(mob.chars.finalChar.hp, 'value')
															mob:die()
														else
															if val < maxV and val > 0 then
																if val > 0.6 * maxV then
																	level = 'legko'
																elseif val > 0.3 * maxV then
																	level = 'sredne'
																elseif val > 0.2 * maxV then
																	level = 'tyajelo'
																elseif val > 0.1 * maxV then
																	level = 'fatalno'
																end
																text.putMessage(string.format(T.get_damage, mob.name, level))
															elseif val > maxV then
																text.putMessage(string.format(T.ogo, mob.name))
															elseif val < 0 then
																text.putMessage(T.already_dead)
															end
														end
													end )
	return mob
end


function M.createHero()
	local hero = createMob('hero', '@', 'hero', color.LightBlue)
	hero.body = Body.createBody()
	hero.timer = 
		function(time)
			Timer.addTime(time)
		end
		
	return hero
	
end

function M.createEnemy(name, ch, utype)
	local mob = createMob(name, ch, utype, color.LightRed)
	Mover.createMover(mob)
	mob.step = function(self)
		local x, y = self.mover.coords.x, self.mover.coords.y
		local perception = self.chars.baseChar.perception.value
		
			
			local herox, heroy = game.hero.mover.coords.x, game.hero.mover.coords.y
			
			local dist = getDistance(x, y, herox, heroy)
			local newX, newY = 0, 0
			if perception >= dist then
				if x-herox ~= 0 then
					newX = (herox - x)/math.abs(herox - x)
				end
				
				if y-heroy ~= 0 then
					newY = (heroy - y)/math.abs(heroy - y)
				end
				
				self.mover:jumpTo(x + newX, y + newY)			
			end
		
	end
	mob.body = Body.createBody()
	ai.mobs[mob] = true
	mob.timer = function(time)
					
				end
	return mob
end



M.hero 				 	= M.createHero()
Mover.heroMover.unit 	= M.hero
M.hero.mover			= Mover.heroMover
M.hero.inventory 		= Inventory.heroInventory
Inventory.heroInventory = M.hero



local function getRay(x1, y1, x2, y2)
	local ray = {}
	if(math.abs(x2 - x1) <= math.abs(y2 - y1))then
	
		local k = (x2 - x1)/(y2 - y1)
		local b = y2 - k * x2
		
		local d = x1 > x2 and -1 or 1
		
		for x = x1, x2, d do
			local y = k * x + b
			table.insert(ray, {x, y})
		end
	else
		local k = (y2 - y1)/(x2 - x1)
		local b = x2 - k * y2
		
		local d = y1 > y2 and -1 or 1
		
		for y = y1, y2, d do
			local x = k * y + b

			table.insert(ray, {x, y})
		end
	end
	
	return ray
end

local function pushCoord(c, i, coords, perception, v)
	for p = -perception, perception do
		local v2 = v + p
		table.insert(coords, {[i] = c, [i == 1 and 2 or 1] = v2})
	end
end

local function funcVisible(hero,lineCd, visible)
	local x, y = lineCd[1], lineCd[2]
	local cell = hero.mover.map:getCell(x, y)
	local unit = cell.unit
	cell.visible = (cell.visible or 0) + visible
	if unit and unit.__type == 'rock' then
		visible = - 1
		seen = true
	end
end

local function funcNotVisible(hero,lineCd)
	local x, y = lineCd[1], lineCd[2]
	local cell = hero.mover.map:getCell(x, y)
	
	cell.visible = 0
end

local function getLittleSquare(x, y)
	return {{x = x - 1, y = y - 1}, {x = x, y = y - 1}, {x = x+1, y = y-1}, {x= x+1, y = y}, {x= x+1, y = y+1}, {x = x, y = y+1}, {x = x-1, y = y+1}, {x = x-1, y = y}}
end



local function getSquareCoords(x, y, perception, map)
	-- perception = 15
	local square = {[x] = {[y] = 1}}
	local way = {[1]= {{x = x, y = y }}}
	local position = 1
	
	for position = 1, perception do
		table.insert(way, {})
		-- print('position', position)
		local tbl = way[position]
		for i, cd in ipairs(tbl) do
			-- print('      i =', i)
			local cell = map:getCell(cd.x, cd.y)
			
			local unit = cell.unit
			if(not unit or unit.__type ~= 'rock') then
				local littleSquare = getLittleSquare(cd.x, cd.y)
				for j, cdNext in ipairs(littleSquare) do
					-- print('             j =', j, cdNext.x, cdNext.y)
					
					if cdNext.x > 0 and cdNext.y > 0 then
						square[cdNext.x] = square[cdNext.x] or {}
						if not square[cdNext.x][cdNext.y] then
						-- print('                    notSquare =', cdNext.x, cdNext.y)
							square[cdNext.x][cdNext.y] = position + 1
							local dist = getDistance(x, y, cdNext.x, cdNext.y)
							if getDistance(x, y, cdNext.x, cdNext.y) >= position  then
								-- print("getDistance", dist)
								
								table.insert(way[position+1], cdNext)
							end
						end
					end
				end
			end
		end
	end
	
	return way
end

local function getSimpleSquare(x, y, perception)
	local square = {}
	for x1 = x - perception, x + perception do
		if x > 0 then
			for y1 = y - perception, y + perception do
				table.insert(square, {x = x1, y = y1})
			end
		end
	end
	return square
end


function M.hero.setVisibility(self, bool)
	local perception = self.chars.baseChar.perception.value
	assert(perception, 'perception is nil')
	local x = self.mover.coords.x
	local y = self.mover.coords.y
	local visible = bool and 1 or 0
	local map = self.mover.map
	if bool then
		local cell = map:getCell(x, y)
		cell.visible = visible
		
		local way = getSquareCoords(x, y, perception, map, bool)
		for i, coords in ipairs(way) do
			for j , cd in ipairs(coords) do
				local cell = map:getCell(cd.x, cd.y)
				cell.visible = visible
				cell.seen = true
			end
		end
	else
		local square = getSimpleSquare(x, y, perception)
		for i, cd in ipairs(square) do
			local cell = map:getCell(cd.x, cd.y)
			if not cell.unit or cell.unit.__type~= 'rock' then
				cell.visible = visible
			else
				cell.visible = 2
			end
		end
	end
	
end



return M