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

	local Question = 
	{
		ifFunc = function()
			return true;
		end
	}
	Question. __index = Question
	
	local femaleQuestion = {
		{
			text = {"В одном из учебных дней внезапно старший рыцарь наставник Гаспар заметил вашу увеличившуюся грудь.",
					"Обучение было предуссмотрено только для мужчин.",
					"Обнародывание этого факта вызовет невиданный ранее скандал и исключение, а может и казнь.",
					"   - Так так юная леди, не знаю как это не всплыло до сих пор, но дальше нас дурачить не получится.",
					"   -Ну, что скажете в своё оправдание?"
					},
			choises = {
				{text = '', activator = function()  end},
				{text = '', activator = function()  end},
				{text = '', activator = function()  end},
				{text = '', activator = function()  end},
				{text = '', activator = function()  end},
				{text = '', activator = function()  end},
			}
		},
	}
	
	
	M.startQuestions = {
		setmetatable({
			text = {'выберите пол'},
			choises = {
				{text = 'М', activator = function() Unit.hero.past.sex = 'male' end},
				{text = 'Ж', activator = 
										function() 
											Unit.hero.past.sex = 'female'
											
										end},
				{text = 'С', activator = function() Unit.hero.past.sex = 'none' end},
			}
		}, Question),
		setmetatable({
			text = {'выберите происхождение'},
			choises = {
				{text = 'отпрыск магистра. все дороги открыты, карьера магистра обеспечена', activator = function() Unit.hero.past.parent = 'magistr' end },
				{text = 'королевский бастард. много папиного золота. профессиональное обучение.', activator = function() Unit.hero.past.parent = 'king' end },
				{text = 'отпрыск дворян. неплохое образование. немного связей.', activator = function() Unit.hero.past.parent = 'noble' end },
				{text = 'отпрыск торговца. Много денег, но нет уважения', activator = function() Unit.hero.past.parent = 'trader' end },
				{text = 'отпрыск солдата. Военная тренировка. Пробились благодаря случаю.', activator = function() Unit.hero.past.parent = 'soldier' end },
				{text = 'отпрыск крестьянина. Никто не понимает как вы сюда пробрались. Никто не уважает. Денег нет.', activator = function() Unit.hero.past.parent = 'peasent' end },
				{text = 'отпрыск обозной проститутки. Говорят ваша мать соблазнила магистра, чтоб запихнуть вас.', activator = function() Unit.hero.past.parent = 'bitch' end },
				{text = 'отпрыск уборщика.', activator = function() Unit.hero.past.parent = 'cleaner' end },
				{text = 'отпрыск разбойника. отец отправил вас разнюхать их тайны.', activator = function() Unit.hero.past.parent = 'bandit' end },				
			},			
		}, Question),
		setmetatable({
			text = {"выберите уровень интеллекта"},
			choises = {
				{text = 'да винчи. ни  одна загадка мироздания от вас не ускользнёт', activator = function()  end},
				{text = 'гений. вы настолько умны, что никто вас не понимает.', activator = function() end},
				{text = 'умник. вы весьма умны и это всех бесит.', activator = function() end},
				{text = 'сообразительный. если как следует подумаете можете решить любую задачу.', activator = function() end},
				{text = 'посредственность. вы не выделяетесь из толпы.', activator = function() end},
				{text = 'тугодум. не всем дано быть гениями.', activator = function() end},
				{text = 'эмбицил. вас слишком часто били по башке.', activator = function() end},
			}
		}, Question),
		setmetatable({
			text = {"насколько вы сильны"},
			choises = {
				{text = 'геракл. похоже ваша мать общалась с штормовым гигантом.', activator = function()  end},
				{text = 'силач. вы довольно сильны', activator = function() end},
				{text = 'крепкий. на руках вы можете побить каждого кроме магистра', activator = function() end},
				{text = 'средний.', activator = function() end},
				{text = 'хилый. над вами в школе много издевались', activator = function() end},
				{text = 'слабак. не носите тяжести', activator = function() end},
				{text = 'дистрофик. вам надо лечиться', activator = function() end},
			}
		}, Question),
		setmetatable({
			text = {"насколько вы ловки"},
			choises = {
				{text = 'змей.', activator = function()  end},
				{text = 'акробат', activator = function() end},
				{text = 'шулер', activator = function() end},
				{text = 'средний.', activator = function() end},
				{text = 'неуклюжий. ничего страшного если ты сильный', activator = function() end},
				{text = 'перелом. в детстве вы упали с лестницы, на быка', activator = function() end},
				{text = 'дерево. у вас страшная болезнь артрит', activator = function() end},
			}
		}, Question),
		
		setmetatable({
			text = {"насколько вы обаятельны"},
			choises = {
				{text = 'слаанеш. люди плачут от восхищения когда видят вас', activator = function() Unit.hero.chars.baseChar.charisma = 20 end},
				{text = 'звезда. при вашем виде у людей захватывает дух', activator = function() Unit.hero.chars.baseChar.charisma = 15 end},
				{text = 'красавчик.', activator = function() Unit.hero.chars.baseChar.charisma = 12 end},
				{text = 'косноязычный. не всем дано вести за собой', activator = function() Unit.hero.chars.baseChar.charisma = 10 end},
				{text = 'прыщавый. у вас отталкивающая внешность', activator = function() Unit.hero.chars.baseChar.charisma = 7 end},
				{text = 'вонючка. никто не может терпеть вас долго', activator = function() Unit.hero.chars.baseChar.charisma = 3 end},
				{text = 'носферату. при вашем виде людей выворачивает', activator = function() Unit.hero.chars.baseChar.charisma = 1 end},
			}
		}, Question),
		setmetatable({
			text = {"как у вас со зрением"},
			choises = {
				{text = 'ястреб. вы видите звёзды днём. слышите сердцебиение мышей за стенкой.', activator = function()  end},
				{text = 'холмс. вы замечаете вещи, о которых другие и не задумываюся ', activator = function() end},
				{text = 'вильгельм тетч. вы подстрелите монетку со 100 метров', activator = function() end},
				{text = 'середняк', activator = function() end},
				{text = 'близорукий. зато плохое зрение компенсируется слухом', activator = function() end},
				{text = 'тугоух. не все должны стать музыкантами', activator = function() end},
				{text = 'слепоглухой. в детстве у вас был несчастный случай', activator = function() end},
			}
		}, Question),
		setmetatable({
			text = {"как у вас со здоровьем"},
			choises = {
				{text = 'троль', 		activator = function()  end},
				{text = 'здоровяк ', 	activator = function() end},
				{text = 'закаленный', 	activator = function() end},
				{text = 'середняк', 	activator = function() end},
				{text = 'слабак. вы часто болеете', activator = function() end},
				{text = 'болезненный.малейшее дуновение ветерка вызывает у вас простуду', activator = function() end},
				{text = 'ни дня здоровым. вы никогда не были здоровы и не будете', activator = function() end},
			}
		}, Question),
		
		setmetatable({
			text = {'какой вы рассы'},
			choises = {
				{text = 'южанин', 			activator = function()  end},
				{text = 'северянин ', 		activator = function() end},
				{text = 'степняк', 			activator = function() end},
				{text = 'орк',     			activator = function() end},
				{text = 'эльф', 			activator = function() end},
				{text = 'гном', 			activator = function() end},
				{text = 'подземный эльф', 	activator = function() end},
			}
		}, Question),
		
		setmetatable({
			text = {
				'вы попали в цитадель обучения воинов магов, от размера здания у вас перехватывает дыхание  и кружится голова.',
				'Перед вами стоит огромный мужик с ног до головы закрытый в позолоченные черные доспехи.',
				'Kак твое имя?',
				},
			choises = {
				{text = 'имя',  activator = function()  end},
				{text = 'моё ', activator = function() end},
				{text = 'ээ',   activator = function() end},
				{text = 'промолчать', activator = function() end},			
			}
		}, Question),
		
		setmetatable({
			text = {
				string.format("отлично так и будем тебя звать")
				},
			choises = {
				{text = 'дальше', activator = function()  end},
				
			}
		}, Question),
		
		setmetatable({
			text = {
				'так начались двадцать лет жестоких тренировок',
				'на что вы будете обращать наибольшее внимание',
				},
			choises = {
				{text = 'ближний бой и сила оружия единственное достойное истинного рыцаря.', activator = function()  end},
				{text = 'магия даст наибольшую власть ', activator = function() end},
				{text = 'шпионаж поможет вам придти к власти', activator = function() end},
				{text = 'всё. никогда не знаешь, что может понадобиться', activator = function() end},
				{text = 'забить на всё и расслабиться', activator = function() end},
			}
		}, Question),
		setmetatable({
			ifFunc = function ()
				return Unit.hero.past.sex == 'female'
			end,
			text = {"В одном из учебных дней внезапно старший рыцарь наставник Гаспар заметил вашу увеличившуюся грудь.",
					"Обучение было предуссмотрено только для мужчин.",
					"Обнародывание этого факта вызовет невиданный ранее скандал и исключение, а может и казнь.",
					"   - Так так юная леди, не знаю как это не всплыло до сих пор, но дальше нас дурачить не получится.",
					"   -Ну, что скажете в своё оправдание?"
					},
			choises = {
				{text = '(соврать) Чегоо? Дядя ты что? рехнулся? твои глаза тбе врут!', activator = function()  end},
				{text = 'Я так больше не буду.', activator = function()  end},
				{text = '(медленно и соблазнительно расстегнуть рубашку взять его огромные, мазолистые руки и положить их на свою горячую грудь). Ну мы же сможем сохранить это в тайне?', 
				 activator = function() M.startQuestions.opened = true end},
				{text = '(внезапно наброситься и свернуть ему шею.)', activator = function()  end},
				{text = '(перерезать ему горло резким выпадом)', activator = function()  end},
				{text = '(кокетливо подмигнуть и соблазнительно улыбнуться)', activator = function()  end},
			}
		}, Question),
		
		setmetatable(
		{
			ifFunc = function()
				return M.startQuestions.opened == true and Unit.hero.chars.baseChar.charisma == 20;				
			end,
			text = 
				{
					"он падает перед вами на колени, его руки оказываются на ваших бёдрах, а из глаз текут слёзы счатья",
					"кажется у вас появился новый раб",
					"	- я весь твой хозяйка ",					
				},
			choises = {
				{text = 'ты же будешь меня слушаться, верно?', activator = function()  end},
				{text = '(Вас не покидает идея испробовать запретного плода.) Пойдем в твою комнату.', activator = function()  end},
				{text = "уличив момент вы пыряете его ножом в легкое сзади, все как вас учили", 
				 activator = function() M.startQuestions.opened = true end},
				{text = 'начать упираться и пригрозить, что вы закричите', activator = function()  end},
				{text = '(поддавшись какой то дикой животной похоти разворачиваете его к себе, снимаете штаны и начинаете отсасывать)', activator = function()  end},
				{text = '(остановить его, начать раздеваться) давай прямо здесь, опасность меня так возбуждает', activator = function()  end},
			},
			
		}
		, Question),
		
		setmetatable(
		{
			ifFunc = function()
				return M.startQuestions.opened == true and Unit.hero.chars.baseChar.charisma == 12;
				
			end,
			text = 
				{
					"на его лице расцветает пахабная улыбка.",
					"он крепко сжимает вашу юную упругую грудь, а из вас непроизвольно выдавливается стон нето боли нето наслаждения.",
					"не выдерживая своей похоти он хватает вас за руку и тащит в свою темную комнату."
				},
			choises = {
				{text = 'пойти за ним предвкушая приятное времяпровождение.', activator = function()  end},
				{text = 'Пойти за ним надеясь,что ничего плохого с вами не случится', activator = function()  end},
				{text = "уличив момент вы пыряете его ножом в легкое сзади, все как вас учили", 
				 activator = function() M.startQuestions.opened = true end},
				{text = 'начать упираться и пригрозить, что вы закричите', activator = function()  end},
				{text = '(поддавшись какой то дикой животной похоти разворачиваете его к себе, снимаете штаны и начинаете отсасывать)', activator = function()  end},
				{text = '(остановить его, начать раздеваться) давай прямо здесь, опасность меня так возбуждает', activator = function()  end},
			},
			
		}
		, Question),
		
	}

	
return M
