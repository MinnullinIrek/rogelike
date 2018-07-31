local M = {}

M.weapon = {
	__type = 'weapon',
	itemTypes = {--[[weapon]]},
	
	bodyPartTypes = {--[[ leftHand, leftArm  ]]},
	__tostring = toStr
}

M.weapon.__index = M.weapon

return M