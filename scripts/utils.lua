
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

oprint = function(...)
	local str = ''
	for i, v in ipairs(table.pack(...)) do
		str=str..' '..tostring(v)
	end
	glLib.print(str)
end

function toStr(self)
	return string.format('%s_%d', self.__type, self.id or 0)
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