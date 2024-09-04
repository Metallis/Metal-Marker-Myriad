-- What a glorious filename

-- Generic Menu Function
local function copyPSNA(menu)
    MMM_CopyPSNA()
end

local function copyBait(menu)
    MMM_copyBait()
end

-- Construct Menu
local root = Menu:Add("MMM - Copy PSNA WPs", copyPSNA, false, false, "Copies today's PSNA waypoint codes")
local root = Menu:Add("MMM - Copy Fishing Bait WPs", copyBait, false, false, "Copies bait waypoint codes")