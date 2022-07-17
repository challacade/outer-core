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

    if math.abs(hoverTileX) > 6 or hoverTileY < -5 or hoverTileY > 4 then
        hoverTileX = -100
        hoverTileY = -100
    end

    d1 = hoverTileX
    d2 = hoverTileY

    projectiles:update(dt)
    enemies:update(dt)
    units:update(dt)

    manager:update(dt)
    sidePanel:update(dt)
    mouse:update(dt)
    hoverPanel:update(dt)

    removeDeadEnemies()
    removeDeadProjectiles()

    cam:update(dt)
    world:update(dt)
    particles:update(dt)
    blasts:update(dt)
    background:update(dt)
    
end