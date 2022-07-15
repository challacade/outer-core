pause = {}
pause.active = false
pause.scale = scale
pause.alpha = 0
pause.width = 130 * pause.scale
pause.x = love.graphics.getWidth()/2 - (pause.width/2)
pause.y = 40 * pause.scale

pause.trueY = 28 * pause.scale
pause.fadeY = 40 * pause.scale

pause.leftX = love.graphics.getWidth()/2 - (56 * scale)

function pause:open()
    self.active = true
    flux.to(pause, 0.25, {alpha = 1}):ease("quadout")
    flux.to(pause, 0.25, {y = pause.trueY}):ease("quadout")
end

function pause:close()
    --self.active = false
    flux.to(pause, 0.25, {alpha = 0}):ease("quadout"):oncomplete(function() pause.active = false end)
    flux.to(pause, 0.25, {y = pause.fadeY}):ease("quadout")
end

function pause:toggle()
    if self.active then
        pause:close()
    else
        pause:open()
    end
end

function pause:update(dt)

end

function pause:draw()
    if self.active then
        love.graphics.setColor(0,0,0,0.7 * pause.alpha)
        love.graphics.rectangle("fill", -10, -10, love.graphics.getWidth() + 20, love.graphics.getHeight() + 20)
    end
end