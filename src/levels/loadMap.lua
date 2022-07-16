function loadMap(mapName, destX, destY)
    --destroyAll()

    loadedMap = mapName
    gameMap = sti("maps/" .. mapName .. ".lua")

    if gameMap.layers["Walls"] then
        for i, obj in pairs(gameMap.layers["Walls"].objects) do
            --spawnWall(obj.x, obj.y, obj.width, obj.height, obj.name, obj.type)
        end
    end

end