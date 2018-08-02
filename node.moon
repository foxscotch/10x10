vector = require 'vendor.hump.vector'


eventAll = (event) ->
    name = event .. 'All'
    (self, ...) ->
        self[event](self, ...)
        for v in *@children do
            v[name](v, ...)


class Node
    new: (game, parent, pos, size) =>
        @game = game

        if parent
            @parent = parent
            @parent\addChild(self)
        else
            @parent = nil

        @children = {}
        @pos = pos or vector.new(0, 0)  -- hump.vector
        @size = size or w: 0, h: 0, r: 0

    delete: =>
        if @parent
            @parent\removeChild(self)

    addChild: (node) =>
        table.insert(@children, node)

    removeChild: (node) =>
        for i,n in ipairs(@children) do
            if n == node
                table.remove(@children, i)
                return

    setPos: (vect) =>
        @pos = vector.new(vect.x, vect.y)

    getCenter: =>
        x = @pos.x + @size.w/2
        y = @pos.y + @size.h/2
        return vector.new(x, y)

    getBounds: =>
        xmin = @pos.x
        xmax = @pos.x + @size.w - 1
        ymin = @pos.y
        ymax = @pos.y + @size.h - 1
        return {xmin, xmax, ymin, ymax}

    pointWithin: (x, y) =>
        if x == nil
            x = love.mouse.getX()
        if y == nil
            y = love.mouse.getY()

        bounds = @getBounds()
        withinX = x >= bounds[1] and x <= bounds[2]
        withinY = y >= bounds[3] and y <= bounds[4]
        return withinX and withinY

    -- Define stubs for relevant callbacks

    update: =>
    draw: =>
    quit: =>
    resize: =>
    focus: =>
    mousefocus: =>
    wheelmoved: =>
    mousepressed: =>
    mousereleased: =>
    mousemoved: =>
    touchmoved: =>
    touchpressed: =>
    touchreleased: =>
    keypressed: =>
    keyreleased: =>


    -- The following functions should not be overwritten in subclasses. They call
    -- the event handlers for themselves and all children.

    updateAll:        eventAll 'update'
    drawAll:          eventAll 'draw'
    quitAll:          eventAll 'quit'
    resizeAll:        eventAll 'resize'
    focusAll:         eventAll 'focus'
    mousefocusAll:    eventAll 'mousefocus'
    wheelmovedAll:    eventAll 'wheelmoved'
    mousepressedAll:  eventAll 'mousepressed'
    mousereleasedAll: eventAll 'mousereleased'
    mousemovedAll:    eventAll 'mousemoved'
    touchmovedAll:    eventAll 'touchmoved'
    touchpressedAll:  eventAll 'touchpressed'
    touchreleasedAll: eventAll 'touchreleased'
    keypressedAll:    eventAll 'keypressed'
    keyreleasedAll:   eventAll 'keyreleased'


return Node
