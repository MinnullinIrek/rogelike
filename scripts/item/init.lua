local M = {}
require 'utils'
local dname = "item: "
local Event = require 'event'

M.armour = require "item/armour"
M.weapon = require "item/weapon"


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




local armour = M.armour.armour
local weapon = M.weapon.weapon

local itemMTypes = {armour = armour, weapon = weapon, item = item}

function M.createItem(name, ch, __type, itemTypes, bodyPartTypes, chars, description)
	local item = setmetatable({name = name, ch = ch or '$', itemTypes = itemTypes, bodyPartTypes = bodyPartTypes, id = nextSerial(), chars = chars, description = description}, itemMTypes[__type])
	
	local chars = item.chars
	
	Event.subscribe(chars.hp, 'value',       function()
												for i, str in ipairs({'armour', 'damage'}) do
													chars[str].value = chars[str].value * (chars.hp.value/chars.hp.maxValue) 
												end
											end)
	
	
	return item
end



return M