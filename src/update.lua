function updateAll(dt)

    if pause.active == false then
        updateGame(dt)
    end
    
    --pause:update(dt)
    flux.update(dt)
    dj.cleanup()
    --if gameMap then gameMap:update(dt) end

end

function updateGame(dt)
    
    -- regular update stuff goes here
    local mx, my = cam:mousePosition()

    hoverTileX = math.floor(mx/16)
    hoverTileY = math.floor(my/16)

    if math.abs(hoverTileX) > 6 or hoverTileY < -5 or hoverTileY > 3 then
        hoverTileX = -100
        hoverTileY = -100
    end

    units:update(dt)

    cam:update(dt)
    
end