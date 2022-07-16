mouse = {}

function mouse:leftClick()
    if isHoveringTile() then

        -- Check if the hovered tile contains a unit
        for _,u in ipairs(units) do
            if u.tileX == hoverTileX and u.tileY == hoverTileY then
                u.awaitingOrders = true
                selectedUnitId = u.id
            end
        end

    end
end

function mouse:releaseLeft()
    if isHoveringTile() then

        if not isHoverTileEmpty() then
            return nil
        end

        -- find units awaiting orders
        for _,u in ipairs(units) do
            if u.awaitingOrders then
                u:walkTo(hoverTileX, hoverTileY)
            end
        end

    end
end

function mouse:rightClick()

end
