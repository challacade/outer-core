sprites = {}
sprites.maps = {}
sprites.maps.level1 = love.graphics.newImage('sprites/maps/level1.png')
sprites.maps.level2 = love.graphics.newImage('sprites/maps/level2.png')
sprites.maps.level3 = love.graphics.newImage('sprites/maps/level3.png')
sprites.maps.level4 = love.graphics.newImage('sprites/maps/level4.png')
sprites.maps.level5 = love.graphics.newImage('sprites/maps/level5.png')
sprites.characters = {}
sprites.characters.unit = love.graphics.newImage('sprites/characters/unit.png')
sprites.characters.skull = love.graphics.newImage('sprites/characters/skull.png')
sprites.attacks = {}
sprites.attacks.laser = love.graphics.newImage('sprites/attacks/laser.png')
sprites.effects = {}
sprites.effects.enemyDestroy = love.graphics.newImage('sprites/effects/enemyDestroy.png')
sprites.effects.stars = love.graphics.newImage('sprites/effects/stars.png')
sprites.effects.stars2 = love.graphics.newImage('sprites/effects/stars2.png')
sprites.ui = {}
sprites.ui.planet = love.graphics.newImage('sprites/ui/planet.png')
sprites.ui.arrowHead = love.graphics.newImage('sprites/ui/arrowHead.png')
sprites.ui.sidePanel = love.graphics.newImage('sprites/ui/sidePanel.png')
sprites.ui.coreHoverPanel = love.graphics.newImage('sprites/ui/coreHoverPanel.png')
sprites.ui.coreDiceIcons = love.graphics.newImage('sprites/ui/diceIcons.png')
sprites.ui.itemHoverPanel = love.graphics.newImage('sprites/ui/itemHoverPanel.png')
sprites.ui.dice = love.graphics.newImage('sprites/ui/dice.png')
sprites.ui.wrench = love.graphics.newImage('sprites/ui/wrench.png')
sprites.ui.battery = love.graphics.newImage('sprites/ui/battery.png')

fonts = {}
fonts.debug = love.graphics.newFont("fonts/vt323/VT323-Regular.ttf", 15*scale)
fonts.coreHover = love.graphics.newFont("fonts/kenney-pixel/Kenney-Pixel.ttf", 10*scale)
fonts.coreHoverTitle = love.graphics.newFont("fonts/kenney-pixel/Kenney-Pixel.ttf", 12*scale)
fonts.itemHover = love.graphics.newFont("fonts/kenney-pixel/Kenney-Pixel.ttf", 10*scale)
fonts.levelComplete = love.graphics.newFont("fonts/kenney-pixel/Kenney-Pixel.ttf", 26*scale)
fonts.title = love.graphics.newFont("fonts/vt323/VT323-Regular.ttf", 36*scale)
fonts.clickToBegin = love.graphics.newFont("fonts/kenney-pixel/Kenney-Pixel.ttf", 16*scale)
fonts.pickLevel = love.graphics.newFont("fonts/kenney-pixel/Kenney-Pixel.ttf", 16*scale)
fonts.pickLevel2 = love.graphics.newFont("fonts/kenney-pixel/Kenney-Pixel.ttf", 12*scale)
fonts.levelTitle = love.graphics.newFont("fonts/kenney-pixel/Kenney-Pixel.ttf", 22*scale)

sounds = {}