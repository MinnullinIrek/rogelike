local M = {}

require 'utils'

local dname = "item: "

local function print(...) oprint(dname, ...) end


local Item = {
	__type = 'item',
	name = '',
	ch   = '',
	
}
Item.__index = Item

local Char = {
	__type 			= 'Char',
	-- name 		= '',
	-- value 		= 100,
	-- maxValue 	= 100,
	__tostring 		= toStr,
}
Char.__index = Char

function createChar(name, maxValue, value)
	return setmetatable({name = name, maxValue = maxValue, value = value, id = nextSerial()}, Char)
end


local mainChar = {
		__type = 'mainChar',
		-- hp     =  createChar('hp',    100, 100),  --{name = 'hp    ',100, 100},
		-- cot    =  createChar('cot',    100, 100),--{name = 'cot   ',100, 100},
		-- energy =  createChar('energy', 100, 100),--{name = 'energy',100, 100},	
		__tostring = toStr
}
mainChar.__index = mainChar

local itemChar = {
	__type = 'itemChar',
	__tostring = toStr,
	
	-- armour = createChar('armour', 100, 100),
}

itemChar.__index = itemChar

local chars = {mainChar = mainChar, itemChar = itemChar,}
local charsInChar = { mainChar = {'hp', 'cot', 'energy'}, itemChar = {'armour'} }

function M.createChar(name)
	assert(chars[name], string.format('no charType %s',name))
	local creatingChar = {id = nextSerial()}
	for i, ch in ipairs(charsInChar[name]) do
		creatingChar[ch] = createChar(ch, 100, 100)
	end	
	
	return setmetatable(creatingChar, chars[name] )
end






return M