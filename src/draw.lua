function drawBeforeCamera()
    --menu:draw()
end

function drawCamera()

    if gamestate == 0 then return end
    setWhite()

    --if gameMap.layers["Base"] then
        --gameMap:drawLayer(gameMap.layers["Base"])
    --end
    local ww, wh = love.graphics.getDimensions()
    local mapSprite = sprites.maps.test4
    --love.graphics.draw(mapSprite, ww/2*scale, ww/2*scale, nil, nil, nil, mapSprite:getWidth()/2, mapSprite:getHeight()/2)
    love.graphics.draw(mapSprite, 8, 0, nil, nil, nil, mapSprite:getWidth()/2, mapSprite:getHeight()/2)

    if hoverTileX > -100 and hoverTileY > -100 then
        love.graphics.rectangle('line', hoverTileX*16, hoverTileY*16, 16, 16)
    end

end

function drawAfterCamera()
    --curtain:draw()
    if gamestate == 0 then return end
    --drawHUD()
    --pause:draw()
end