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

local bodyTbl = {
		3,
		3,
		10,
		10,
		5,
		5,
		5,
		5,
		60,
		10,
		10,
		3,
		3,
		3,
		3,
		3,
}
		
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
			self:iterBPartTypes(item.bodyPartTypes, function(bPart) 
				print('wear', bPart, self[bPart])
				self[bPart]['bpart']:wear(item, self)

			end)
		else
			self:unWear(item)
		end
		
	end,
	
	unWear = function(self, item)
		if item.isWeared then
			self:iterBPartTypes(item.bodyPartTypes, function(bPart) self[bPart]['bpart']:unWear(item, self)   end)
		end
	end,
	
	chooseRandom = function(self)
		return self[randomTbl(bodyTbl)]
		
	end,
	
}
metaBody.__index 	= metaBody
metaBody.__tostring = toStr

function M.createBody()

	local body = setmetatable(
	{
		id = nextSerial(),

		[1]  = {bpart			= createBodyPart('head'),	   	name = 'голова',	},
		[2]  = {bpart			= createBodyPart('neck'),	 	name = 'шея',		},
		[3]  = {bpart        	= createBodyPart('shoulder'),	name = 'л. плечо',	},
		[4]  = {bpart         	= createBodyPart('shoulder'),	name = 'п. плечо',	},
		[5]  = {bpart   		= createBodyPart('arm'),		name = 'л. рука',	},
		[6]  = {bpart	 		= createBodyPart('arm'),		name = 'п. рука',	},
		[7]  = {bpart    		= createBodyPart('hand'),		name = 'л. кисть',	},
		[8]  = {bpart     		= createBodyPart('hand'),		name = 'п. кисть',	},
		[9]  = {bpart          	= createBodyPart('brest'),		name = 'грудь',		},
		[10] = {bpart			= createBodyPart('belt'),		name = 'поясница',	},
		[11] = {bpart   		= createBodyPart('hip'),		name = 'л. бедро',	},
		[12] = {bpart    		= createBodyPart('hip'),		name = 'п. бедро',	},
		[13] = {bpart   		= createBodyPart('leg'),		name = 'л. нога',	},
		[14] = {bpart    		= createBodyPart('leg'),		name = 'п. нога',	},
		[15] = {bpart    		= createBodyPart('foot'),		name = 'л. ступня',	},
		[16] = {bpart     		= createBodyPart('foot'),		name = 'п. ступня',	},		
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