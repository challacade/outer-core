function particleEvent(type, x, y, arg)

    if type == "enemyDestroy" then
        spawnParticle("enemyDestroy", x, y, 1)
        spawnParticle("enemyDestroy", x, y, 1)
        --spawnParticle("enemyDestroy", x, y, 1)

        spawnParticle("enemyDestroy", x, y, 2)
        spawnParticle("enemyDestroy", x, y, 2)
        --spawnParticle("enemyDestroy", x, y, 2)

        spawnParticle("enemyDestroy", x, y, 3)
        spawnParticle("enemyDestroy", x, y, 3)
        --spawnParticle("enemyDestroy", x, y, 3)

        spawnParticle("enemyDestroy", x, y, 4)
        spawnParticle("enemyDestroy", x, y, 4)
        --spawnParticle("enemyDestroy", x, y, 4)
    end

end