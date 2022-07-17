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
    unit.dir = vector(0, 1)
    unit.moveSpeed = 60
    unit.rollSpeed = 1.5
    unit.batterySpeed = 0.75
    unit.rollTimer = 0.5
    unit.coreId = 0
    unit.animTimer1 = 0
    unit.animTimer2 = 0
    unit.wrenchTimer = 0
    unit.batteryTimer = 0

    unit.offDir = vector(1,0)
    unit.offset = 0
    
    -- 0: Standby
    -- 1: Active
    -- 1.5: Attacking
    -- 2: Walking
    -- 3: Malfunctioning
    unit.state = 1
    unit.awaitingOrders = false

    if id == 1 then
        unit.color = "pink"
    elseif id == 2 then
        unit.color = "blue"
    elseif id == 3 then
        unit.color = "yellow"
    end

    function unit:matchRotation()
        self.rot = math.atan2(self.dir.y, self.dir.x)
    end

    unit:matchRotation()

    function unit:setActive()
        if self.state == 2 then return end
        self.state = 1

        local newTime = self.rollSpeed
        if self.batteryTimer > 0 then newTime = self.batterySpeed end
        self.rollTimer = newTime
    end

    function unit:update(dt)

        if self.coreId == 0 then -- no core equipped
            return nil
        end

        if self.wrenchTimer > 0 then
            self.wrenchTimer = self.wrenchTimer - dt
        end

        if self.batteryTimer > 0 then
            self.batteryTimer = self.batteryTimer - dt
        end

        if self.state == 1 then
            self.rollTimer = self.rollTimer - dt
            if self.rollTimer < 0 then
                if #enemies > 0 then
                    self:rollAttack()
                else
                    self:setActive()
                end
            end
        end

        if self.state == 2 then
            self.dir = getFromToVector(self.x, self.y, self.destX, self.destY) * self.moveSpeed
            self:matchRotation()
            self.x = self.x + self.dir.x * dt
            self.y = self.y + self.dir.y * dt

            if distanceBetween(self.x, self.y, self.destX, self.destY) < 1 then
                self.x = self.destX
                self.y = self.destY
                self.tileX = self.destTileX
                self.tileY = self.destTileY
                self.state = 1 -- need to manually set for walking
                unit:setActive()
            end
        end

        if self.state == 3 then
            self.animTimer1 = self.animTimer1 - dt
            self.animTimer2 = self.animTimer2 - dt

            if self.animTimer2 < 0 then
                self.animTimer2 = 0.05
                self.offDir = self.offDir:rotated(math.pi)
            end

            if self.animTimer1 < 0 then
                self.animTimer1 = 0
                self.animTimer2 = 0
                self.offset = 0
                self:setActive()
            end
        end
    end

    function unit:draw()
        if unit.coreId > 0 then
            setColorFromString(self.color)
        else
            setDullColorFromString(self.color)
        end

        local offX = self.offDir.x * self.offset
        local offY = self.offDir.y * self.offset
        love.graphics.draw(self.sprite, self.x + offX, self.y + offY, self.rot, nil, nil, self.sprite:getWidth()/2, self.sprite:getHeight()/2)
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

    function unit:rollAttack()
        self.state = 1.1
        local result = math.random(1,6)
        local attackName = coreData[self.coreId][result]
        if attackName == "aim" then
            self:aimedShot()
            dj.play(sounds.laser, "static", "effect")
        elseif attackName == "around" then
            self:aroundShot()
            dj.play(sounds.laser, "static", "effect")
        elseif attackName == "doubleSpin" then
            self:aroundShot(true)
            dj.play(sounds.laser, "static", "effect")
        elseif attackName == "shock" then
            self:proximityShock()
            dj.play(sounds.shock, "static", "effect")
        elseif attackName == "shotgun" then
            self:aimedShot(true)
            dj.play(sounds.laser, "static", "effect")
        elseif attackName == "double" then
            self:aimedShot(false, true)
            dj.play(sounds.laser, "static", "effect")
        elseif attackName == "mal" then
            self:malfunction()
            dj.play(sounds.error, "static", "effect")
        end
    end

    function unit:aimedShot(shotgun, double)
        self.state = 1.5

        local shotX = 0
        local shotY = 0
        local tempDist = 999999

        for _,e in ipairs(enemies) do
            local dist = distanceBetween(e.x, e.y, self.x, self.y)
            if dist < tempDist then
                tempDist = dist
                shotX = e.x
                shotY = e.y
            end
        end

        self.dir = getFromToVector(self.x, self.y, shotX, shotY)
        self:matchRotation()
        
        if double then
            local perp = self.dir:rotated(math.pi/2)*4
            spawnProjectile('laser', self.x + perp.x, self.y + perp.y, self.dir, self.color)
            spawnProjectile('laser', self.x - perp.x, self.y - perp.y, self.dir, self.color)
        else
            spawnProjectile('laser', self.x, self.y, self.dir, self.color)
        end
        
        unit:kickbackToActive()
        
        if shotgun then
            spawnProjectile('laser', self.x, self.y, self.dir:rotated(math.pi/10), self.color)
            spawnProjectile('laser', self.x, self.y, self.dir:rotated(math.pi/-10), self.color)
        end
    end

    function unit:aroundShot(double)
        self.state = 1.5

        spawnProjectile('laser', self.x, self.y, vector(1, 0), self.color)
        spawnProjectile('laser', self.x, self.y, vector(1, 1), self.color)
        spawnProjectile('laser', self.x, self.y, vector(0, 1), self.color)
        spawnProjectile('laser', self.x, self.y, vector(-1, 1), self.color)
        spawnProjectile('laser', self.x, self.y, vector(-1, 0), self.color)
        spawnProjectile('laser', self.x, self.y, vector(-1, -1), self.color)
        spawnProjectile('laser', self.x, self.y, vector(0, -1), self.color)
        spawnProjectile('laser', self.x, self.y, vector(1, -1), self.color)

        if double then
            spawnProjectile('laser', self.x, self.y, vector(1, 0):rotated(math.pi/8), self.color)
            spawnProjectile('laser', self.x, self.y, vector(1, 1):rotated(math.pi/8), self.color)
            spawnProjectile('laser', self.x, self.y, vector(0, 1):rotated(math.pi/8), self.color)
            spawnProjectile('laser', self.x, self.y, vector(-1, 1):rotated(math.pi/8), self.color)
            spawnProjectile('laser', self.x, self.y, vector(-1, 0):rotated(math.pi/8), self.color)
            spawnProjectile('laser', self.x, self.y, vector(-1, -1):rotated(math.pi/8), self.color)
            spawnProjectile('laser', self.x, self.y, vector(0, -1):rotated(math.pi/8), self.color)
            spawnProjectile('laser', self.x, self.y, vector(1, -1):rotated(math.pi/8), self.color)
        end

        local destRot = self.rot + math.pi*2
        flux.to(self, 0.35, {rot = destRot}):ease("quadinout"):oncomplete(function() self:setActive() end)
    end

    function unit:proximityShock()
        self.state = 1.5

        spawnProjectile('shock', self.x, self.y, vector(1, 0), self.color)

        local destRot = self.rot + math.pi*2
        flux.to(self, 0.35, {rot = destRot}):ease("quadinout"):oncomplete(function() self:setActive() end)
    end

    function unit:kickbackToActive()
        self.offDir = self.dir:rotated(math.pi)
        flux.to(self, 0.07, {offset = 4}):ease("linear"):oncomplete(
            function()
                flux.to(self, 0.2, {offset = 0}):ease("linear"):oncomplete(
                    function()
                        self:setActive()
                    end
                )
            end
        )
    end

    function unit:malfunction()
        if self.wrenchTimer > 0 then
            self:aimedShot()
            return nil
        end
        self.state = 3
        self.animTimer1 = 0.5
        self.animTimer2 = 0.05
        self.offDir = self.dir:rotated(math.pi/2):normalized()
        self.offset = 0.6
    end

    function unit:applyWrench()
        self.wrenchTimer = 15
    end

    function unit:applyBattery()
        self.batteryTimer = 10
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
        --love.graphics.circle('fill', u.x, u.y, 30)
    end
end

function units:remove()
    local i = #units
    while i > 0 do
        table.remove(units, i)
        i = i - 1
    end
end
