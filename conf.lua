function love.conf(t)
    t.identity = "outer-core"
    t.version  = "11.5"
    t.console  = false

    -- Native game resolution. Web builds (love.js) need an explicit canvas
    -- size since there is no desktop to query.
    t.window.width = 1920
    t.window.height = 1080
    t.window.title = "Outer Core"

    -- resizable=true here breaks love.js (canvas collapses to ~1x1). Desktop
    -- enables resizing imperatively via setMode in src/startup/gameStart.lua.
    t.window.resizable = false
    t.window.borderless = false
    t.window.fullscreen = false
    t.window.vsync = 1
end
