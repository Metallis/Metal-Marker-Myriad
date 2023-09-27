MMM.psna = {
    activeMarkers = {},
    shown = false,
    origin = nil
}

Debug:Watch("MMM_PSNA", MMM.psna)

-- #region Constants

local MARKER_TEXTURE = "Data/Icons/psna_clipboard.png"
local MARKER_ATTRIBUTES = {
    type = "other.psna",
    ["schedule-duration"] = 1440,
    iconSize = 3,
    heightOffset = 3,
    ["copy-message"] = "PSNA Waypoints copied to clipboard!",
    triggerRange="5"
}
local MARKER_COPIES = {
    { "0 8 * * 1", "[&BIgHAAA=][&BEwDAAA=][&BNIEAAA=][&BKYBAAA=][&BIMCAAA=][&BB4CAAA=]" },
    { "0 8 * * 2", "[&BH8HAAA=][&BEgAAAA=][&BBEAAAA=][&BKgCAAA=][&BGQCAAA=][&BIMBAAA=]" },
    { "0 8 * * 3", "[&BHoHAAA=][&BCEDAAA=][&BLQDAAA=][&BKYAAAA=][&BLQAAAA=][&BFEDAAA=]" },
    { "0 8 * * 4", "[&BH8HAAA=][&BF0AAAA=][&BEUDAAA=][&BO4CAAA=][&BJcBAAA=][&BOQBAAA=]" },
    { "0 8 * * 5", "[&BJcHAAA=][&BNUGAAA=][&BKYCAAA=][&BMwCAAA=][&BHsBAAA=][&BNMAAAA=]" },
    { "0 8 * * 6", "[&BH8HAAA=][&BB8DAAA=][&BNMCAAA=][&BFMCAAA=][&BJIBAAA=][&BF8BAAA=]" },
    { "0 8 * * 0", "[&BIYHAAA=][&BDoBAAA=][&BO4CAAA=][&BKcBAAA=][&BIUCAAA=][&BCECAAA=]" },
}

-- #endregion

-- #region Local Functions

-- Hides (removes) any active markers if they are currently shown
local function hidePSNA()
    if MMM.psna.shown then
        -- Loop through all active markers and remove them
        for _, marker in ipairs(MMM.psna.activeMarkers) do
            marker:Remove()
        end
        MMM.psna.activeMarkers = {}
        MMM.psna.origin = nil
        MMM.psna.shown = false
    end
end

-- Shows (creates) a set of PSNA markers at the players current location
local function showPSNA()
    -- Get and save current player position
    MMM.psna.origin = Mumble.PlayerCharacter.Position

    -- Create generic marker attributes and add in coordinates
    local newMarkerAttributes = MARKER_ATTRIBUTES
    newMarkerAttributes.xpos = MMM.psna.origin.X
    newMarkerAttributes.ypos = MMM.psna.origin.Z
    newMarkerAttributes.zpos = MMM.psna.origin.Y

    -- Create all 7 of the PSNA markers with their respective attributes, and add to the active markers table
    for i, copyAttr in ipairs(MARKER_COPIES) do
        newMarkerAttributes.schedule = copyAttr[1]
        newMarkerAttributes.copy = copyAttr[2]
        MMM.psna.activeMarkers[i] = Pack:CreateMarker(newMarkerAttributes)
        MMM.psna.activeMarkers[i]:SetTexture(MARKER_TEXTURE)
    end

    MMM.psna.shown = true
end

-- Tick handler to check if the player is within a certain distance of the created markers. If not, hides them
local function psnaTickHandler(gameTime)
    if MMM.psna.shown then
        if (Mumble.PlayerCharacter.Position - MMM.psna.origin):Length() > 40 then
            hidePSNA()
        end
    end
end

-- #endregion

-- Global function to toggle the PSNA markers
function MMM_TogglePSNA()
    if MMM.psna.shown then
        hidePSNA()
    else
        showPSNA()
    end
end

-- Assign tick handler
Event:OnTick(psnaTickHandler)