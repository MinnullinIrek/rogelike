
local serial = 0
local tname = 'utils'
tnil = {}

function nextSerial()
	serial = serial + 1;
	return serial
end

-- print = function(...)
	-- local str = ''
	-- for i, v in ipairs(table.pack(...)) do
		-- str=str..' '..tostring(v)
	-- end
	-- glLib.print(string.format("%s: %s", _G.tname, str))
-- end

local showDname = "unit: "
oprint = print
-- oprint = function(dname, ...)
	-- if not showDname or dname == showDname then
		-- local str = tostring(dname)
		-- for i, v in ipairs(table.pack(...)) do
			-- str=str..' '..tostring(v)
		-- end
		-- glLib.print(str)
	-- end
-- end

function toStr(self)
	return string.format('%s_%d', self.__type, self.id or 0)
end

function foreach(tbl, f, pairsF)
	pairsF = pairsF or pairs
	for nm, val in pairsF(tbl) do
		f(val, nm)
	end
end
color = 
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

-- local symb = {ch = '@', colorFg = color.White, colorBg = color.Black}
-- local row = { symb + }

G_buffer =
{
	-- [1] = {{ch = '###################################', colorFg = color.White, colorBg = color.Black, col = 1}, {ch = '_________________________', col = 30, colorFg = color.White, colorBg = color.Black,}},
	-- [5] = {{ch = '++++++++++@', colorFg = color.Blue, colorBg = color.Black, col = 1}, {ch = '                 ', colorFg = color.White, colorBg = color.Black, col = 10}, {ch = 'hp = 100',colorFg = color.White, colorBg = color.LightGray, col = 35}},
	
}

function setToBuffer(text,  row, col, colorFg, colorBg)
	G_buffer[row] = G_buffer[row] or {}
	table.insert(G_buffer[row], { ch = text, col = col, colorFg = colorFg, colorBg = colorBg})
end

function clearBuffer()
	G_buffer = {}
end

function getDistance(x1, y1, x2, y2)
	return math.sqrt((x1 - x2)* (x1 - x2) + (y1 - y2)* (y1 - y2))
end

function randomGame(a, b)
	local cn = c or  math.random(1, a+b)
	
	return cn <= a and 1 or 2
end

function randomTbl(tbl)
	local max = 0
	for i, value in ipairs(tbl) do
		max = max + value
	end
	
	local cn = math.random(1, max)
	max = 0
	for i, value in ipairs(tbl) do
		max = max + value
		if cn <= max then
			return i
		end
	end
end


function testRandom()
	
	if randomGame(1, 10, 1) == 1 then
		print("1 ok")
	else
		print("*******************************************ERROR 1*****************************")
	end
	
	if randomGame(10, 100, 20) == 2 then
		print("2 ok")
	else
		print("*******************************************ERROR 2*****************************")
	end
	
	if randomGame(10, 100, 9) == 1 then
		print("3 ok")
	else
		print("*******************************************ERROR 3*****************************")
	end
	
	if randomGame(10, 100, 10) == 1 then
		print("3 ok")
	else
		print("*******************************************ERROR 3*****************************")
	end
	
	if randomGame(10, 100, 90) == 2 then
		print("4 ok")
	else
		print("*******************************************ERROR 4*****************************")
	end
	
	if randomGame(10, 100, 110) == 2 then
		print("5 ok")
	else
		print("*******************************************ERROR 5*****************************")
	end
	
end


