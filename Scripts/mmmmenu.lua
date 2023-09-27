-- What a glorious filename

-- Generic Menu Function
local function togglePSNA(menu)
    MMM_TogglePSNA()
end

-- Construct Menu
local root = Menu:Add("Metal Marker Myriad", nil)
local psna = root:Add("Show/Hide PSNA Marker", togglePSNA, false, false, "Shows/Hides a marker with today's PSNA waypoint codes")