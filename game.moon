Timer = require 'vendor.hump.timer'
deep = require 'vendor.deep'
V = require 'vector'

Node = require 'node'
Grid = require 'grid'
Poly = require 'poly'
import PolyDefCollection from require 'selection'

colors = require 'colors'
pieces = require 'definitions'


class Game
    -- Debug property; controls whether debugDisplay() calls are printed.
    @DEBUG = false

    new: =>
        @startTime = love.timer.getTime!
        @theme = colors.Dark
        @timer = Timer.new!
        @debugStrings = {}
        @init!

    init: =>
        love.graphics.setBackgroundColor @theme.bg

        @main = Node @

        @grid = Grid @, @main
        gw, gh = @grid.size.w, @grid.size.h
        ww, wh = love.window.getMode!
        @grid\setPos V(ww/2-gw/2, wh/2-gh/2)

        pieces = PolyDefCollection(pieces)\filter('classic')

        Poly @, @main, V(100,  30), pieces\random!
        Poly @, @main, V(100, 150), pieces\random!
        Poly @, @main, V(100, 270), pieces\random!


    -- LÖVE callbacks --

    update: (dt) =>
        @main\updateAll(dt)
        @timer\update(dt)

    draw: =>
        time = love.timer.getTime! - @startTime
        @debugDisplay "fps: #{love.timer.getFPS()}"
        @debugDisplay string.format('time: %.2f', time)

        @main\drawAll()

        deep.execute()
        @printDebug()

    mousepressed: (x, y, button, istouch) =>
        @main\mousepressedAll x, y, button, istouch

    mousereleased: (x, y, button, istouch) =>
        @main\mousereleasedAll x, y, button, istouch

    mousemoved: (x, y, dx, dy, istouch) =>
        @main\mousemovedAll x, y, dx, dy, istouch


-- Utility functions --

    debugDisplay: (str) =>
        table.insert @debugStrings, str

    printDebug: () =>
        if @DEBUG
            position = 2
            for i,str in ipairs @debugStrings
                love.graphics.setColor colors.Color(255, 255, 255)
                love.graphics.print str, 2, position
                position += 15
            @debugStrings = {}


return Game
