package.path = package.path..";C:\\books\\roge\\rogelike\\scripts\\?.lua"


local dname = "script: "



-- struct VisObject
-- {
    -- Color       objColor;
    -- Color       bgColor;
    -- wstring        ch;
    -- wstring type;
-- };





-- local map = m.map
-- print = function(...)
	-- local str = ''
	-- for i, v in ipairs(table.pack(...)) do
		-- str=str..' '..tostring(v)
	-- end
	-- glLib.print(str)
-- end




 -- print(opengl)

 
 
 
glLib.show("dsdfs1", "sdfsdf2")

print ("хпппп lua")

print("conLib", conLib.putCh)


print("color = ", color);








-- cdX, cdY, colorBg, colorFg

-- conLib.putCh("dsdf1", 10, 10, 4,16, 5)




print(pcall(function()
	require 'utils'
	local function print(...) oprint(dname, ...) end
	
	local Char = require 'chars'
	
	
	
	
	
	print("print before", tname)
	local Dir     = require 'direction'
	local map     = require 'map'
	local console = require 'console'
	
	local mover   = require 'mover'
	local item    = require 'item'
	local Log     = require 'logus'
	local Unit    = require 'unit'
	local Item    = require 'item'
	
	function setTestItem(unit, Item)
		local item = Item.createItem('cuirass', 'R', 'armour', {light = true}, {brest=true}, Char.createChar('itemChar'))
		unit.inventory:putItem(item)
		unit.body:wear(item)
		
		item = Item.createItem('sword', 'S', 'weapon', {weapon = true}, {rightHand=true, rightArm = true}, Char.createChar('itemChar'))
		unit.inventory:putItem(item)
		unit.body:wear(item)

		item = Item.createItem('sword', 'S', 'weapon', {weapon = true}, {rightHand=true, rightArm = true}, Char.createChar('itemChar'))
		
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
			-- Log.putMessage("pressed i")
			console.changeRejim('bag', dir)
		elseif dir == 'm' then
			console.changeRejim('map', dir)
		else
			console.Activer:dirHandle(dir)
		end
		console.Activer:update()
	 end
	
	print("print after")	
 
 end))