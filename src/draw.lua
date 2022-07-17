function drawBeforeCamera()
    --menu:draw()
end

function drawCamera()

    background:draw()

    if gamestate == 0 then return end
    setWhite()

    --if gameMap.layers["Base"] then
        --gameMap:drawLayer(gameMap.layers["Base"])
    --end
    local ww, wh = love.graphics.getDimensions()
    local mapSprite = manager.mapSprite
    --love.graphics.draw(mapSprite, ww/2*scale, ww/2*scale, nil, nil, nil, mapSprite:getWidth()/2, mapSprite:getHeight()/2)
    if mapSprite then
        love.graphics.draw(mapSprite, 8, 0, nil, nil, nil, mapSprite:getWidth()/2, mapSprite:getHeight()/2)
    end

    -- walking arrow
    if selectedUnitId >= 0 and isHoveringTile() then
        local arrowX = 0
        local arrowY = 0
        for _,u in ipairs(units) do
            if u.id == selectedUnitId then
                arrowX = u.x
                arrowY = u.y
                setColorFromString(u.color)
            end
        end
        local destX = hoverTileX*16 + 8
        local destY = hoverTileY*16 + 8
        love.graphics.setLineWidth(2)
        love.graphics.line(arrowX, arrowY, destX, destY)
        local rot = math.atan2(destY-arrowY, destX-arrowX)
        love.graphics.draw(sprites.ui.arrowHead, destX, destY, rot, nil, nil, sprites.ui.arrowHead:getWidth()/2, sprites.ui.arrowHead:getHeight()/2)
    end

    if hoverTileX > -100 and hoverTileY > -100 then
        love.graphics.setLineWidth(1.5)
        love.graphics.rectangle('line', hoverTileX*16, hoverTileY*16, 16, 16)
    end

    projectiles:draw()
    enemies:draw()
    units:draw()
    blasts:draw()
    particles:draw()

    sidePanel:draw()
    hoverPanel:draw()
    tutorial:drawBox()

    if heldItemSprite then
        setWhite()
        local mx, my = cam:mousePosition() 
        love.graphics.draw(heldItemSprite, mx, my, nil, nil, nil, heldItemSprite:getWidth()/2, heldItemSprite:getHeight()/2)
    end

end

function drawAfterCamera()
    --curtain:draw()
    menu:draw()
    if gamestate ~= 0 then
        hoverPanel:drawText()
        manager:draw()
        tutorial:drawText()
    end
    --drawHUD()
    --pause:draw()
    curtain:draw()
end