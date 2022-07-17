-- This accounts for both side-panels
sidePanel = {}
sidePanel.x1 = 128
sidePanel.x2 = -112
sidePanel.y = 0
sidePanel.sprite = sprites.ui.sidePanel
sidePanel.top = -64 - 18 -- the extra 20 is because it's index 1 rather than 0

function sidePanel:update(dt)
    hoverItemType = -1
    hoverItemId = -1
    hoverItemSprite = nil

    local mx, my = cam:mousePosition()    
    if mx > sidePanel.x1 - 7 and mx < sidePanel.x1 + 7 then
        local ind = self:getHoverIndex(1)
        if ind > 0 then
            hoverItemType = 1 -- Core
            hoverItemIndex = ind
            hoverItemId = myCores[ind]
            hoverItemSprite = coreData[myCores[ind]][8] -- Get the core sprite
            --d1 = "hovering " .. ind
        end
    end
    if mx > sidePanel.x2 - 7 and mx < sidePanel.x2 + 7 then
        local ind = self:getHoverIndex(2)
        if ind > 0 and myItems[ind] > 0 then
            hoverItemType = 2 -- Item
            hoverItemIndex = ind
            hoverItemId = myItems[ind]
            hoverItemSprite = itemData[myItems[ind]][2] -- Get the item sprite
            --d1 = "hovering " .. ind
        end
    end
end

function sidePanel:getHoverIndex(side)
    local list = myCores
    local mx, my = cam:mousePosition()
    if side == 2 then list = myItems end
    for i,p in ipairs(list) do
        local center = sidePanel.top + i*18
        local diff = my - center
        if i > 0 and math.abs(diff) <= 9 then
            return i
        end
    end
    return -1
end

function sidePanel:draw()
    setColor(220, 220, 220, 1)
    love.graphics.draw(self.sprite, self.x1, self.y, nil, nil, nil, self.sprite:getWidth()/2, self.sprite:getHeight()/2)
    love.graphics.draw(self.sprite, self.x2, self.y, nil, nil, nil, self.sprite:getWidth()/2, self.sprite:getHeight()/2)

    -- Draw cores
    for i,c in ipairs(myCores) do
        setWhite()
        if myCoresEquipped[i] then
            setColorFromString(myCoresEquipped[i])
        end
        local spr = coreData[c][8]
        love.graphics.draw(spr, sidePanel.x1, sidePanel.top + i*18, nil, nil, nil, spr:getWidth()/2, spr:getHeight()/2)
    end

    -- Draw items
    for i,c in ipairs(myItems) do
        if c > 0 then
            setWhite()
            local spr = itemData[c][2]
            love.graphics.draw(spr, sidePanel.x2, sidePanel.top + i*18, nil, nil, nil, spr:getWidth()/2, spr:getHeight()/2)
        end
    end
end
