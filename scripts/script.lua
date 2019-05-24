
print(xpcall(function()
	
	local longText = [[
		this is some long long very very long text. one of the longest texsts ever or not/
		fgdgdg jkjyu kj jlkfg kf kljlkrtje t keljrtlkjert iojsdlfj kjltejrokjg; ijklghj weapon
		dgjiojgkjoipkl lfksf;lgk ew wk;lkg kwops' slfgko skg;ls'joiwm kwjgiow ijglkj ;wjgwioj 
		kwopjgl;si ijgl;kjgi kjb[k'ak ]qp;lgsk  kl'[oiwl kp[k;'s k[ok;'lkgsp[ok kpokgk opk l;
		sk;lkgpok;lkpkg;lkpwgk; k;lslfgkopwkjklkj kl;sgj[pok lgk;'lgkop ok;lfgk ok;lk ;lkgsg
		this is some long long very very long text. one of the longest texsts ever or not/
		fgdgdg jkjyu kj jlkfg kf kljlkrtje t keljrtlkjert iojsdlfj kjltejrokjg; ijklghj weapon
		dgjiojgkjoipkl lfksf;lgk ew wk;lkg kwops' slfgko skg;ls'joiwm kwjgiow ijglkj ;wjgwioj 
		kwopjgl;si ijgl;kjgi kjb[k'ak ]qp;lgsk  kl'[oiwl kp[k;'s k[ok;'lkgsp[ok kpokgk opk l;
		sk;lkgpok;lkpkg;lkpwgk; k;lslfgkopwkjklkj kl;sgj[pok lgk;'lgkop ok;lfgk ok;lk ;lkgsg
		this is some long long very very long text. one of the longest texsts ever or not/
		fgdgdg jkjyu kj jlkfg kf kljlkrtje t keljrtlkjert iojsdlfj kjltejrokjg; ijklghj weapon
		dgjiojgkjoipkl lfksf;lgk ew wk;lkg kwops' slfgko skg;ls'joiwm kwjgiow ijglkj ;wjgwioj 
		kwopjgl;si ijgl;kjgi kjb[k'ak ]qp;lgsk  kl'[oiwl kp[k;'s k[ok;'lkgsp[ok kpokgk opk l;
		sk;lkgpok;lkpkg;lkpwgk; k;lslfgkopwkjklkj kl;sgj[pok lgk;'lgkop ok;lfgk ok;lk ;lkgsg
		this is some long long very very long text. one of the longest texsts ever or not/
		fgdgdg jkjyu kj jlkfg kf kljlkrtje t keljrtlkjert iojsdlfj kjltejrokjg; ijklghj weapon
		dgjiojgkjoipkl lfksf;lgk ew wk;lkg kwops' slfgko skg;ls'joiwm kwjgiow ijglkj ;wjgwioj 
		kwopjgl;si ijgl;kjgi kjb[k'ak ]qp;lgsk  kl'[oiwl kp[k;'s k[ok;'lkgsp[ok kpokgk opk l;
		sk;lkgpok;lkpkg;lkpwgk; k;lslfgkopwkjklkj kl;sgj[pok lgk;'lgkop ok;lfgk ok;lk ;lkgsg
		this is some long long very very long text. one of the longest texsts ever or not/
		fgdgdg jkjyu kj jlkfg kf kljlkrtje t keljrtlkjert iojsdlfj kjltejrokjg; ijklghj weapon
		dgjiojgkjoipkl lfksf;lgk ew wk;lkg kwops' slfgko skg;ls'joiwm kwjgiow ijglkj ;wjgwioj 
		kwopjgl;si ijgl;kjgi kjb[k'ak ]qp;lgsk  kl'[oiwl kp[k;'s k[ok;'lkgsp[ok kpokgk opk l;
		sk;lkgpok;lkpkg;lkpwgk; k;lslfgkopwkjklkj kl;sgj[pok lgk;'lgkop ok;lfgk ok;lk ;lkgsg
		this is some long long very very long text. one of the longest texsts ever or not/
		fgdgdg jkjyu kj jlkfg kf kljlkrtje t keljrtlkjert iojsdlfj kjltejrokjg; ijklghj weapon
		dgjiojgkjoipkl lfksf;lgk ew wk;lkg kwops' slfgko skg;ls'joiwm kwjgiow ijglkj ;wjgwioj 
		kwopjgl;si ijgl;kjgi kjb[k'ak ]qp;lgsk  kl'[oiwl kp[k;'s k[ok;'lkgsp[ok kpokgk opk l;
		sk;lkgpok;lkpkg;lkpwgk; k;lslfgkopwkjklkj kl;sgj[pok lgk;'lgkop ok;lfgk ok;lk ;lkgsg
		this is the texsts end
	]]
	
	conLib.showWarning(longText, 10, 10, 40, 40)
	oldPrint = print
	
	path = "C:\\books\\roge\\rogelike\\scripts\\"
	package.path = string.format("%s;%s?.lua;%s?\\init.lua;", package.path, path, path)

	require 'utils'
	local dname = "script: "
	local function print(...) oprint(dname, ...) end
	
	local Char = require 'chars'
	ai = require 'ai'
	
	game = require 'game'
	
	
	print("print before", tname)
	local Dir     = require 'direction'
	local map     = require 'map'
	oldPrint("script")
	local Unit    	  = require 'unit'
	local mapCreator = require 'MapCreator'
	
	
	local mover   = require 'mover'
	local item    = require 'item'
	local Log     = require 'logus'
	
	local Item    = require 'item'
	local T   	= require 'texts'
	local Queue = require 'queue'
	local Timer = require 'timer'
	
	
	Unit.createHero()
	
	game.hero = Unit.hero

	local story = require 'story'
	-- oldPrint(string.format("game.hero = %s", game.hero))
	-- oldPrint(string.format("Unit.hero = %s", Unit.hero))
	
	assert(game.hero == Unit.hero, "epic fale")
	-- mapCreator.create()
	console       = require 'console'
	
	function setTestItem(unit, Item)
		
		local function setItem(name, ch, type, tblLight, tblBodyPart,chars, descripion)
			local item = Item.createItem(name, ch, type, tblLight, tblBodyPart, chars, descripion)
			
			unit.inventory:putItem(item)
			unit.body:wear(item)
		end
		
		setItem(T.cuirass, 'R', 'armour', {light = true}, {brest=true}, Char.createChar('itemChar', {value = {100, 10, 100}}), 'staraya rjavaya kirasa')
		setItem('sword', 'S', 'weapon', {weapon = true}, {rightHand=true, rightArm = true}, Char.createChar('itemChar', {value = {100, 2, 100}}), 'mech pokritiy tolstim sloem hjavchini')
		setItem(T.helm, 'Í', 'armour', {medium = true}, {head=true, neck = true}, Char.createChar('itemChar', {value = {100,  40, 100}}), 'shlem pokritiy volnistimi uzorami')
		
		setItem(T.glove, T.P, 'armour', {light = true}, {leftHand=true, leftArm = true}, Char.createChar('itemChar', {value = {100, 20, 100}}), 'dlinnaya perchatka')
		setItem(T.iron_glove, 'J', 'armour', {hevy = true}, {rightHand=true, rightArm = true}, Char.createChar('itemChar', {value = {100, 70, 100}}), 'tyajelaya metallicheskaya perchatka')
		
		setItem(T.skin_boot, 'B', 'armour', {medium = true}, {leftLeg=true, leftFoot = true}, Char.createChar('itemChar', {value = {100, 10, 100}}), 	'obichniy sapou')
		setItem(T.skin_boot, 'B', 'armour', {medium = true}, {rightLeg=true, rightFoot = true}, Char.createChar('itemChar', {value = {100, 10, 100}}), 			'obichniy sapog')
		
		
				
		item = Item.createItem('sword', 'S', 'weapon', {weapon = true}, {rightHand=true, rightArm = true}, Char.createChar('itemChar', {value = {100, 60}}), 'stariy rjaviy mech')
		
		local cell = map.map:getCell(5,5)
		
		cell:putItem(item)
		
		local rock = Unit.createRock()
		map.map:setUnit(10, 10, rock)
		
	end
	
	setTestItem(Unit.hero, Item)
	
	assert(game.hero == Unit.hero, "epic fale")
	
	console.changeRejim('question', story.startQuestions)
	
	local i = 0
	 while i ~= 32 do
		i = console.getCh()
		local dir = Dir.direction[i]
		if dir == 'i' or dir == 'p' then
			console.changeRejim('bag', dir)
		elseif dir == 'm' then
			console.changeRejim('map', dir)
		elseif dir == 'c' then
			console.changeRejim('chars', dir)
		elseif dir == '~' then
			console.mainScreen(1)
			-- i = 32
			local s = "enter"
			s =io.read()
			while s ~= 'exit' do
				-- print("s = ", s)
				local res, message = pcall(load(s))
				if not res then print(message) end
				s =io.read()
			end
			console.mainScreen(0)
			conLib.changeBuffer();
		elseif dir == 'l' then
			
		else
			console.Activer:dirHandle(dir)
		end
		if i ~= 32 then
			
			console.Activer:update()
		end
		ai.step()
		
		
	 end
	
	print("print after")	
 
 end, debug.traceback))
 
 console.mainScreen(1)
 local s = "enter"
			load('print ("s = ", "enter")')()

			s =io.read()
			while s ~= 'exit' do
				local res, message = pcall(load(s))
				if not res then print(message) end
				s =io.read()
			end
 console.mainScreen()
 console.getCh()