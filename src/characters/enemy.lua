enemies = {}

function spawnEnemy(type, tileX, tileY)
    local enemy = {}
    enemy.type = type
    enemy.x = tileX*16 + 8
    enemy.y = tileY*16 + 8
    enemy.sprite = sprites.characters.skull
    enemy.radius = 4
    enemy.speed = 30
    enemy.health = 100
    enemy.radius = 6
    enemy.dir = vector(0,1) * enemy.speed

    enemy.grid = anim8.newGrid(16, 16, enemy.sprite:getWidth(), enemy.sprite:getHeight())
    enemy.anim = anim8.newAnimation(enemy.grid('1-2', 1), 0.3)

    if type == 'skull' then
        enemy.sprite = sprites.characters.skull
    end

    function enemy:update(dt)
        self.x = self.x + self.dir.x * dt
        self.y = self.y + self.dir.y * dt

        self.anim:update(dt)
    end

    function enemy:draw()
        setWhite()
        self.anim:draw(self.sprite, self.x, self.y, nil, nil, nil, 8, 8)
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
