package.path = package.path..";C:\\books\\roge\\rogelike\\scripts\\?.lua"



-- struct VisObject
-- {
    -- Color       objColor;
    -- Color       bgColor;
    -- wstring        ch;
    -- wstring type;
-- };





-- local map = m.map
print = function(...)
	local str = ''
	for i, v in ipairs(table.pack(...)) do
		str=str..' '..tostring(v)
	end
	glLib.print(str)
end



 -- print(glLib)
 -- print(opengl)

 
 
 
glLib.show("dsdfs1", "sdfsdf2")

print ("хпппп lua")

print("conLib", conLib.putCh)


print("color = ", color);








-- cdX, cdY, colorBg, colorFg

-- conLib.putCh("dsdf1", 10, 10, 4,16, 5)

function setTestItem(unit, Item)
	for i = 1, 10 do
		local item = Item.createItem('item 1', i)
		unit.inventory:putItem(item)
		
	end
end


print(pcall(function()
	
	print("print before")
	local Dir = require 'direction'
	local map = require 'map'
	local console = require 'console'
	local mover = require 'mover'
	local item  = require 'item'
	local Log   = require 'logus'
	local Unit  = require 'unit'
	local Item  = require 'item'
	
	setTestItem(Unit.hero, Item)
	
	local i = 0
	 while i ~= 32 do
		i = console.getCh()
		local dir = Dir.direction[i]
		if dir == 'i' then
			console.changeRejim('bag')
		elseif dir == 'm' then
			console.changeRejim('map')
		else
			mover.setDir(dir)
		end
		console.update()
	 end
	
	print("print after")	
 
 end))