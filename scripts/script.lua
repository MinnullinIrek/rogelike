
print(xpcall(function()
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
	console       = require 'console'
	
	local mover   = require 'mover'
	local item    = require 'item'
	local Log     = require 'logus'
	local Unit    	  = require 'unit'
	local Item    = require 'item'
	local T   	= require 'texts'
	
	game.hero = Unit.hero
	
	function setTestItem(unit, Item)
		
		local function setItem(name, ch, type, tblLight, tblBodyPart,chars, descripion)
			local item = Item.createItem(name, ch, type, tblLight, tblBodyPart, chars, descripion)
			
			unit.inventory:putItem(item)
			unit.body:wear(item)
		end
		
		setItem(T.cuirass, 'R', 'armour', {light = true}, {brest=true}, Char.createChar('itemChar', {value = {100, 10, 100}}), 'стара€ ржава€ кираса')
		setItem('sword', 'S', 'weapon', {weapon = true}, {rightHand=true, rightArm = true}, Char.createChar('itemChar', {value = {100, 2, 100}}), 'меч покрыт толстым слоем ржавчины')
		setItem(T.helm, 'Ќ', 'armour', {medium = true}, {head=true, neck = true}, Char.createChar('itemChar', {value = {100,  40, 100}}), 'шлем покрытый волнистыми узорами')
		
		setItem(T.glove, T.P, 'armour', {light = true}, {leftHand=true, leftArm = true}, Char.createChar('itemChar', {value = {100, 20, 100}}), 'длинна€ перчаточка')
		setItem(T.iron_glove, 'J', 'armour', {hevy = true}, {rightHand=true, rightArm = true}, Char.createChar('itemChar', {value = {100, 70, 100}}), 'т€жЄла€ металлическа€ пречатка')
		
		setItem(T.skin_boot, 'B', 'armour', {medium = true}, {leftLeg=true, leftFoot = true}, Char.createChar('itemChar', {value = {100, 10, 100}}), 	'обычный сапог')
		setItem(T.skin_boot, 'B', 'armour', {medium = true}, {rightLeg=true, rightFoot = true}, Char.createChar('itemChar', {value = {100, 10, 100}}), 			'обычный сапог')
		
		
				
		item = Item.createItem('sword', 'S', 'weapon', {weapon = true}, {rightHand=true, rightArm = true}, Char.createChar('itemChar', {value = {100, 60}}), 'старый ржавый меч')
		
		local cell = map.map:getCell(5,5)
		
		cell:putItem(item)
		
		local rock = Unit.createRock()
		map.map:setUnit(10, 10, rock)
		
	end
	
	setTestItem(Unit.hero, Item)
	
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