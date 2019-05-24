local M = {}

-- local dialogChain = {
	-- replic = '',
	-- answers = {
				-- [1] = {answer = "some answer", dialogChain=..., hasChoosed = false, activator = function() end}
				
			-- }
-- }

local dialog = {
	-- dialogChain,
	-- currentChain,
	chooseAnswer = function (self, answerNumber)
		self.currentChain.answers[answerNumber].activator()
		local nextChain = self.currentChain.answers[answerNumber].dialogChain
		if nextChain then
			self.currentChain = nextChain
		end
	end,
	
	showChain = function (self)
		if self.currentChain then
			local answerNumber = conLib.showDialog(self.currentChain)
			self:chooseAnswer(answerNumber)
			self:showChain()
		end
	end,
	
	setDialog = function(self, chain)
		self.dialogChain = chain
		self.currentChain = chain
	end
}

dialog. __index = dialog




function M.showDialog(chain)
	dialog:setDialog(chain)
	dialog:showChain()
	
	
end



return M