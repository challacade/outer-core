local function enemyDestroyInit(particle, x, y, args)

    particle.physics = world:newCircleCollider(x, y, 4)
    particle.physics:setFixedRotation(true)
    particle.physics:setCollisionClass("Ignore")
    particle.physics.parent = particle

    particle.sprite = sprites.effects.enemyDestroy
    particle.rot = math.random() * 3.14
    particle.rotSpeed = math.random() * 0.1 + 0.01

    particle.timer = 5
    particle.alpha = 1

    --[[if args then
        if args == 1 then
            particle.physics:setLinearVelocity(-80, -150)
        elseif args == 2 then
            particle.physics:setLinearVelocity(80, -150)
        elseif args == 3 then
            particle.physics:setLinearVelocity(-120, -60)
        elseif args == 4 then
            particle.physics:setLinearVelocity(120, -60)
        end
    end]]

    if args then
        if args == 1 then
            particle.physics:setLinearVelocity(math.random(0, -120), math.random(-120, -160))
        elseif args == 2 then
            particle.physics:setLinearVelocity(math.random(0, 120), math.random(-120, -160))
        elseif args == 3 then
            particle.physics:setLinearVelocity(math.random(0, -120), math.random(-60, -90))
        elseif args == 4 then
            particle.physics:setLinearVelocity(math.random(0, 120), math.random(-60, -90))
        end
    end

    function particle:update(dt)
        self.rot = self.rot + self.rotSpeed
        --self.alpha = self.alpha - dt
    end

    function particle:draw()
        love.graphics.setColor(1,1,1,self.alpha)
        local px, py = self.physics:getPosition()
        love.graphics.draw(self.sprite, px, py, self.rot, nil, nil, self.sprite:getWidth()/2, self.sprite:getHeight()/2)
        setWhite()
    end

    return particle

end

return enemyDestroyInit