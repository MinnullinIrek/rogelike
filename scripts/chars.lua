local M = {}

require 'utils'
local Text  = require 'text'
local Event = require 'event'
local dname = "chars: "


local function print(...) oprint(dname, ...) end


local Item = {
	__type = 'item',
	name = '',
	ch   = '',
	
}
Item.__index = Item
local pChar = {}
local Char = {
	__type 			= 'Char',
	-- name 		= '',
	-- value 		= 100,
	-- maxValue 	= 100,
	__tostring 		= toStr,
	__newindex		= function(self,key, value)
						pChar[self][key] = value
						Event.send(self, key)
					  end,
					
	__index         = function(self, key)
						return pChar[self][key]
					  end
					
}

local function createName(name)
	local len = 15
	return string.format('%s%s',name, string.rep(' ', len - string.len(name)) )
end

local function createChar(name, maxValue, value)
	local ch       = setmetatable({}, Char)
    pChar[ch]      = {name = createName(name), maxValue = maxValue or 0, value = value or 0, id = nextSerial(), __type = name}
    return ch
end


local finalChar = {
		__type = 'finalChar',
		-- hp     =  createChar('hp',    100, 100),  --{name = 'hp    ',100, 100},
		-- cot    =  createChar('cot',    100, 100),--{name = 'cot   ',100, 100},
		-- energy =  createChar('energy', 100, 100),--{name = 'energy',100, 100},	
		__tostring = toStr
}
finalChar.__index = finalChar

local itemChar = {
	__type = 'itemChar',
	__tostring = toStr,
	
	-- armour = createChar('armour', 100, 100),
}

itemChar.__index = itemChar

local baseChar = 
{
	__type = 'baseChar',
	__tostring= toStr,
	
	-- perception = 10,
	
}
baseChar.__index = baseChar



local charsInChar = { 
						finalChar = {
							'hp',
							'cot',
							'energy',
							'attack',
							'dodge',
							'accuracy',
						}, 
						itemChar = {
							'armour',
							'damage',
							'hp',
						},
						baseChar = {
							'perception',
							'strength',
							'dexterity',
							'constitution',
							'wisdom',
							'intelligence',
							'charisma'
						},
						skills = {
							'closeCombat',
							'meleeCombat',
							'magikCombat',
							'trained',
						}
					}

function M.createChar(name, tbl)
	-- print('M.createChar', tbl[2])
	local creatingChar = {id = nextSerial()}
	for i, ch in ipairs(charsInChar[name]) do
		local tempCh = createChar(ch, tbl.value[i], tbl.maxValue and tbl.maxValue[i] or tbl.value[i])
		creatingChar[ch] = tempCh
		creatingChar[i] = tempCh
	end
	
	return setmetatable(creatingChar, baseChar )
end

function createLittleChar(name)
	local creatingChar = {id = nextSerial(), __type = name,}
	for i, ch in ipairs(charsInChar[name]) do
		local tempCh = createChar(ch, 0, 0)
		creatingChar[ch] = tempCh
		creatingChar[i] = tempCh
	end
	
	return setmetatable(creatingChar, baseChar )
end

function M.createAllChars()
	local chars = {}
	for name, charType in pairs(charsInChar) do
		chars[name] = createLittleChar(name)
	end
	
	Event.subscribe(chars.baseChar.constitution, 'value', function() chars.finalChar.hp.value = chars.baseChar.constitution.value * 10 end)
	Event.subscribe(chars.baseChar.constitution, 'maxValue', function() chars.finalChar.hp.maxValue = chars.baseChar.constitution.maxValue * 10 end)

	Event.subscribe(chars.baseChar.intelligence, 'value', function() chars.finalChar.cot.value = chars.baseChar.intelligence.value * 10 end)
	Event.subscribe(chars.baseChar.intelligence, 'maxValue', function() chars.finalChar.cot.maxValue = chars.baseChar.intelligence.maxValue * 10 end)

	Event.subscribe(chars.baseChar.constitution, 'value', function() chars.finalChar.energy.value = chars.baseChar.intelligence.value * (1+chars.skills.trained.value/100) end)
	Event.subscribe(chars.baseChar.constitution, 'maxValue', function() chars.finalChar.energy.maxValue = chars.baseChar.intelligence.maxValue * (1 +chars.skills.trained.maxValue/100) end)

	Event.subscribe(chars.baseChar.strength, 	 'value',        function() chars.finalChar.attack.value    = chars.baseChar.strength.value * (1+chars.skills.closeCombat.value/100) end)
	Event.subscribe(chars.baseChar.strength, 	 'maxValue',     function() chars.finalChar.attack.maxValue = chars.baseChar.strength.maxValue * (1 +chars.skills.closeCombat.maxValue/100) end)

	Event.subscribe(chars.baseChar.perception, 	 'value',        function() chars.finalChar.accuracy.value    = chars.baseChar.perception.value * (1+chars.skills.closeCombat.value/100) end)
	Event.subscribe(chars.baseChar.perception, 	 'maxValue',     function() chars.finalChar.accuracy.maxValue = chars.baseChar.perception.maxValue * (1 +chars.skills.closeCombat.maxValue/100) end)
	
	Event.subscribe(chars.baseChar.dexterity, 	 'value',        function() chars.finalChar.dodge.value    = chars.baseChar.dexterity.value * (1+chars.skills.trained.value/100) end)
	Event.subscribe(chars.baseChar.dexterity, 	 'maxValue',     function() chars.finalChar.dodge.maxValue = chars.baseChar.dexterity.maxValue * (1 +chars.skills.trained.maxValue/100) end)
	
	
	chars.baseChar.strength.value         = 10
	chars.baseChar.strength.maxValue      = 10
	chars.baseChar.intelligence.value     = 10
	chars.baseChar.intelligence.maxValue  = 10
	chars.baseChar.perception.value       = 10	
	chars.baseChar.perception.maxValue    = 10
	chars.baseChar.constitution.value     = 10
	chars.baseChar.constitution.maxValue  = 10
	
	chars.baseChar.dexterity.value     	  = 10
	chars.baseChar.dexterity.maxValue     = 10
	
	
	return chars
end


local staticFist = {chars= {damage = {value = 1}}}

function M.attack(attacker, defender)	
	
	if defender.__type ~= 'rock' then
	
		local rh = attacker.body.rightHand.bpart
		local weapon = rh.item.weapon or staticFist
		
		if randomGame(attacker.chars.finalChar.accuracy.value, attacker.chars.finalChar.dodge.value) == 1 then
			
			local bpart = defender.body:chooseRandom()
			
			local items = bpart.bpart.item
			
			local armour = 0
			
			
			local arType = ''
			if 		items.heavy   and items.heavy.chars.armour.value > 0  then
				arType = 'heavy'
			elseif  items.medium  and items.medium.chars.armour.value > 0  then
				arType = 'medium'
			elseif  items.light   and items.light.chars.armour.value > 0  then
				arType = 'light'
			end
			
			if arType ~= '' then
				Text.putMessage(string.format('%s заблокировал', items[arType].name))
				
				items[arType].chars.armour.value = items[arType].chars.armour.value - weapon.chars.damage.value
			else
				Text.putMessage(string.format('попал в %s', bpart.name))
				
				defender.chars.finalChar.hp.value = defender.chars.finalChar.hp.value - weapon.chars.damage.value
			end
		else
			Text.putMessage(string.format('%s увернулся',defender.name))
		end
		
	end
	-- print('defender ', defender.chars.finalChar.hp.value)
	
end




return M