hoverPanel = {}
hoverPanel.leftX = -56
hoverPanel.rightX = 64
hoverPanel.y = 0
hoverPanel.sprite = sprites.ui.itemHoverPanel
hoverPanel.visible = false
hoverPanel.text = ""

function hoverPanel:update(dt)
    if heldItemId > 0 then
        self.visible = false
        return nil
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

        if hoverItemType == 2 then
            love.graphics.draw(self.sprite, self.leftX, self.y, nil, nil, nil, self.sprite:getWidth()/2, self.sprite:getHeight()/2)
            --love.graphics.setFont(fonts.itemHover)
            --love.graphics.printf(self.text, self.leftX - 26, self.y - 36, 152, "left")
        end

    end
end

function hoverPanel:drawText()

    setWhite()
    if self.visible then

        if hoverItemType == 2 then
            love.graphics.setFont(fonts.itemHover)
            local xPos = love.graphics.getWidth()/2 - (98.8 * scale)
            local yPos = love.graphics.getHeight()/2 - (37 * scale)
            love.graphics.printf(self.text, xPos, yPos, 76 * scale, "left")
        end

    end

end
