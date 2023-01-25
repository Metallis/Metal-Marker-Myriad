function point(marker, gameTime, guid)
    -- We use the various exploration.mapcomp categories as a toggle for this feature.
    local target = World:MarkerByGuid(guid)
    local playerPos = Mumble.PlayerCharacter.Position
    local vector = (target.Position - playerPos)
    vector = vector / vector:Length()
    local targetPos = playerPos + vector * 2

    marker:SetPos(targetPos.X, targetPos.Y, targetPos.Z)
    marker:SetRotX(math.atan2(vector.Y, vector.Z) - math.pi / 2)
    marker:SetRotY(math.atan2(vector.Z, vector.X) - math.pi / 2)
    marker:SetRotZ(math.atan2(vector.Y, vector.X) - math.pi / 2)
end
