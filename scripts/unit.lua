local M = {}



local rockSymb = '#'


local Unit = 
{
	name 	  = '0',
	ch 		  = '0',
	utype 	  = '0',
	
	chars = {
		hp     = {name = 'hp    ',100, 100},
		cot    = {name = 'cot   ',100, 100},
		energy = {name = 'energy',100, 100},	
	}
}

Unit.__index = Unit

function M.createUnit(name, ch, utype)
	return setmetatable({name = name, ch = ch, utype = utype}, Unit)	
end

function M.createRock()
	return M.createUnit('rock', rockSymb )
end

function M.createHero()
	return setmetatable({name = 'hero', ch = '@', utype = 'hero'}, Unit)
	
end

M.hero = M.createHero()

return M