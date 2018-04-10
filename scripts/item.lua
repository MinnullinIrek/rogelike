local M = {}

local Item = {
	name = '',
	ch   = ''
	
}
Item.__index = Item

function M.createItem(name, ch)
	return setmetatable({name = name, ch = ch or '$'}, Item)	
end

return M