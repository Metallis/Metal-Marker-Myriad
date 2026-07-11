MMM.psna = {
    currentUTCTime = nil,
    utcMinusEight = nil,
    psnaDay = nil,
    copy = nil
}

Debug:Watch("MMM_PSNA", MMM.psna)

local COPY_INFO = {
    { "Monday", "[&BIgHAAA=][&BEwDAAA=][&BNIEAAA=][&BKYBAAA=][&BIMCAAA=][&BB4CAAA=]" },
    { "Tuesday", "[&BH8HAAA=][&BEgAAAA=][&BBEAAAA=][&BKgCAAA=][&BGQCAAA=][&BIMBAAA=]" },
    { "Wednesday", "[&BHoHAAA=][&BCEDAAA=][&BLQDAAA=][&BKYAAAA=][&BLQAAAA=][&BFEDAAA=]" },
    { "Thursday", "[&BH8HAAA=][&BF0AAAA=][&BEUDAAA=][&BO4CAAA=][&BJcBAAA=][&BOQBAAA=]" },
    { "Friday", "[&BJcHAAA=][&BNUGAAA=][&BKYCAAA=][&BMwCAAA=][&BHsBAAA=][&BNMAAAA=]" },
    { "Saturday", "[&BH8HAAA=][&BB8DAAA=][&BNMCAAA=][&BFMCAAA=][&BJIBAAA=][&BF8BAAA=]" },
    { "Sunday", "[&BIYHAAA=][&BDoBAAA=][&BO4CAAA=][&BKcBAAA=][&BIUCAAA=][&BCECAAA=]" }
}

-- Copies the current day's PSNA to the user's clipboard
function MMM_CopyPSNA()
    MMM.psna.currentUTCTime = os.time(os.date("!*t"))
    MMM.psna.utcMinusEight = MMM.psna.currentUTCTime - (8 * 3600)
    MMM.psna.psnaDay = os.date("%A", MMM.psna.utcMinusEight)

    local copy = COPY_INFO[MMM.psna.psnaDay]

    if copy then
        User.SetClipboard(copy,"Today's PSNA Waypoints copied to clipboard!")
    end

end
