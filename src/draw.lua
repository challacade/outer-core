function drawBeforeCamera()
    --menu:draw()
end

function drawCamera()

    if gamestate == 0 then return end
    setWhite()

    if gameMap.layers["Base"] then
        --gameMap:drawLayer(gameMap.layers["Base"])
    end

end

function drawAfterCamera()
    --curtain:draw()
    if gamestate == 0 then return end
    --drawHUD()
    --pause:draw()
end