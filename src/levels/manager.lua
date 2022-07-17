manager = {}
manager.level = 1
manager.spawnTimer = 1
manager.spawnCount = 1
manager.state = 0
manager.mapSprite = nil
manager.dead = false
manager.spawnTileX = 0
manager.spawnTileY = 0

function manager:startLevel(num)
    gamestate = 1
    self.level = num
    self.spawnTimer = 2
    self.spawnCount = 1
    self.state = 0
    self.dead = false
    menu.levelToStart = 0
    removeGuides()
    units:remove()
    removeAllEnemies()
    myCoresEquipped = {0, 0, 0, 0, 0, 0, 0, 0, 0}

    if num == 1 then
        tutorial:reset()

        spawnGuide(0, -1, vector(-1, 0))
        spawnGuide(-5, -2, vector(0, 1))
        spawnGuide(-4, 2, vector(1, 0))
        spawnGuide(5, 1, vector(0, 1))
        spawnGuide(4, 4, vector(0, 1), true)

        spawnUnit(1, -2, 3)
        spawnUnit(2, 2, 3)

        self.spawnTileX = 0
        self.spawnTileY = -4

        myCores = {6, 4, 5, nil, nil, nil, nil, nil}
        myItems = {nil, nil, nil, nil, nil, nil, nil, nil}

        manager.mapSprite = sprites.maps.level1
    end

    if num == 2 then
        spawnGuide(-3, 2, vector(1, 0))
        spawnGuide(1, 1, vector(0, -1))
        spawnGuide(0, -3, vector(1, 0))
        spawnGuide(4, -2, vector(0, 1))
        spawnGuide(3, 4, vector(0, 1), true)

        spawnUnit(1, -5, 3)
        spawnUnit(2, 5, -4)

        self.spawnTileX = -3
        self.spawnTileY = -4

        myCores = {2, 8, 9, nil, nil, nil, nil, nil}
        myItems = {1, nil, nil, nil, nil, nil, nil, nil}

        manager.mapSprite = sprites.maps.level2
    end

    if num == 3 then
        spawnGuide(-4, 1, vector(1, 0))
        spawnGuide(3, 0, vector(0, -1))
        spawnGuide(2, -4, vector(1, 0))
        spawnGuide(6, -3, vector(0, 1))
        spawnGuide(5, 3, vector(-1, 0))
        spawnGuide(-5, 2, vector(0, 1))
        spawnGuide(-4, 4, vector(0, 1), true)

        spawnUnit(1, 4, 1)
        spawnUnit(2, -5, 1)
        spawnUnit(3, -1, -4)

        self.spawnTileX = -4
        self.spawnTileY = -4

        myCores = {4, 5, 7, 9, 2, nil, nil, nil}
        myItems = {1, 1, nil, nil, nil, nil, nil, nil}

        manager.mapSprite = sprites.maps.level3
    end

    if num == 4 then
        spawnGuide(4, -1, vector(-1, 0))
        spawnGuide(-5, -2, vector(0, 1))
        spawnGuide(-4, 2, vector(1, 0))
        spawnGuide(5, 1, vector(0, 1))
        spawnGuide(4, 4, vector(0, 1), true)

        spawnUnit(1, -1, -4)
        spawnUnit(2, 5, 0)
        spawnUnit(3, -5, 3)

        self.spawnTileX = 4
        self.spawnTileY = -4

        myCores = {10, 7, 9, 6, 3, nil, nil, nil}
        myItems = {1, 1, 2, nil, nil, nil, nil, nil}

        manager.mapSprite = sprites.maps.level4
    end

    if num == 5 then
        spawnGuide(4, -2, vector(-1, 0))
        spawnGuide(-5, -3, vector(0, 1))
        spawnGuide(-4, 0, vector(1, 0))
        spawnGuide(1, -1, vector(0, 1))
        spawnGuide(0, 2, vector(-1, 0))
        spawnGuide(-3, 1, vector(0, 1))
        spawnGuide(-2, 4, vector(0, 1), true)

        spawnUnit(1, -4, 1)
        spawnUnit(2, 2, 2)
        spawnUnit(3, 4, -1)

        self.spawnTileX = 4
        self.spawnTileY = -4

        myCores = {6, 5, 2, 8, 10, 9, 7, nil}
        myItems = {1, 1, 1, 2, 2, nil, nil, nil}

        manager.mapSprite = sprites.maps.level5
    end
end

function manager:update(dt)
    if gamestate == 0 then return nil end
    if self.state == 0 then
        for _,u in ipairs(units) do
            if u.coreId < 1 then
                return nil
            end
        end
        self.state = 1
    end

    if self.state == 1 then

        self.spawnTimer = self.spawnTimer - dt
        if self.spawnTimer < 0 then
            local spawn = waveData[manager.level][self.spawnCount]
            if spawn then
                spawnEnemy(spawn[1], self.spawnTileX, self.spawnTileY)
                self.spawnTimer = spawn[2]
                self.spawnCount = self.spawnCount + 1
            else
                self.state = 2
            end
        end

        if self.dead then
            self.state = 3
            self.spawnTimer = 2
        end

    end

    if self.state == 2 then
        if #enemies == 0 or self.dead then
            self.state = 3
            self.spawnTimer = 2
        end
    end

    if self.state == 3 then
        self.spawnTimer = self.spawnTimer - dt
        if self.spawnTimer < 0 then
            curtain:call()
            self.state = 4
        end
    end
end

function manager:draw()
    if self.state == 3 then
        local text = "Level Complete!"
        if self.dead then text = "Defeat" end
        setWhite()
        love.graphics.setFont(fonts.levelComplete)
        love.graphics.printf(text, love.graphics.getWidth()/2 - 1000, love.graphics.getHeight()/2 - 18*scale, 2000, "center")
    end
end
