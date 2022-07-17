hoverPanel = {}
hoverPanel.leftX = -56
hoverPanel.rightX = 72
hoverPanel.y = 0
hoverPanel.sprite = sprites.ui.itemHoverPanel
hoverPanel.visible = false
hoverPanel.text = ""
hoverPanel.core = nil

function hoverPanel:update(dt)
    if heldItemId > 0 or tutorial.active then
        self.visible = false
        return nil
    end

    -- Core
    if hoverItemType == 1 then
        self.visible = true
        self.sprite = sprites.ui.coreHoverPanel
        self.text = ""
        self.core = coreData[hoverItemId]
    end

    -- Items
    if hoverItemType == 2 then
        self.visible = true
        self.sprite = sprites.ui.itemHoverPanel
        self.text = itemData[hoverItemId][3]
    end
end

function hoverPanel:draw()
    setWhite()
    if self.visible then

        if hoverItemType == 1 then
            love.graphics.draw(self.sprite, self.rightX, self.y, nil, nil, nil, self.sprite:getWidth()/2, self.sprite:getHeight()/2)
            love.graphics.draw(sprites.ui.coreDiceIcons, self.rightX, self.y, nil, nil, nil, sprites.ui.coreDiceIcons:getWidth()/2, sprites.ui.coreDiceIcons:getHeight()/2)
        end

        if hoverItemType == 2 then
            love.graphics.draw(self.sprite, self.leftX, self.y, nil, nil, nil, self.sprite:getWidth()/2, self.sprite:getHeight()/2)
        end

    end
end

function hoverPanel:drawText()

    setWhite()
    if self.visible then

        if hoverItemType == 1 then
            local xPos = love.graphics.getWidth()/2 + (30 * scale)
            local yPos = love.graphics.getHeight()/2 - (54 * scale)
            --love.graphics.rectangle('line', xPos, yPos, 68*scale, 20)
            love.graphics.setFont(fonts.coreHoverTitle)
            love.graphics.printf(self.core[7], xPos, yPos, 68 * scale, "center")

            local xPos = love.graphics.getWidth()/2 + (46 * scale)
            local yPos = love.graphics.getHeight()/2 - (52 * scale)
            --love.graphics.rectangle('line', xPos, yPos, 54*scale, 20)
            
            love.graphics.setFont(fonts.coreHover)
            for i=1,6 do
                setWhite()
                local labelText = ""
                local faceString = self.core[i]
                if faceString == "aim" then
                    labelText = "Snipe"
                elseif faceString == "around" then
                    labelText = "Spin Shot"
                elseif faceString == "shock" then
                    labelText = "Proximity Shock"
                elseif faceString == "shotgun" then
                    labelText = "Shotgun"
                elseif faceString == "double" then
                    labelText = "Double Snipe"
                elseif faceString == "doubleSpin" then
                    labelText = "Double Spin Shot"
                elseif faceString == "mal" then
                    labelText = "Malfunction"
                    setColor(198, 59, 59)
                end

                love.graphics.printf(labelText, xPos, yPos + (i * 16 * scale), 54*scale, "left")
            end
        end

        if hoverItemType == 2 then
            love.graphics.setFont(fonts.itemHover)
            local xPos = love.graphics.getWidth()/2 - (98.8 * scale)
            local yPos = love.graphics.getHeight()/2 - (37 * scale)
            love.graphics.printf(self.text, xPos, yPos, 76 * scale, "left")
        end

    end

end
