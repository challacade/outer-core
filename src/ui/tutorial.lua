tutorial = {}
tutorial.active = false
tutorial.stage = 0

tutorial.text = {
    "You need to defend against invading aliens. Luckily, you have some Fighter Bots on your side.",
    "These bots are powered by Cores (seen in the right panel). The core that a bot has equipped determines which attacks it will use.",
    "A Core is like a dice; each face of the core is a different attack it can use. However, it's a roll of the dice which attack will happen.",
    "Fortunately, each bot performs one of these attacks about once every 2 seconds. You can hover over a core to see more details.",
    "Click and drag a Core to your units to power them up with that core.",
    "After a unit is active, you can click and drag them to move them around the map to find better positions for their attacks.",
    "Be careful with Cores that have Malfunctions. The bot will need to re-roll if it lands a Malfunction.",
    "The invasion begins once all of your bots are powered up. Good luck!"
}

function tutorial:reset()
    self.active = true
    self.stage = 1
end

function tutorial:drawBox()
    if self.active then

        local spr = sprites.ui.tutorialBox
        love.graphics.draw(spr, 8, 0, nil, nil, nil, spr:getWidth()/2, spr:getHeight()/2)

    end
end

function tutorial:drawText()
    if self.active then

        local text = tutorial.text[tutorial.stage]
        if text == nil then self.active = false return nil end
        setWhite()
        love.graphics.setFont(fonts.tutorial)
        love.graphics.printf(text, love.graphics.getWidth()/2 - 50*scale, love.graphics.getHeight()/2 - 27*scale, 100*scale, "left")
        --love.graphics.rectangle('line', love.graphics.getWidth()/2 - 50*scale, love.graphics.getHeight()/2 - 30*scale, 100*scale, 50)

    end
end
