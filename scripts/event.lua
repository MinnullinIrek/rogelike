local M ={}
local dname = "event: "

local function print(...) oprint(dname, ...) end

require 'utils'

function M.subscribe(obj, event, func)
    if not M[obj]        then M[obj] = {} end
    if not M[obj][event] then M[obj][event] = {} end
    table.insert(M[obj][event], func)
end

function M.send(obj, event)
    foreach(((M[obj] or tnil)[event] or tnil), function(f) f() end)
end


return M