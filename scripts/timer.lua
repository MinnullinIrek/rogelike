local M ={}
local dname = "Timer: "

local function print(...) oprint(dname, ...) end

require 'utils'

M.ms = 0

function M.addTime(ms)
    M.ms = ms
end

function M.getStr()
	local day  = math.modf(ms/(100*60*60*24))
	local hour = math.modf( (ms - day*(100*60*60*24))/(100*60*60))
	local min  = math.modf( (ms - day*(100*60*60*24) - hour*(100*60*60))/(100*60))
	local sec  = math.modf( (ms - day*(100*60*60*24) - hour*(100*60*60) - min*(100*60))/(100))
	
    return string.format('%d:%2d:%2d:%2d:%2d', day, hour, min, sec, ms)
end


return M