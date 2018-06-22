local M = {}

local dname = "unit: "

local function print(...) oprint(dname, ...) end

M.mobs = {}

function M.step()
	for mob, key in pairs(M.mobs) do
		mob:step()
	end
end




return M