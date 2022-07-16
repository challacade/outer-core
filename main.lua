function love.load()
    math.randomseed(os.time())

    d1 = 0
    d2 = 0
    colliderToggle = false

    require("src/startup/gameStart")
    gameStart()
    --createNewSave()

    --loadMap("menu")
 
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

    --local debug = require "src/debug"
    --debug:d()
    --debug:single()
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end
