
local dname = "console: "

local function print(...) oprint(dname, ...) end


local map  = require 'map'
local Unit = require 'unit'
local Text = require 'text'
local Log  = require 'logus'
local Mover = require 'mover'

function traceTable(t, fpairs)
	fpairs = fpairs or ipairs
	for i, k in fpairs(t) do 
		print(k)
	end
end

local M = {}
local consts = {
	mapTbl  	 = {x = 1,   y =1,   height = 50, width = 50},
	charTbl 	 = {x = 51,  y =1,   height = 50, width = 30},
	textTbl 	 = {x = 1,   y =51,  height = 20, width = 40},
	logTbl  	 = {x = 51,  y = 51, height = 20, width = 40 },
	consoleSize  = {x = 100, y = 100},
	
	inventoryTbl = {x = 2,   y = 2,  height = 50, width = 50},
	bodyTbl 	 = { x = 52, y = 2,  height = 50, width = 40},
	
	

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
		local charText = string.format('%s \t %d/%d', k.name, k.maxValue, k.value)
		
		putCh(charText, consts.charTbl.x +5, consts.charTbl.y + count, color.DarkGray, color.Blue)  --coordX, coordY,
	end
	
	local body = Unit.hero.body
	
	for i, nmbpart in ipairs(body) do
		count = count + 1
		local name, bpart = next(nmbpart)
		name = string.format('%s  %d', name, ((bpart.chars or tnil)['armour'] or tnil)['value'] or 0)
		putCh(name, consts.charTbl.x +5, consts.charTbl.y + count)
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





local function showTable(tbl, fstr, constTbl, pos)
	local height = constTbl.height
	local start = height - pos < 0 and pos - height + 1 or 1
	if pos <= #tbl then
		local j = 1
		for i = start, #tbl do
			local str = fstr(tbl[i], i == pos)
			putCh(str, constTbl.x+1, constTbl.y+j)
			
			if j > constTbl.height - 1 then
				break;
			end
			j = j + 1
		end
	end
end

local function showBody()
	for i, tbl in ipairs(Unit.hero.body) do
		local nm, bpart = next(tbl)
		local __type = bpart.__type
		local wearing = bpart.item
		
		print("type "..__type)


		local str = nm
		if wearing then
			for tp, it in pairs(wearing) do
				print("tp, it", tp, it)
				if type(it) == 'table' then
					str = str .." "..it.name
				end
			end
		end
		
		putCh(str, consts.bodyTbl.x+3, consts.bodyTbl.y + i)
	end
end

function showBag(pos)
	local selectedItem = nil
	drawTable(consts.inventoryTbl)
	drawTable(consts.bodyTbl)
	showTable(Unit.hero.inventory.bag, function(item, b) if b then selectedItem = item end return string.format("[%s] %s  %s", b and '*' or ' ', item.ch, item.name) end, consts.inventoryTbl, pos )
	showBody()
	printText(Log, 'logTbl')
	conLib.changeBuffer();
	return selectedItem
end


update()

local bag = nil
function M.changeRejim(i)
	if     i == 'map' then		
		M.Activer = mapDirection
	elseif i == 'bag' then
		print('rejim bag')
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
		-- Log.putMessage("iiiiiiiiiiiiiiiiiiii")
		self.selectedItem = showBag(self.start)
	end,
	
	dirHandle = function(self, dir)
		if dir == 'up' and self.start > 1 then
			self.start = self.start - 1
		elseif dir == 'down' then
			self.start = self.start + 1
		elseif dir == 'enter' then
			Log.putMessage('enter')
			Unit.hero.body:wear(self.selectedItem)
		end
	end
}

M.Activer = mapDirection


return M