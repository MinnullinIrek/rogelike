local M = {}
local Text = require 'text'
local Item = require 'item'
local staticFist = {chars= {armour = {value = 10}, damage = {value = 1}, hp = {value = 10}}, name = 'кулак'}

M.attack = function(attacker, defender)	
	
	if defender.__type ~= 'rock' then
	

		local weapon = attacker.body.rightHand.bpart.item.weapon or staticFist
		print('weapon', weapon.chars.armour)

		if randomGame(attacker.chars.finalChar.accuracy.value, defender.chars.finalChar.dodge.value) == 1 then
			
			local bpart = defender.body:chooseRandom()
			
			local items = bpart.bpart.item
			local armourBreak = weapon.chars.armour.value
			
			local breacked = true
			local attackerArmourBreak = weapon.chars.armour.value
			local weaponDamage = weapon.chars.damage.value
			
			Text.putMessage(string.format('%s получил удар %sм в %s', defender.name, weapon.name, bpart.name  ))
			
			for i, armourType in ipairs(Item.armour.armourTypes) do
				if breacked and items[armourType] and items[armourType].chars.armour.value then
					local armour = items[armourType]
					local armourValue = armour.chars.armour.value
					Text.putMessage(string.format("arm.damage %s", armour.chars.damage.value ))
					if randomGame(attackerArmourBreak, armourValue) == 1 then
						attackerArmourBreak = attackerArmourBreak - weapon.chars.armour.value
						local adsorbed = weaponDamage * armour.chars.damage.value / 100
						weaponDamage = weaponDamage *(1 - armour.chars.damage.value / 100)
						armour.chars.hp.value = armour.chars.hp.value - adsorbed
					else
						Text.putMessage(string.format('%s заблокировал удар по %s', defender.name, items[armourType].name ))
						breacked = false
					end
				end				
			end


			if breacked then
				defender.chars.finalChar.hp.value = defender.chars.finalChar.hp.value - weaponDamage
			end
			
		else
			Text.putMessage(string.format('%s увернулся',defender.name))
		end
		
	end
	-- print('defender ', defender.chars.finalChar.hp.value)
	
end



return M