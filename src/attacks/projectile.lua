projectiles = {}

function spawnProjectile(type, x, y, dir, color)
    local projectile = {}
    projectile.type = type
    projectile.x = x
    projectile.y = y
    projectile.dir = dir:normalized()
    projectile.rot = 1
    projectile.sprite = sprites.attacks.laser
    projectile.radius = 4
    projectile.speed = 270
    projectile.power = 60
    projectile.timer = 5
    projectile.color = "white"
    if color then projectile.color = color end

    if type == 'laser' then
        projectile.rot = math.atan2(projectile.dir.y, projectile.dir.x)
    end

    if type == 'shock' then
        projectile.radius = 30
        projectile.speed = 0
        projectile.timer = 0.3
        projectile.power = 80
        spawnBlast(x, y, 40, "white", 0.25)
    end

    projectile.dir = projectile.dir * projectile.speed

    function projectile:update(dt)
        self.x = self.x + self.dir.x * dt
        self.y = self.y + self.dir.y * dt

        self.timer = self.timer - dt
        if self.timer < 0 then
            self.dead = true
        end
    end

    function projectile:draw()
        if self.type == 'shock' then return end
        setColorFromString(self.color)
        love.graphics.draw(self.sprite, self.x, self.y, self.rot, nil, nil, self.sprite:getWidth()/2, self.sprite:getHeight()/2)
    end

    table.insert(projectiles, projectile)
end

function projectiles:update(dt)
    for _,p in ipairs(projectiles) do
        p:update(dt)
    end
end

function projectiles:draw()
    for _,p in ipairs(projectiles) do
        p:draw()
    end
end

function removeDeadProjectiles()
    local i = #projectiles
    while i > 0 do
        if projectiles[i].dead then
            table.remove(projectiles, i)
        end
        i = i - 1
    end
end
