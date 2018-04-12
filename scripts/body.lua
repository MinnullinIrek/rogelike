local M = {}
local tnil = {}

local Item = require "item"

local wearing = {--[[light, middle, heavy, weapon]]

	__tostring = function(self) return 'wearing' end
}

function createWearing()
	return setmetatable({}, wearing)
end

local bodyTypes = {
head 		= {__type = 'head',		item = createWearing()},
neck 		= {__type = 'neck',		item = createWearing()},
shoulder 	= {__type = 'shoulder',	item = createWearing()},
arm			= {__type = 'arm',		item = createWearing()},
hand		= {__type = 'hand',		item = createWearing()},
brest		= {__type = 'brest',	item = createWearing()},
belt		= {__type = 'belt',		item = createWearing()},
hip			= {__type = 'hip',		item = createWearing()},
leg			= {__type = 'leg',		item = createWearing()},
foot		= {__type = 'foot', 	item = createWearing()},
}

for nm, k in pairs(bodyTypes) do
	k.__index = bodyTypes[nm]
end

function createBodyPart(name)
	assert(bodyTypes[name], string.format("no bodyType %s", name) )
	return setmetatable({}, bodyTypes[name])
	
end


local metaBody = {
	
	wear = function(self, item)
		for bPart, k in pairs(item.bodyPartTypes) do
		    if self[bPart] then
				for itemType, j in pairs(self[bPart]) do
					print(itemType)
					local it = self[bPart][itemType]
					self:unWear(it)
					self[bPart][itemType] = item
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
metaBody.__index = metaBody

function M.createBody()

	local body = setmetatable(
	{
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