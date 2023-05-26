local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGOUT")

frame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == "ChronkzBankAddon" then
        if GuildBankItemNames == nil then
            GuildBankItemNames = {}
        end
        if GuildBankItemAmounts == nil then
            GuildBankItemAmounts = {}
        end
        if Aa == nil then
            Aa = {}
        end
        if Bb == nil then
            Bb = {}
        end
        if Cc == nil then
            Cc = {}
        end
        if Dd == nil then
            Dd = {}
        end
        if Ee == nil then
            Ee = {}
        end
    elseif event == "PLAYER_LOGOUT" then
        -- local temporaryNameTable = {}
        -- local temporaryCountTable = {}
        -- for tab = 1, 4, 1 do
        --     local temp1 = {}
        --     for i = 1, 98, 1 do
        --         if GetGuildBankItemLink(tab, i) ~= nil then
        --             table.insert(temp1, GetGuildBankItemLink(tab, i))
        --         else
        --             table.insert(temp1, "No Item")
        --         end
        --     end
        --     table.insert(temporaryNameTable, temp1)
        -- end
        -- GuildBankItemNames = temporaryNameTable
        local a, b, c, d, e = GetGuildBankItemInfo(1, 1)
        Aa = a
        Bb = b
        Cc = c
        Dd = d
        Ee = e
        GuildBankItemNames = "fish"
        GuildBankItemAmounts = "cheese"
    end
end)
