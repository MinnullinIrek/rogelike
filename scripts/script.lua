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


print(pcall(function()
	print("print before")	
	local map = require 'map'
	local console = require 'console'
	
	
	 -- while true do
		-- local i = console.getCh()
		-- print('i = ', i)
		
	 -- end
	-- print('map', map)
	
	
	
	
	
	
	-- print("print after")	
 
 end))