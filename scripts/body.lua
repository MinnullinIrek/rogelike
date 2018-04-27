local M = {}

local dname = "body: "

local function print(...) oprint(dname, ...) end

local tnil = {}
local Log = require 'logus'
local Item = require "item"

local wearing = {--[[light, middle, heavy, weapon]]
	__type 		= 'wearing',
	__tostring  = toStr,
}

wearing.__index = wearing

function createWearing()
	return setmetatable({id = nextSerial()}, wearing)
end



local BodyType = {__type = 'BodyType', __tostring = toStr}
BodyType.__index = BodyType
-- print('rawget (self, __tostring)'..tostring(BodyType.__tostring))--rawget (BodyType, __tostring))


local bodyPart = {
	__type = 'bodyPart',
	__tostring = toStr,
	-- items = {}
	
	wear = function(self, item, body)
		assert(item.chars, 'no item chars')
		
		for itemType, j_true in pairs(item.itemTypes) do
					
			local unwearItem = self.item[itemType]
			
			if(unwearItem) then
				body:unWear(unwearItem)
			end
			
			self.item[itemType] = item
			item.isWeared = true
			
			Log.putMessage('wear'..self.__type..itemType)
		end
		
	end,
	
	unWear = function(self, item)
		for itemType, j_true in pairs(item.itemTypes) do
			self.item[itemType] = nil
			item.isWeared = false
		end
	end
}
bodyPart.__index = bodyPart

function createBodyPart(name)
	return setmetatable({__type = name, item = createWearing(), id = nextSerial()}, bodyPart)
end


local metaBody = {
	__type = 'body',
	
	iterBPartTypes = function(self, bodyPartTypes, func)
		for bPart, k_true in pairs(bodyPartTypes) do
			if self[bPart] then
				func(bPart)
			end
		end
	end,

	wear = function(self, item)
		if not item.isWeared then
			self:iterBPartTypes(item.bodyPartTypes, function(bPart) self[bPart][bPart]:wear(item, self)   end)
		else
			self:unWear(item)
		end
		
	end,
	
	unWear = function(self, item)
		if item.isWeared then
			self:iterBPartTypes(item.bodyPartTypes, function(bPart) self[bPart][bPart]:unWear(item, self)   end)
		end
	end,
	
	chooseRandom = function(self, item)
		local i = math.random(1, #self)
		return next(self[i])
	end,
	
}
metaBody.__index 	= metaBody
metaBody.__tostring = toStr

function M.createBody()

	local body = setmetatable(
	{
		id = nextSerial(),

		[1]  = {head 			= createBodyPart('head'),		},
		[2]  = {neck 			= createBodyPart('neck'),		},
		[3]  = {leftShoulder 	= createBodyPart('shoulder'),	},
		[4]  = {rightShoulder 	= createBodyPart('shoulder'),	},
		[5]  = {leftArm 		= createBodyPart('arm'),		},
		[6]  = {rightArm 		= createBodyPart('arm'),		},
		[7]  = {leftHand 		= createBodyPart('hand'),		},
		[8]  = {rightHand 		= createBodyPart('hand'),		},
		[9]  = {brest          	= createBodyPart('brest'),		},
		[10] = {belt 			= createBodyPart('belt'),		},
		[11] = {leftHip 		= createBodyPart('hip'),		},
		[12] = {rightHip 		= createBodyPart('hip'),		},
		[13] = {leftLeg 		= createBodyPart('leg'),		},
		[14] = {rightLeg 		= createBodyPart('leg'),		},
		[15] = {leftFoot 		= createBodyPart('foot'),		},
		[16] = {rightFoot 		= createBodyPart('foot'),		},		
	}, metaBody)
	
	
	body.head 					= body[1]
	body.neck 					= body[2]
	body.leftShoulder 			= body[3]
	body.rightShoulder 			= body[4]
	body.leftArm 				= body[5]
	body.rightArm 				= body[6]
	body.leftHand 				= body[7]
	body.rightHand 				= body[8]
	body.brest          		= body[9]
	body.belt 					= body[10]
	body.leftHip 				= body[11]
	body.rightHip 				= body[12]
	body.leftLeg 				= body[13]
	body.rightLeg 				= body[14]
	body.leftFoot 				= body[15]
	body.rightFoot 				= body[16]
	
	return body
end



return M