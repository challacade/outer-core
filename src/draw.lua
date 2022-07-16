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
    local mapSprite = sprites.maps.test3
    --love.graphics.draw(mapSprite, ww/2*scale, ww/2*scale, nil, nil, nil, mapSprite:getWidth()/2, mapSprite:getHeight()/2)
    love.graphics.draw(mapSprite, 0, 0, nil, nil, nil, mapSprite:getWidth()/2, mapSprite:getHeight()/2)

end

function drawAfterCamera()
    --curtain:draw()
    if gamestate == 0 then return end
    --drawHUD()
    --pause:draw()
end