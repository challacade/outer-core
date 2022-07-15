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

    cam:update(dt)
    
end