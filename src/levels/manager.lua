manager = {}
manager.level = 1
manager.spawnTimer = 1
manager.spawnCount = 1
manager.state = 0
manager.mapSprite = nil

function manager:startLevel(num)
    gamestate = 1
    self.level = num
    self.spawnTimer = 1
    self.spawnCount = 1
    self.state = 0
    menu.levelToStart = 0
    removeGuides()
    units:remove()

    if num == 1 then
        spawnGuide(0, -1, vector(-1, 0))
        spawnGuide(-5, -2, vector(0, 1))
        spawnGuide(-4, 2, vector(1, 0))
        spawnGuide(5, 1, vector(0, 1))

        spawnUnit(1, -2, 3)
        spawnUnit(2, 2, 3)

        manager.mapSprite = sprites.maps.level1
    end

    if num == 2 then
        spawnGuide(0, -1, vector(-1, 0))
        spawnGuide(-5, -2, vector(0, 1))
        spawnGuide(-4, 2, vector(1, 0))
        spawnGuide(5, 1, vector(0, 1))

        spawnUnit(1, -2, 3)
        spawnUnit(2, 2, 3)

        manager.mapSprite = sprites.maps.level2
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
                spawnEnemy(spawn[1], 0, -4)
                self.spawnTimer = spawn[2]
                self.spawnCount = self.spawnCount + 1
            else
                self.state = 2
            end
        end

    end

    if self.state == 2 then
        if #enemies == 0 then
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
        setWhite()
        love.graphics.setFont(fonts.levelComplete)
        love.graphics.printf("Level Complete!", love.graphics.getWidth()/2 - 1000, love.graphics.getHeight()/2 - 18*scale, 2000, "center")
    end
end
