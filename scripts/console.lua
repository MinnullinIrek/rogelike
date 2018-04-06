local M = {}
local consts = {
	mapTbl  = {x = 1, y =1, height = 50, width = 50},
	charTbl = {x = 51, y =1, height = 50, width = 30},
	textTbl = {x = 1, y =51, height = 20, width = 80},
	consoleSize = {x = 100, y = 100}
	

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
	colorBg = nil or color.Black;
	colorFg = nil or color.White;
	conLib.putCh(text, coordX, coordY, colorBg, colorFg);
end



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
end






-- conLib.changeBuffer();


printTables()
conLib.changeBuffer();

local map = require 'map'



return M