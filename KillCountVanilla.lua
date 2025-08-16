local killCount = CreateFrame("Frame")
killCount:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
killCount:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH")
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

		if event == "CHAT_MSG_COMBAT_HOSTILE_DEATH" then
			local slainMob = nil
			local s, e, mobName = string.find(arg1, "You have slain (.+)!")
			if mobName then
				slainMob = mobName
			else
				s, e, mobName, killerName = string.find(arg1, "^(.+) is slain by (.+)!")
				if mobName and killerName then
					local isGroupMember = false
					if GetNumPartyMembers() > 0 then
						for i = 1, GetNumPartyMembers() do
							if UnitName("party"..i) == killerName then
								isGroupMember = true
								break
							end
						end
					elseif GetNumRaidMembers() > 0 then
						for i = 1, GetNumRaidMembers() do
							if UnitName("raid"..i) == killerName then
								isGroupMember = true
								break
							end
						end
					end

					if isGroupMember then
						slainMob = mobName
					end
				end
			end

			if slainMob then
				local count = kill_count[slainMob]
				if count then
					kill_count[slainMob] = count + 1
				else
					kill_count[slainMob] = 1
				end
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
	s, e, mobName = string.find(msg, "^view (.+)")
	if mobName then
		PrintWhite("Kills: " .. (kill_count[mobName] or "0"))
	elseif msg == "reset" then
		local name = UnitName('target')
		kill_count[name] = 0
	else
		PrintWhite("Kill Count Vanilla:")
		PrintWhite("/kcount reset   -   reset kill count for current target")
		PrintWhite("/kcount view <mob name>   -   view the kill count for the specified mob")
	end
end