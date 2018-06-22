package.path = package.path..";C:\\books\\roge\\rogelike\\scripts\\?.lua"


local dname = "script: "



-- cdX, cdY, colorBg, colorFg

-- conLib.putCh("dsdf1", 10, 10, 4,16, 5)

-- print(xpcall(start, debug.traceback))


print(xpcall(function()
	require 'utils'
	local function print(...) oprint(dname, ...) end
	
	local Char = require 'chars'
	ai = require 'ai'
	
	game = require 'game'
	
	
	print("print before", tname)
	local Dir     = require 'direction'
	local map     = require 'map'
	console = require 'console'
	
	local mover   = require 'mover'
	local item    = require 'item'
	local Log     = require 'logus'
	Unit    	  = require 'unit'
	local Item    = require 'item'
	
	game.hero = Unit.hero
	
	function setTestItem(unit, Item)
		local item = Item.createItem('cuirass', 'R', 'armour', {light = true}, {brest=true}, Char.createChar('itemChar', {value = {100}}))
		unit.inventory:putItem(item)
		unit.body:wear(item)
		
		item = Item.createItem('sword', 'S', 'weapon', {weapon = true}, {rightHand=true, rightArm = true}, Char.createChar('itemChar', {value = {100, 2}}))
		unit.inventory:putItem(item)
		unit.body:wear(item)
		
		
		item = Item.createItem('sword', 'S', 'weapon', {weapon = true}, {rightHand=true, rightArm = true}, Char.createChar('itemChar', {value = {100, 60}}))
		
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