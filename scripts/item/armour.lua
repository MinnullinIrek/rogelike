local M = {}


require 'utils'
local dname = "item: "

local function print(...) oprint(dname, ...) end

local Char = require 'chars'

M.armourTypes = { 'heavy', 'medium', 'light'}

M.armour = {
	__type = 'armour',
	
	itemTypes = {--[[light = true, medium = nil, heavy = true ]]},
	bodyPartTypes = {--[[ leftShoulder = true, leftArm = true, leftHand = true ]]},
	__tostring = toStr
}

M.armour.__index = M.armour



return M