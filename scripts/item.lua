local M = {}

local Item = {
	__type = 'item',
	name = '',
	ch   = '',
	
}
Item.__index = Item

function M.createItem(name, ch)
	return setmetatable({name = name, ch = ch or '$'}, Item)	
end


----------------------------------------------------------------------

local armour = {
	__type = 'armour',
	
	itemTypes = {--[[light = true, medium = nil, heavy = true ]]},
	bodyPartTypes = {--[[ leftShoulder = true, leftArm = true, leftHand = true ]]},
	
}

local weapon = {
	__type = 'weapon',
	itemTypes = {--[[twoHanded, oneHanded,]]},
	
	bodyPartTypes = {--[[ leftHand, leftArm  ]]},
}





return M