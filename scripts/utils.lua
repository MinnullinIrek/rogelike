
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