function requireAll()

    -- Load assets, resources, data
    require("src/startup/resources")

    require("src/ui/pause")

    require("src/characters/unit")
    
    require("src/utilities/cam")
    require("src/utilities/debug")
    require("src/utilities/utils")

    require("src/update")
    require("src/draw")
    require("src/mouse")

end