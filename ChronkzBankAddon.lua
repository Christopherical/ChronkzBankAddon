local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGOUT")

frame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == "ChronkzBankAddon" then
        -- Our saved variables, if they exist, have been loaded at this point.
        -- local a = GetGuildBankTabInfo(1)
         GuildBankInfo = "Global"
         GuildBankInfoLocal = "Local"
    end
end)


