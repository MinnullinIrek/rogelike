local M ={}

local Timer = require 'timer'

local Timer.setQueue(M)

-- M.actions = {time = function() end}

M.actions = {}

local function comp(timeAct1, timeAct2)
	return timeAct1.time < timeAct2.time
end

function M.addAction(time, action)
	table.insert(M.actions, {time = time, action = action})
	table.sort(M.actions, comp)
end

function M.activate()
	while M.actions[1].time < Timer.ms do
		M.actions[1].action()
		table.remove(M.actions, 1)
	end	
end



return M