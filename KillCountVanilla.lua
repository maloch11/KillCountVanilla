local killCount = CreateFrame("Frame")
killCount:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
killCount:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH")
killCount:RegisterEvent("PLAYER_TARGET_CHANGED")
killCount:RegisterEvent("ADDON_LOADED")

killCount:SetScript("OnEvent",
	function()
		if event == "ADDON_LOADED" then
			if not kill_count then
				kill_count = {}
			end
		end

		if event == "UPDATE_MOUSEOVER_UNIT" then
			if UnitIsFriend("player", "mouseover") then return end
			local name = UnitName('mouseover')
			local count = kill_count[name] 

			GameTooltip:AddLine("Kills: " .. (count and count or "0"))
			GameTooltip:Show()
		end

		if event == "PLAYER_TARGET_CHANGED" then
			if UnitExists("target") then
				this.currTarget = UnitName("target")
			end

		end

		if event == "CHAT_MSG_COMBAT_HOSTILE_DEATH" then
			if string.find(arg1, "You have slain") and this.currTarget then
				local count = kill_count[this.currTarget] 
				if count then
					kill_count[this.currTarget] = count + 1
				else
					kill_count[this.currTarget] = 1
				end
				this.currTarget = nil
			end
		end
	end
)

function Print(msg, r, g, b)
	DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b)
end

function PrintWhite(msg)
	Print(msg, 1.0, 1.0, 1.0)
end

SLASH_KCOUNT1 = "/kcount"
SlashCmdList["KCOUNT"] = function (msg)
	if msg == "reset" then
		local name = UnitName('target')
		kill_count[name] = 0
	else
		PrintWhite("Kill Count Vanilla:")
		PrintWhite("Target a mob you want to reset")
		PrintWhite("/kcount reset   -   reset kill count")
	end
end