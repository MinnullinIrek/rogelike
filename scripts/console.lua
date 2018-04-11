
local map  = require 'map'
local Unit = require 'unit'
local Text = require 'text'
local Log  = require 'logus'
local Mover = require 'mover'

function traceTable(t)
	for i, k in ipairs(t) do 
		print(k)
	end
end

local M = {}
local consts = {
	mapTbl  = {x = 1, y =1, height = 50, width = 50},
	charTbl = {x = 51, y =1, height = 50, width = 30},
	textTbl = {x = 1, y =51, height = 20, width = 40},
	logTbl  = {x = 51, y = 51, height = 20, width = 40 },
	consoleSize = {x = 100, y = 100},
	
	inventoryTbl = {x = 2, y = 2, height = 50, width = 50}
	
	

}



local color = 
{
    Black = 0,
    Blue = 1,
    Green = 2,
    Cyan = 3,
    Red = 4,
    Magenta = 5,
    Brown = 6,
    LightGray = 7,
    DarkGray = 8,
    LightBlue = 9,
    LightGreen = 10,
    LightCyan = 11,
    LightRed = 12,
    LightMagenta = 13,
    Yellow = 14,
    White = 15
};

local coord = {
x = 0,
y = 0
}



local function putCh(text, coordX, coordY, colorBg, colorFg)
	colorBg = colorBg or color.Black;
	colorFg = colorFg or color.White;
	conLib.putCh(text, coordX, coordY, colorBg, colorFg);
end

putCh("хввапп", 1, 1, color.Yellow, color.DarkGray)
conLib.changeBuffer();

function drawTable(tblDir)
	local coord = {x = 0, y = 0}
	
	for y = tblDir.y, tblDir.height + tblDir.y, 1 do
		putCh('|', tblDir.x, y)
		putCh('|', tblDir.x+tblDir.width, y)
	end
	
	for x = tblDir.x, tblDir.width + tblDir.x, 1 do
		putCh('_', x, tblDir.y)
		putCh('_', x, tblDir.y + tblDir.height)
	end
end

function printTables()
	drawTable(consts.mapTbl)
	drawTable(consts.charTbl)
	drawTable(consts.textTbl)
	drawTable(consts.logTbl)
end






-- conLib.changeBuffer();


printTables()

function printCell(cell, x, y)
	local ch = cell:getChar()
	putCh(ch, x, y)
	
end

function printMap(mp)
	for i = 1, consts.mapTbl.width do
		for j = 1, consts.mapTbl.height do
			local cell = mp:getCell(i, j)
			printCell(cell, i, j)
		end
	end
end

function printHero()
	-- chars = {
		-- hp     = {100, 100},
		-- cot    = {100, 100},
		-- energy = {100, 100},	
	-- }
	local chars = Unit.hero.chars
	
	local count = 0
	for i, k in pairs(chars) do
		count = count + 1;
		local charText = string.format('%s \t %d/%d', k.name, k[1], k[2])
		
		putCh(charText, consts.charTbl.x +5, consts.charTbl.y + count, color.DarkGray, color.Blue)  --coordX, coordY,
	end
end

function printText(tbl, key)
	if oprint then
	oprint(tbl,key)
	end
	local t = tbl.messages
	traceTable(t)
	count = 0
	
	for i = #t, 1, -1 do
		count = count + 1
		putCh(t[i], consts[key].x + 2, consts[key].y + count)

		if count + 1 >= consts[key].height then
			break
		end
	end
end




function M.getCh()
	local ch = conLib.getch()
	if ch == 224 or ch == 0 then
		ch = conLib.getch()
	end
	
	return ch
end


print('map.map', map.map)
print('map.map.getCell', map.map.getCell)
function update()
	printTables()
	printMap(map.map);
	printHero()
	printText(Text, 'textTbl')
	printText(Log, 'logTbl')

	conLib.changeBuffer();
end



oprint = print

function showTable(tbl, fstr, constTbl, start)
	if start <= #tbl then
	local j = 1
		for i = start, #tbl do
			local str = fstr(tbl[i])
			putCh(str, constTbl.x+1, constTbl.y+j)
			
			if j > constTbl.height - 1 then
				break;
			end
			j = j+1
		end
	end
end

function showBag(start)
	drawTable(consts.inventoryTbl)
	showTable(Unit.hero.inventory.bag, function(item) return string.format("%s  %s", item.ch, item.name) end, consts.inventoryTbl, start )
	printText(Log, 'logTbl')
	conLib.changeBuffer();
end


update()

local bag = nil
function M.changeRejim(i)
	
	if     i == 'map' then
		M.Activer = mapDirection
	elseif i == 'bag' then
		M.Activer = inventoryDirection
	end
end



mapDirection = 
{
	update = function(self)
		printTables()
		printMap(map.map);
		printHero()
		printText(Text, 'textTbl')
		printText(Log, 'logTbl')

		conLib.changeBuffer();
	end,
	
	dirHandle = function(self, dir)
		Mover.setDir(dir)
	end
}

inventoryDirection = 
{
	start = 1,
	update = function(self)
		showBag(self.start)
	end,
	
	dirHandle = function(self, dir)
		if dir == 'up' and self.start > 1 then
			self.start = self.start - 1
		elseif dir == 'down' then
			self.start = self.start + 1
		end
	end
}

M.Activer = mapDirection


return M