MMM = {}

Debug:Print("Loading Metal Marker Myriad...")

Pack:Require("Data/Scripts/compass_pointer")
Pack:Require("Scripts/psna.lua")
Pack:Require("Scripts/mmmmenu.lua")

local function tick(gameTime)
    local playerPos  = Mumble.PlayerCharacter.Position
    local target = World:MarkerByGuid(guid)
end
