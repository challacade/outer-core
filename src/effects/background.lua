background = {}
background.sprite = sprites.effects.stars
background.x = background.sprite:getWidth()/-2
background.y = background.sprite:getHeight()/-2

function background:update(dt)
    self.x = self.x - 20*dt
    if self.x < (self.sprite:getWidth()*-1 - background.sprite:getWidth()/2) then
        self.x = self.x + self.sprite:getWidth()
    end
end

function background:draw()
    setWhite()
    love.graphics.draw(self.sprite, self.x, self.y)
    love.graphics.draw(self.sprite, self.x + self.sprite:getWidth(), self.y)
end
