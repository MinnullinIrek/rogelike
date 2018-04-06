local M = {}

local rockSymb = '#'


local Unit = 
{
	name = '0',
	ch = '0',
	utype = '0',
	
	
	
}

function M.createUnit(name, ch, utype)
	return setmetatable({name = name, ch = ch, utype = utype}, Unit)	
end

function M.createRock()
	return M.createUnit('rock', rockSymb )
	
end



return M