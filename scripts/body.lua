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



local head 		= {__type = 'head',			item = createWearing(), __tostring    = toStr}
local neck 		= {__type = 'neck',			item = createWearing(), __tostring    = toStr} 
local shoulder 	= {__type = 'shoulder',		item = createWearing(), __tostring    = toStr} 
local arm		= {__type = 'arm',			item = createWearing(), __tostring    = toStr} 
local hand		= {__type = 'hand',			item = createWearing(), __tostring    = toStr} 
local brest		= {__type = 'brest',		item = createWearing(), __tostring    = toStr} 
local belt		= {__type = 'belt',			item = createWearing(), __tostring    = toStr} 
local hip		= {__type = 'hip',			item = createWearing(), __tostring    = toStr} 
local leg		= {__type = 'leg',			item = createWearing(), __tostring    = toStr} 
local foot		= {__type = 'foot', 		item = createWearing(), __tostring    = toStr} 


head.__index 		= head
neck.__index 		= neck
shoulder.__index 	= shoulder
arm.__index			= arm
hand.__index		= hand
brest.__index		= brest
belt.__index		= belt
hip.__index			= hip
leg.__index			= leg
foot.__index		= foot

local bodyTypes = {
	head 		= head,
	neck 		= neck,
	shoulder 	= shoulder,
	arm			= arm,
	hand		= hand,
	brest		= brest,
	belt		= belt,
	hip			= hip,
	leg			= leg,
	foot		= foot,
}


function createBodyPart(name)
	assert(bodyTypes[name], string.format("no bodyType %s", name) )
	
	local t = setmetatable({__type = name, item = createWearing(), id = nextSerial()}, bodyTypes[name])
	-- print('t=', t)
	
	return t
end


local metaBody = {
	__type = 'body',
	wear = function(self, item)
		
		for bPart, k_true in pairs(item.bodyPartTypes) do
			print('body wear', bPart, k_true)
		    if self[bPart] then
				print('self[',bPart,']^^^^=', self[bPart][bPart])
				for itemType, j_true in pairs(item.itemTypes) do
					
					local it = (self[bPart][bPart]['item'] or tnil)[itemType]
					self:unWear(it)
					self[bPart][bPart]['item'][itemType] = item
					Log.putMessage('wear'..bPart..itemType)
					
					
				end
			end
		end
	end,
	
	unWear = function(self, item)
	
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