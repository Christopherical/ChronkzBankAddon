local EventFrame = CreateFrame("Frame", "EventFrame")

-- https://wowpedia.fandom.com/wiki/Events
-- use /etrace in game to listen to events.
EventFrame:RegisterEvent("ADDON_LOADED")
EventFrame:RegisterEvent("PLAYER_LOGOUT")
EventFrame:RegisterEvent("GUILDBANKBAGSLOTS_CHANGED")

-- Addon to collect what items we have in our guild bank.
-- Collects the names of the items via GetGuildBankItemLink in the PLAYER_LOGOUT event.
-- Collects the amount of the items via GetGuildBankItemInfo in the GUILDBANKBAGSLOTS_CHANGED event.

Tab = 4
BankSlots = 98

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
        local temp = {}
        LastScanned = date("Last Scanned On: %d/%m/%y at %H:%M:%S.")

        -- https://wowpedia.fandom.com/wiki/API_GetGuildBankItemInfo
        -- texture, itemCount, locked, isFiltered, quality = GetGuildBankItemInfo(tab,slot)
        for tab = 1, Tab, 1 do
            for i = 1, BankSlots, 1 do
                local texture, itemCount = GetGuildBankItemInfo(tab, i)
                if texture ~= nil then
                    temp[i + ((tab - 1) * 98)] = itemCount
                else
                    temp[i + ((tab - 1) * 98)] = "No Item"
                end
            end
        end

        GuildBankItemAmounts = temp
    elseif event == "PLAYER_LOGOUT" then
        local temp1 = {}

        -- https://wowpedia.fandom.com/wiki/API_GetGuildBankItemLink
        -- itemLink = GetGuildBankItemLink(tab,slot)
        for tab = 1, Tab, 1 do
            for i = 1, BankSlots, 1 do
                if GetGuildBankItemLink(tab, i) ~= nil then
                    temp1[i + ((tab - 1) * BankSlots)] = GetGuildBankItemLink(tab, i)
                else
                    temp1[i + ((tab - 1) * BankSlots)] = "No Item"
                end
            end
        end

        GuildBankItemNames = temp1
        CombinedItemAmountTable = {}

        for i = 1, #GuildBankItemNames, 1 do
            table.insert(CombinedItemAmountTable, { GuildBankItemNames[i], GuildBankItemAmounts[i] })
        end

        GuildBankItemNames = LastScanned
        GuildBankItemAmounts = math.floor(GetGuildBankMoney() / 10000) -- GetGuildBankMoney() returns copper.
    end
end)
