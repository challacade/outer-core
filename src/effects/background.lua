background = {}
background.sprite = sprites.effects.stars
background.sprite2 = sprites.effects.stars2
background.x = background.sprite:getWidth()/-2
background.x2 = background.sprite2:getWidth()/-2
background.y = background.sprite:getHeight()/-2

function background:update(dt)
    self.x = self.x - 20*dt
    self.x2 = self.x2 - 10*dt
    if self.x < (self.sprite:getWidth()*-1 - self.sprite:getWidth()/2) then
        self.x = self.x + self.sprite:getWidth()
    end
    if self.x2 < (self.sprite2:getWidth()*-1 - self.sprite2:getWidth()/2) then
        self.x2 = self.x2 + self.sprite2:getWidth()
    end
end

function background:draw()
    setWhite()
    love.graphics.draw(self.sprite2, self.x2, self.y)
    love.graphics.draw(self.sprite2, self.x2 + self.sprite:getWidth(), self.y)
    love.graphics.draw(self.sprite, self.x, self.y)
    love.graphics.draw(self.sprite, self.x + self.sprite:getWidth(), self.y)
end
