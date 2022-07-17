mouse = {}

function mouse:leftClick()
    if isHoveringTile() then

        -- Check if the hovered tile contains a unit
        for _,u in ipairs(units) do
            if u.coreId > 0 and u.tileX == hoverTileX and u.tileY == hoverTileY and heldItemId < 1 then
                u.awaitingOrders = true
                selectedUnitId = u.id
            end
        end

    elseif hoverItemId > 0 and hoverItemType > 0 then

        heldItemType = hoverItemType
        heldItemIndex = hoverItemIndex
        heldItemId = hoverItemId
        heldItemSprite = hoverItemSprite

        for _,u in ipairs(units) do
            u.awaitingOrders = false
        end

    end
end

function mouse:releaseLeft()
    if isHoveringTile() then

        if heldItemId > 0 then
            for _,u in ipairs(units) do
                if u.tileX == hoverTileX and u.tileY == hoverTileY then
                
                    -- Drop the item on this unit
                    if heldItemType == 1 then -- core
                        u.coreId = heldItemId
                        for i,c in ipairs(myCoresEquipped) do
                            if c == u.color then
                                myCoresEquipped[i] = nil
                            end
                        end
                        myCoresEquipped[heldItemIndex] = u.color
                        spawnBlast(u.x, u.y, 30, u.color, 0.4)
                    elseif heldItemType == 2 then
                        if heldItemId == 1 then -- "wrench"
                            u:applyWrench()
                        end
                        myItems[heldItemIndex] = -1
                    end

                end
            end
            heldItemType = -1
            heldItemIndex = -1
            heldItemId = -1
            heldItemSprite = nil
            return nil
        end

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
    heldItemType = -1
    heldItemIndex = -1
    heldItemId = -1
    heldItemSprite = nil

    if isHoveringTile() then

        

    end
end

function mouse:update(dt)
    if hoverItemType > 0 and heldItemType > 0 and heldItemType ~= hoverItemType then
        heldItemType = -1
        heldItemIndex = -1
        heldItemId = -1
        heldItemSprite = nil
    end
end
