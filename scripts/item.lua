local M = {}

local dname = "item: "

local function print(...) oprint(dname, ...) end


local Item = {
	__type = 'item',
	name = '',
	ch   = '',
	
}
Item.__index = Item




----------------------------------------------------------------------

local item = {
	__type = item
}

item.__index = item

local armour = {
	__type = 'armour',
	
	itemTypes = {--[[light = true, medium = nil, heavy = true ]]},
	bodyPartTypes = {--[[ leftShoulder = true, leftArm = true, leftHand = true ]]},
	
}

armour.__index = armour
local weapon = {
	__type = 'weapon',
	itemTypes = {--[[twoHanded, oneHanded,]]},
	
	bodyPartTypes = {--[[ leftHand, leftArm  ]]},
}

weapon.__index = weapon

local itemMTypes = {armour = armour, weapon = weapon, item = item}

function M.createItem(name, ch, __type, itemTypes, bodyPartTypes)
	local item = {name = name, ch = ch or '$', itemTypes = itemTypes, bodyPartTypes = bodyPartTypes, id = nextSerial()}

	return setmetatable(item, itemMTypes[__type])
end



return M