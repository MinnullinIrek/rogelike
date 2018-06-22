
local dname = "console: "

local function print(...) oprint(dname, ...) end

require 'utils'
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



-- conLib.printBuffer(G_buffer)

local coord = {
x = 0,
y = 0
}



local function putCh(text, coordX, coordY, colorBg, colorFg)
	text = text or ''
	colorBg = colorBg or color.Black;
	colorFg = colorFg or color.White;
    conLib.putCh(text, coordX, coordY, colorBg, colorFg);
	--setToBuffer(text,  coordY, coordX, colorFg, colorBg)
end

local function changeBuffer()
	-- conLib.printBuffer(G_buffer)
	conLib.changeBuffer()
end


local function putTbl(tbl, coordX, coordY)
	putCh(tbl.text, coordX, coordY, tbl.colorBg, tbl.colorFg);
end

putCh("хвв\nапп", 1, 1, color.Yellow, color.DarkGray)
changeBuffer();

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




-- changeBuffer();


printTables()

function printCell(cell, x, y)
	local ch = cell:getChar()
	putTbl(ch, x, y)
	
end

function printMap(mp)
	local xStart = Unit.hero.mover.coords.x - consts.mapTbl.width /2
	local yStart = Unit.hero.mover.coords.y - consts.mapTbl.height /2
	xStart = xStart > 0 and xStart or 1
	yStart = yStart > 0 and yStart or 1
	for i = 1, consts.mapTbl.width do
		for j = 1, consts.mapTbl.height do
			local cell = mp:getCell(xStart + i - 1, yStart + j -1)
			printCell(cell, i, j)
		end
	end
end

local function cicleBody(body, func)
	for i, tbl in ipairs(Unit.hero.body) do
		local nm, bpart = next(tbl)
		local __type = bpart.__type
		local wearing = bpart.item
		
		print("type "..__type)
		func(wearing,nm, i)
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
	chars = chars.finalChar
	
	for i, k in ipairs(chars) do
		count = count + 1;
		if(type(k) == 'table') then
			local charText = string.format('%s \t %d/%d', k.name, k.value, k.maxValue)
			
			putCh(charText, consts.charTbl.x +5, consts.charTbl.y + count, color.DarkGray, color.Blue)  --coordX, coordY,
		end
	end
	
	local body = Unit.hero.body
	
	cicleBody(Unit.hero.body,  
		function(wearing, str, i)
			if wearing then
				for tp, it in pairs(wearing) do
					if type(it) == 'table' then
						str = str .." "..it.chars.armour.value
					end
				end
			end
			putCh(str, consts.bodyTbl.x+3, consts.bodyTbl.y + i + count)
			
		end
	)
end

function printText(tbl, key)
	-- if oprint then
		-- oprint(tbl,key)
	-- end
	local t = tbl.messages
	-- traceTable(t)
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


local function showTable(tbl, fstr, constTbl, pos)
	assert(tbl, 'bag is nil')
	local height = constTbl.height
	local start = height - pos < 0 and pos - height + 1 or 1
	if pos <= #tbl then
		local j = 1
		for i = start, #tbl do
			local str = fstr(tbl[i], i == pos)
			assert(type(str) == 'table')
			putTbl(str, constTbl.x+1, constTbl.y+j)
			
			if j > constTbl.height - 1 then
				break;
			end
			j = j + 1
		end
	end
end

local function showBodyItemIterator(wearing, str, i)
	if wearing then
		for tp, it in pairs(wearing) do
			if type(it) == 'table' then
				str = str .." "..it.name
			end
		end
	end
	putCh(str, consts.bodyTbl.x+3, consts.bodyTbl.y + i)
	
end

local function showBody()
	cicleBody(Unit.hero.body, showBodyItemIterator)
end


local function showBag(pos,bag)
	assert(bag, 'bag is nil')
	local selectedItem = nil
	drawTable(consts.inventoryTbl)
	drawTable(consts.bodyTbl)
	showTable(bag, 
		function(item, b) 
			if b then 
				selectedItem = item 
				end 
			return {text = string.format("[%s] %s  %s", b and '*' or ' ', item.ch, item.name), colorFg = item.isWeared and color.LightGray  or color.White}
		end,
		consts.inventoryTbl, pos )
	showBody()
	printText(Log, 'logTbl')
	changeBuffer();
	return selectedItem
end


local bag = nil


function showCellItems(pos)
	local selectedItem = nil
	drawTable(consts.inventoryTbl)
	drawTable(consts.bodyTbl)
	local x, y = Unit.hero.mover.coords.x, Unit.hero.mover.coords.y
	local bag = map.map:getCell(x, y).bag or tnil
	showTable(bag, function(item, b) if b then selectedItem = item end return string.format("[%s] %s  %s", b and '*' or ' ', item.ch, item.name) end, consts.inventoryTbl, pos )
	showBody()
	printText(Log, 'logTbl')
	changeBuffer();
	return selectedItem
end


mapDirection = 
{
	start = 1,
	update = function(self)
		printTables()
		printMap(map.map);
		printHero()
		printText(Text, 'textTbl')
		printText(Log, 'logTbl')

		changeBuffer();
	end,
	
	dirHandle = function(self, dir)
		if dir == 'p' then
			showCellItems(self.start)
		else
			Mover.setDir(dir)
		end
	end
}

mapDirection.update()
inventoryDirection = 
{
	start = 1,
	dir = 'i',
	
	getCellBag = function()
		local x, y = Unit.hero.mover.coords.x, Unit.hero.mover.coords.y
		if not map.map:getCell(x, y).bag then
			map.map:getCell(x, y).bag = {}
		end
		return map.map:getCell(x, y).bag
	end,
	
	getHeroBag = function()
		return Unit.hero.inventory.bag
	end,
	
	update = function(self)
		-- Log.putMessage("iiiiiiiiiiiiiiiiiiii")
		local bag = nil
		assert(self.dir, 'dir is nil')
		
		print(self.dir, 'setDir*****************')
		if self.dir == 'i' then
			bag = self:getHeroBag()
		elseif self.dir == 'p' then
			bag = self:getCellBag()		
		end
		assert(bag, 'bag is nil')
		self.selectedItem = showBag(self.start, bag)
	end,
	
	dirHandle = function(self, dir)
		
		if dir == 'up' and self.start > 1 then
			self.start = self.start - 1
		elseif dir == 'down' then
			self.start = self.start + 1
		elseif dir == 'enter' then
			Log.putMessage('enter')
			if self.dir == 'i' then
				Unit.hero.body:wear(self.selectedItem)
			elseif self.dir == 'p' then
				local bag = self:getCellBag()
				local item = table.remove(bag,start)
				table.insert(self:getHeroBag(), item)
			end
		elseif dir == 'd' and self.dir == 'i' then
			Log.putMessage("dirHandle ".. dir)
			Log.putMessage("dirHandle 'd'")
			local cellBag = self:getCellBag()
			local heroBag = self:getHeroBag()
			Unit.hero.body:unWear(self.selectedItem)
			table.insert(cellBag, table.remove(heroBag, self.start ))
			
		end
	end
}

local chardirection = 
{
	start = 1,
	dir = 'i',
	
	update = function(self)
		local x = 3
		for i, charValue in ipairs(Unit.hero.chars) do
			local j = 3
			putCh(charValue.name, x, 1)
			for i, value in ipairs(charValue.value) do
				if type(value) == 'table' then
					putCh(string.format('%s    %2d/%2d', value.name, value.value or 0, value.maxValue or 0), x, i + j)
				end
			end
			x = x + 30
		end
		
		changeBuffer()
	end,
	
	dirHandle = function(self, dir)
		
		
	end
}

M.Activer = mapDirection

local directions = {
	map   = mapDirection,
	bag   = inventoryDirection,
	chars = chardirection,
	
}

function M.changeRejim(i, dir)
	M.Activer = directions[i]
	M.Activer.dir = dir
	M.Activer.start = 1
end

function M.mainScreen(i)
	conLib.getFirsConsole(i)
end

return M