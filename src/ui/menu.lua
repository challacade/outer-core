menu = {}
menu.levelSelect = false
menu.levelToStart = 0

function menu:draw()
    if gamestate == 0 and menu.levelSelect == false then
        setWhite()
        love.graphics.setFont(fonts.title)
        love.graphics.printf("Outer Core", love.graphics.getWidth()/2 - 1000, love.graphics.getHeight()/2 - 38*scale, 2000, "center")
        love.graphics.setFont(fonts.clickToBegin)
        love.graphics.printf("Click anywhere to begin", love.graphics.getWidth()/2 - 1000, love.graphics.getHeight()/2 + 10 * scale, 2000, "center")
    end

    if gamestate == 0 and menu.levelSelect == true then
        love.graphics.setFont(fonts.pickLevel)
        love.graphics.printf("Choose a Level", love.graphics.getWidth()/2 - 1000, love.graphics.getHeight()/2 - 70 * scale, 2000, "center")
        love.graphics.setFont(fonts.pickLevel2)
        love.graphics.printf("Tutorial in the first level", love.graphics.getWidth()/2 - 1000, love.graphics.getHeight()/2 - 58 * scale, 2000, "center")
        love.graphics.printf("GMTK Game Jam 2022 entry by Challacade", love.graphics.getWidth()/2 - 1000, love.graphics.getHeight()/2 + 58 * scale, 2000, "center")

        love.graphics.setFont(fonts.levelTitle)
        self:clickColor(1)
        love.graphics.printf("Level 1", love.graphics.getWidth()/2 - 1000, love.graphics.getHeight()/2 - 40 * scale, 2000, "center")
        self:clickColor(2)
        love.graphics.printf("Level 2", love.graphics.getWidth()/2 - 1000, love.graphics.getHeight()/2 - 25 * scale, 2000, "center")
        self:clickColor(3)
        love.graphics.printf("Level 3", love.graphics.getWidth()/2 - 1000, love.graphics.getHeight()/2 - 10 * scale, 2000, "center")
        self:clickColor(4)
        love.graphics.printf("Level 4", love.graphics.getWidth()/2 - 1000, love.graphics.getHeight()/2 + 5 * scale, 2000, "center")
        self:clickColor(5)
        love.graphics.printf("Level 5", love.graphics.getWidth()/2 - 1000, love.graphics.getHeight()/2 + 20 * scale, 2000, "center")

        --local spr = sprites.ui.planet
        --love.graphics.draw(spr, love.graphics.getWidth()/2 - 120*scale, love.graphics.getHeight()/2, nil, 4, nil, spr:getWidth()/2, spr:getHeight()/2)
    end
end

function menu:clickColor(ind)
    if self.levelToStart == ind then
        setColorFromString("red")
    else
        setWhite()
    end
end
