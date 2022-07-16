guides = {}

function spawnGuide(tileX, tileY, dir)
    local guide = {}
    guide.x = tileX*16 + 8
    guide.y = tileY*16 + 8
    guide.dir = dir
    guide.radius = 8

    table.insert(guides, guide)
end

function removeGuides()
    local i = #guides
    while i > 0 do
        table.remove(guides, i)
        i = i - 1
    end
end
