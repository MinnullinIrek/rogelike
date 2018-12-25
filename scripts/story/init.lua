require 'utils'
local dname = "item: "
local Event = require 'event'
local Unit = require 'unit'

M.start = require "story/start"



local function print(...) oprint(dname, ...) end

-- local Choise = {
	-- text = '',
	-- activator = function() end
-- }

-- local Question = {
	-- text = ''
	-- choises = {
		-- (Choise ){ text = '' , activator = function() end},
		-- (Choise ){ text = '' , activator = function() end},
	-- }
-- }

	M.startQuestion = {
		text = 'выберите пол',
		choises = {
			{text = 'М', activator = function() Unit.hero.sex = 'male' end},
			{text = 'Ж', activator = function() Unit.hero.sex = 'female' end},
			{text = 'С', activator = function() Unit.hero.sex = 'none' end},
		}
	}

return M
