local M = {}
require 'utils'
local dname = "item: "


local function print(...) oprint(dname, ...) end

local Char = require 'chars'



local Item = {
	__type = 'item',
	name = '',
	ch   = '',
	__tostring = toStr
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
	__tostring = toStr
}

armour.__index = armour
local weapon = {
	__type = 'weapon',
	itemTypes = {--[[weapon]]},
	
	bodyPartTypes = {--[[ leftHand, leftArm  ]]},
	__tostring = toStr
}

weapon.__index = weapon

local itemMTypes = {armour = armour, weapon = weapon, item = item}

function M.createItem(name, ch, __type, itemTypes, bodyPartTypes, chars)
	local item = {name = name, ch = ch or '$', itemTypes = itemTypes, bodyPartTypes = bodyPartTypes, id = nextSerial(), chars = chars}

	return setmetatable(item, itemMTypes[__type])
end



return M