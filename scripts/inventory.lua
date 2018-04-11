local M = {}

local item = require 'item'

local Inventory = {
	-- unit
	bag = {
	-- items
	},

	putItem = function(self, item)
		assert(item, 'item is nil')
		table.insert(self.bag, item)
	end,
}




Inventory.__index = Inventory

M.heroInventory = setmetatable({bag = {}}, Inventory)



return M