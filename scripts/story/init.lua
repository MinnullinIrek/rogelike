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
	Unit.hero.past = {}
	M.startQuestions = {
		{
			text = 'выберите пол',
			choises = {
				{text = 'М', activator = function() Unit.hero.past.sex = 'male' end},
				{text = 'Ж', activator = function() Unit.hero.past.sex = 'female' end},
				{text = 'С', activator = function() Unit.hero.past.sex = 'none' end},
			}
		},
		{
			text = 'выберите происхождение',
			choises = {
				{text = 'отпрыск магистра. все дороги открыты, карьера магистра обеспечена', activator = function() end },
				{text = 'королевский бастард. много папиного золота. профессиональное обучение.', activator = function() end },
				{text = 'дворянин.', activator = function() end },
				{text = '', activator = function() end },
				{text = '', activator = function() end },
				{text = '', activator = function() end },
				{text = '', activator = function() end },
				{text = '', activator = function() end },
				{text = '', activator = function() end },
				{text = '', activator = function() end },
				{text = '', activator = function() end },
				
				
				
			}
		}
	}

return M
