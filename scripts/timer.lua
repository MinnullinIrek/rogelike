local M ={}

M.Queue = nil

local dname = "Timer: "
local function print(...) oprint(dname, ...) end

require 'utils'

M.ms = 0

function M.addTime(ms)
    M.ms = M.ms + ms
	M.Queue.activate()
end

function M.setQueue(queue)
	M.Queue = queue	
end

function M.getStr()
	local day  = math.modf(M.ms/(100*60*60*24))
	local hour = math.modf( (M.ms - day*(100*60*60*24))/(100*60*60))
	local min  = math.modf( (M.ms - day*(100*60*60*24) - hour*(100*60*60))/(100*60))
	local sec  = math.modf( (M.ms - day*(100*60*60*24) - hour*(100*60*60) - min*(100*60))/(100))
	
    -- return string.format('%d day:%2d hour:%2d min:%2d sec:%2d ms', day, hour, min, sec, M.ms)
	return string.format('%d: %2d:%2d : %2d:%2d', math.floor(day), math.floor(hour), math.floor(min), math.floor(sec), math.floor(M.ms))
end


return M