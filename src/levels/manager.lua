manager = {}
manager.spawnTimer = 1

function manager:update(dt)
    self.spawnTimer = self.spawnTimer - dt
    if self.spawnTimer < 0 then
        self.spawnTimer = 2
        spawnEnemy('skull', 0, -4)
    end
end
