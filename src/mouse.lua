mouse = {}

function mouse:leftClick()
    if tutorial.active then
        tutorial.stage = tutorial.stage + 1
        dj.play(sounds.click, "static", "effect")
        return nil
    end

    if gamestate == 0 and menu.levelSelect then
        local mx, my = love.mouse.getPosition()
        if mx > love.graphics.getWidth()/2 - (30*scale) and mx < love.graphics.getWidth()/2 + (30*scale) then
            
            local halfW = love.graphics.getWidth()/2
            local halfH = love.graphics.getHeight()/2
            if my > halfH - (40*scale) and my < halfH - (24*scale) then
                menu.levelToStart = 1
            elseif my > halfH - (23*scale) and my < halfH - (8*scale) then
                menu.levelToStart = 2
            elseif my > halfH - (7*scale) and my < halfH + (8*scale) then
                menu.levelToStart = 3
            elseif my > halfH + (9*scale) and my < halfH + (23*scale) then
                menu.levelToStart = 4
            elseif my > halfH + (24*scale) and my < halfH + (39*scale) then
                menu.levelToStart = 5
            end

            if menu.levelToStart > 0 then
                curtain:call()
                dj.play(sounds.click, "static", "effect")
            end

        end
    end

    if gamestate == 0 then return nil end

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
    if tutorial.active then
        return nil
    end

    if isHoveringTile() then

        if heldItemId > 0 then
            for _,u in ipairs(units) do
                if u.tileX == hoverTileX and u.tileY == hoverTileY then
                
                    -- Drop the item on this unit
                    if heldItemType == 1 then -- core
                        for i,a in ipairs(units) do
                            if a.coreId == heldItemId then
                                a.coreId = 0
                            end
                        end
                        u.coreId = heldItemId
                        for i,c in ipairs(myCoresEquipped) do
                            if c == u.color then
                                myCoresEquipped[i] = 0
                            end
                        end
                        myCoresEquipped[heldItemIndex] = u.color
                        spawnBlast(u.x, u.y, 30, u.color, 0.4)
                        dj.play(sounds.click, "static", "effect")
                    elseif heldItemType == 2 then
                        if heldItemId == 1 then -- "wrench"
                            u:applyWrench()
                        elseif heldItemId == 2 then -- "battery"
                            u:applyBattery()
                        end
                        spawnBlast(u.x, u.y, 30, u.color, 0.4)
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
                dj.play(sounds.click, "static", "effect")
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
