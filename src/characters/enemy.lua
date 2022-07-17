enemies = {}

function spawnEnemy(type, tileX, tileY)
    local enemy = {}
    enemy.type = type
    enemy.x = tileX*16 + 8
    enemy.y = tileY*16 + 8
    enemy.sprite = sprites.characters.skull
    enemy.radius = 3
    enemy.speed = 30
    enemy.maxHealth = 100
    enemy.health = 100
    enemy.radius = 6

    enemy.grid = anim8.newGrid(16, 16, enemy.sprite:getWidth(), enemy.sprite:getHeight())
    enemy.anim = anim8.newAnimation(enemy.grid('1-2', 1), 0.3)

    if type == 'skull' then
        enemy.sprite = sprites.characters.skull
    end

    if type == 'fastSkull' then
        enemy.sprite = sprites.characters.skull
        enemy.speed = 60
    end

    if type == 'squid' then
        enemy.sprite = sprites.characters.squid
        enemy.maxHealth = 150
        enemy.health = 150
    end

    if type == 'fastSquid' then
        enemy.sprite = sprites.characters.squid
        enemy.maxHealth = 150
        enemy.health = 150
        enemy.speed = 60
    end

    enemy.dir = vector(0,1) * enemy.speed

    function enemy:update(dt)
        if manager.dead ~= true then
            self.x = self.x + self.dir.x * dt
            self.y = self.y + self.dir.y * dt
        end

        -- Check for projectile collisions
        for _,p in ipairs(projectiles) do
            if (p.radius + self.radius) > distanceBetween(p.x, p.y, self.x, self.y) then
                p.dead = true
                self.health = self.health - p.power
            end
        end

        -- Check for guides (direction changes)
        for _,g in ipairs(guides) do
            if (8 + g.radius) > distanceBetween(g.x, g.y, self.x, self.y) then
                if g.goal then
                    spawnBlast(self.x, self.y, 90, "red", 0.5)
                    manager.dead = true
                    removeGuides()
                end
                self.dir = g.dir * self.speed
            end
        end

        if self.health <= 0 then
            self.dead = true
            spawnBlast(self.x, self.y, 12, "red", 0.3)
            particleEvent('enemyDestroy', self.x, self.y, arg)
            dj.play(sounds.hit, "static", "effect")
        end

        self.anim:update(dt)
    end

    function enemy:draw()
        setWhite()
        self.anim:draw(self.sprite, self.x, self.y, nil, nil, nil, 8, 8)

        if self.health < self.maxHealth then
            love.graphics.setLineWidth(0.25)
            setColor(211, 48, 48)
            love.graphics.rectangle('fill', self.x - 5, self.y - 10.5, (self.health / self.maxHealth) * 10, 1.8)
            setWhite()
            love.graphics.rectangle('line', self.x - 5, self.y - 10.5, 10, 1.8)
        end
    end

    table.insert(enemies, enemy)
end

function enemies:update(dt)
    for _,e in ipairs(enemies) do
        e:update(dt)
    end
end

function enemies:draw()
    for _,e in ipairs(enemies) do
        e:draw()
    end
end

function removeDeadEnemies()
    local i = #enemies
    while i > 0 do
        if enemies[i].dead then
            table.remove(enemies, i)
        end
        i = i - 1
    end
end

function removeAllEnemies()
    local i = #enemies
    while i > 0 do
        table.remove(enemies, i)
        i = i - 1
    end
end
