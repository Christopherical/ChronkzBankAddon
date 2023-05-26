local EventFrame = CreateFrame("Frame", "EventFrame")
EventFrame:RegisterEvent("ADDON_LOADED")
EventFrame:RegisterEvent("PLAYER_LOGOUT")
EventFrame:RegisterEvent("GUILDBANKBAGSLOTS_CHANGED")


EventFrame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == "ChronkzBankAddon" then
        if GuildBankItemNames == nil then
            GuildBankItemNames = {}
        end
        if GuildBankItemAmounts == nil then
            GuildBankItemAmounts = {}
        end
        if CombinedItemAmountTable == nil then
            CombinedItemAmountTable = {}
        end
    elseif event == "GUILDBANKBAGSLOTS_CHANGED" then
        local temp2 = {}

        for tab = 1, 4, 1 do
            for i = 1, 98, 1 do
                local a, b = GetGuildBankItemInfo(tab, i)
                if a ~= nil then
                    temp2[i + ((tab - 1) * 98)] = b
                else
                    temp2[i + ((tab - 1) * 98)] = "No Item"
                end
            end
        end

        GuildBankItemAmounts = temp2
    elseif event == "PLAYER_LOGOUT" then
        local temp1 = {}

        for tab = 1, 4, 1 do
            for i = 1, 98, 1 do
                if GetGuildBankItemLink(tab, i) ~= nil then
                    temp1[i + ((tab - 1) * 98)] = GetGuildBankItemLink(tab, i)
                else
                    temp1[i + ((tab - 1) * 98)] = "No Item"
                end
            end
        end

        GuildBankItemNames = temp1
        CombinedItemAmountTable = {}

        for i = 1, #GuildBankItemNames, 1 do
            table.insert(CombinedItemAmountTable, { GuildBankItemNames[i], GuildBankItemAmounts[i] })
        end

        GuildBankItemNames = 0
        GuildBankItemAmounts = 0
    end
end)
