function love.load()
    math.randomseed(os.time())

    d1 = 0
    d2 = 0
    colliderToggle = false

    require("src/startup/gameStart")
    gameStart()
    --createNewSave()

    --loadMap("menu")
    spawnGuide(0, -1, vector(-1, 0))
    spawnGuide(-5, -2, vector(0, 1))
    spawnGuide(-4, 2, vector(1, 0))
    spawnGuide(5, 1, vector(0, 1))
 
    dj.volume("effect", 1)

end

function love.update(dt)
    updateAll(dt)
end

function love.draw()
    drawBeforeCamera()

    cam:attach()
        drawCamera()
    cam:detach()

    drawAfterCamera()

    --debug:d()
    --debug:single()
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    if key == 'u' then
        spawnUnit(1, math.random(-5, 5), math.random(-3, 3))
    end

    if key == 'i' then
        spawnUnit(2, math.random(-5, 5), math.random(-3, 3))
    end

    if key == 'o' then
        spawnUnit(3, math.random(-5, 5), math.random(-3, 3))
    end

    if key == 'e' then
        spawnEnemy('skull', math.random(-5, 5), math.random(-3, 3))
    end
end

function love.mousepressed(x, y, button)
    if button == 1 then
        mouse:leftClick()
    end

    if button == 2 then
        mouse:rightClick()
    end
end

function love.mousereleased(x, y, button)
    if button == 1 then
        mouse:releaseLeft()
    end
end
