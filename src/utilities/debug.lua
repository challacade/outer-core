-- This file contains several functions for displaying debug data

debug = {}
debug.lineX1 = 0
debug.lineY1 = 0
debug.lineX2 = 1
debug.lineY2 = 1

function debug:d()

    love.graphics.setColor(0, 0, 0, 0.7)
    love.graphics.rectangle("fill", 16, 16, 840, 220)

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(fonts.debug)
    love.graphics.print("d1: " .. d1, 50, 32)
    love.graphics.print("d2: " .. d2, 50, 118)

end

function debug:single()

    love.graphics.setColor(0, 0, 0, 0.7)
    love.graphics.rectangle("fill", 16, 16, 1120, 165)

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(fonts.debug)
    love.graphics.print("data.bombCount: " .. data.bombCount, 40, 22)

end

function debug:singleSmall()

    love.graphics.setColor(0, 0, 0, 0.7)
    love.graphics.rectangle("fill", 16, 16, 580, 120)

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(fonts.debugSmall)
    love.graphics.print(d1, 40, 22)

end
