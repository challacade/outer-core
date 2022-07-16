units = {}

function spawnUnit(id, tileX, tileY)
    local unit = {}
    unit.id = id
    unit.x = tileX*16 + 8
    unit.y = tileY*16 + 8
    unit.tileX = tileX
    unit.tileY = tileY
    unit.destX = 0
    unit.destY = 0
    unit.destTileX = 0
    unit.destTileY = 0
    unit.sprite = sprites.characters.unit
    unit.color = "white"
    unit.rot = math.random(-3, 3)
    unit.speed = 60
    
    -- 0: Standby
    -- 1: Active
    -- 2: Walking
    unit.state = 1
    unit.awaitingOrders = false

    if id == 1 then
        unit.color = "pink"
    elseif id == 2 then
        unit.color = "blue"
    elseif id == 3 then
        unit.color = "yellow"
    end

    function unit:update(dt)
        if self.state == 2 then
            self.dir = getFromToVector(self.x, self.y, self.destX, self.destY) * self.speed
            self.rot = math.atan2(self.dir.y, self.dir.x)
            self.x = self.x + self.dir.x * dt
            self.y = self.y + self.dir.y * dt

            if distanceBetween(self.x, self.y, self.destX, self.destY) < 1 then
                self.x = self.destX
                self.y = self.destY
                self.tileX = self.destTileX
                self.tileY = self.destTileY
                self.state = 1
            end
        end
    end

    function unit:draw()
        setColorFromString(self.color)
        love.graphics.draw(self.sprite, self.x, self.y, self.rot, nil, nil, self.sprite:getWidth()/2, self.sprite:getHeight()/2)
    end

    function unit:walkTo(newTileX, newTileY)
        self.awaitingOrders = false
        selectedUnitId = -1
        self.destX = newTileX*16 + 8
        self.destY = newTileY*16 + 8
        self.destTileX = newTileX
        self.destTileY = newTileY
        self.state = 2
    end

    table.insert(units, unit)
end

function units:update(dt)
    for _,u in ipairs(units) do
        u:update(dt)
    end
end

function units:draw()
    for _,u in ipairs(units) do
        u:draw()
    end
end
