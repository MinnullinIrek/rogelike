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

local function createName(name)
	local len = 15
	return string.format('%s%s',name, string.rep(' ', len - string.len(name)) )
end

local function createChar(name, maxValue, value)
	return setmetatable({name = createName(name), maxValue = maxValue, value = value, id = nextSerial(), __type = name}, Char)
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

local secondChar = 
{
	__type = 'secondChar',
	__tostring= toStr,
	
	-- perception = 10,
	
}
secondChar.__index = secondChar


local chars = {mainChar = mainChar, itemChar = itemChar, secondChar = secondChar}
local charsInChar = { mainChar = {'hp', 'cot', 'energy'}, itemChar = {'armour'}, secondChar = {'perception', 'strength', 'dexterity', 'constitution', 'wisdom', 'intelligence'} }

function M.createChar(name, tbl)
	assert(chars[name], string.format('no charType %s',name))
	local creatingChar = {id = nextSerial()}
	for i, ch in ipairs(charsInChar[name]) do
		local tempCh = createChar(ch, tbl.value[i], tbl.maxValue and tbl.maxValue[i] or tbl.value[i])
		creatingChar[ch] = tempCh
		creatingChar[i] = tempCh
	end	
	
	return setmetatable(creatingChar, chars[name] )
end

function M.attack(attacker, defender)
	
	
	
	
	
end




return M