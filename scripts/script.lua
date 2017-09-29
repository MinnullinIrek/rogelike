package.path = package.path..";C:\\books\\roge\\rogelike\\scripts\\?.lua"



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

glLib.show()

print ("hi lua")

print(pcall(function()
	print("print before")	
	local m = require 'map'
	print("print after")	
 
 end))