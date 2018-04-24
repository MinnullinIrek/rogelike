local M = {}

local dname = "unit: "

local function print(...) oprint(dname, ...) end

local Mover 	= require 'mover'
local Inventory = require 'inventory'
local Item 		= require 'item'
local Body 		= require 'body'
local Chars 	= require 'chars'


local rockSymb = '#'


local Unit = 
{
	name 	  = '0',
	ch 		  = '0',
	utype 	  = '0',
	
	-- chars = Chars.createChar('mainChar', {value = {100, 100, }})
	
	-- chars = {
		-- hp     = {name = 'hp    ',100, 100},
		-- cot    = {name = 'cot   ',100, 100},
		-- energy = {name = 'energy',100, 100},	
	-- }
	-- mover
	-- inventory
}

Unit.__index = Unit

function M.createUnit(name, ch, utype)
	utype = utype or 'unit'
	return setmetatable({name = name, ch = ch,  __type = utype}, Unit)	
end

function M.createRock()
	return M.createUnit('rock', rockSymb, 'rock' )
end

function M.createHero()
	local hero = setmetatable(
			{
				name = 'hero', 
				ch = '@', 
				utype = 'hero', 
				chars = {
							mainChar 	= Chars.createChar('mainChar', {value = {100, 100, 100}}),
							secondChar 	= Chars.createChar('secondChar', {value = {10}}),
							
				}
			},
		Unit)

	return hero
	
end



M.hero 				 	= M.createHero()
Mover.heroMover.unit 	= M.hero
M.hero.mover			= Mover.heroMover
M.hero.inventory 		= Inventory.heroInventory
Inventory.heroInventory = M.hero

M.hero.body = Body.createBody()

function M.hero.setVisibility(self)
	local perception = self.chars.secondChar.perception.value
	assert(perception, 'perception is nil')
	local x = self.mover.coords.x
	local y = self.mover.coords.y
	
	
	for i in 0, perception do
		local x0, y0 = 0, 0
		
		
		
	end
end


return M