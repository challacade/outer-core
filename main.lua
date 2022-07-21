function love.load()
    math.randomseed(os.time())

    d1 = 0
    d2 = 0
    colliderToggle = false

    require("src/startup/gameStart")
    gameStart()
    --createNewSave()
 
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
end

function love.mousepressed(x, y, button)
    if button == 1 then
        mouse:leftClick()

        if gamestate == 0 then
            menu.levelSelect = true
            dj.play(sounds.click, "static", "effect")
        end
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
