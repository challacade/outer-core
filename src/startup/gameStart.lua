function gameStart()

    love.graphics.setBackgroundColor(0, 0, 0)

    -- Initialize all global variables for the game
    initGlobals()

    -- Make pixels scale!
    love.graphics.setDefaultFilter("nearest", "nearest")

    -- 3 parameters: fullscreen, width, height
    -- width and height are ignored if fullscreen is true
    setWindowSize(false, 1920, 1080)

    -- The game's graphics scale up, this method finds the right ratio
    setScale()

    vector = require "libraries/hump/vector"
    flux = require "libraries/flux/flux"
    require "libraries/tesound"
    require("libraries/show")

    anim8 = require("libraries/anim8/anim8")
    sti = require("libraries/Simple-Tiled-Implementation/sti")

    -- this windfield world is only used for particles
    local windfield = require("libraries/windfield")
    world = windfield.newWorld(0, 250, false)
    world:setQueryDebugDrawing(true)
    world:addCollisionClass('Ignore', {ignores = {'Ignore'}})

    require("src/startup/require")
    requireAll()

end

function setWindowSize(full, width, height)
    if full then
        love.window.setFullscreen(true)
        windowWidth = love.graphics.getWidth()
        windowHeight = love.graphics.getHeight()
    else
        if width == nil or height == nil then
            windowWidth = 1920
            windowHeight = 1080
        else
            windowWidth = width
            windowHeight = height
        end
        love.window.setMode( windowWidth, windowHeight, flags )
    end
end

function initGlobals()
    data = {} -- save data, will be loaded after game begins

    -- game state
    -- 0: main menu
    -- 1: gameplay
    gamestate = 1
    hoverTileX = -1
    hoverTileY = -1
    selectedUnitId = -1

    heldItemType = -1
    heldItemId = -1
    heldItemSprite = nil

    hoverItemType = -1
    hoverItemId = -1
    hoverItemSprite = nil
end

function setScale(input)
    scale = (7.25 / 1200) * windowHeight

    if cam then
        cam:zoomTo(scale)
    end
end