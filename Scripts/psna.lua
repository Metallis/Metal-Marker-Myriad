MMM.psna = {}

Debug:Watch("MMM_PSNA", MMM.psna)

-- #region Constants

local MARKER_ATTRIBUTES = {
    ["schedule-duration"] = 1440,
    iconSize = 0,
    ["copy-message"] = "PSNA Waypoints copied to clipboard!",
    triggerRange="1",
    autoTrigger="1"
}
local MARKER_COPIES = {
    { "0 8 * * 1", "[&BIgHAAA=][&BEwDAAA=][&BNIEAAA=][&BKYBAAA=][&BIMCAAA=][&BB4CAAA=]" },
    { "0 8 * * 2", "[&BH8HAAA=][&BEgAAAA=][&BBEAAAA=][&BKgCAAA=][&BGQCAAA=][&BIMBAAA=]" },
    { "0 8 * * 3", "[&BHoHAAA=][&BCEDAAA=][&BLQDAAA=][&BKYAAAA=][&BLQAAAA=][&BFEDAAA=]" },
    { "0 8 * * 4", "[&BH8HAAA=][&BF0AAAA=][&BEUDAAA=][&BO4CAAA=][&BJcBAAA=][&BOQBAAA=]" },
    { "0 8 * * 5", "[&BJcHAAA=][&BNUGAAA=][&BKYCAAA=][&BMwCAAA=][&BHsBAAA=][&BNMAAAA=]" },
    { "0 8 * * 6", "[&BH8HAAA=][&BB8DAAA=][&BNMCAAA=][&BFMCAAA=][&BJIBAAA=][&BF8BAAA=]" },
    { "0 8 * * 0", "[&BIYHAAA=][&BDoBAAA=][&BO4CAAA=][&BKcBAAA=][&BIUCAAA=][&BCECAAA=]" }
}

-- #endregion

-- Generates PSNA markers at the players current location until finding the current one, then copies it to their clipboard
function MMM_CopyPSNA()
    -- Get current position
    local origin = Mumble.PlayerCharacter.Position
    
    --Create generic marker attributes and add in coordinates
    local newMarkerAttributes = MARKER_ATTRIBUTES
    newMarkerAttributes.xpos = origin.X
    newMarkerAttributes.ypos = origin.Z
    newMarkerAttributes.zpos = origin.Y
  
    -- Loop through all markers until we find the one that isn't filtered by schedule
    for _, copyAttr in ipairs(MARKER_COPIES) do
        newMarkerAttributes.schedule = copyAttr[1]
        newMarkerAttributes.copy = copyAttr[2]
        local newMarker = Pack:CreateMarker(newMarkerAttributes)
  
        if (newMarker.BehaviorFiltered == false) then
            -- Once we find the non-filtered one, it'll copy itself to clipboard, then we remove it and break from the loop
            newMarker.Interact(true)
            newMarker:Remove()
            break
        -- Otherwise delete the marker we just created
        else
            newMarker:Remove()
        end
    end
end