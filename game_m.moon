Timer = require 'ext.hump.timer'
deep = require 'ext.deep'
vector = require 'ext.hump.vector'

Node = require 'node_m'
Grid = require 'grid_m'
Poly = require 'poly_m'
colors = require 'colors_m'
pieces = require 'definitions.classic_m'


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
        @grid\setPos vector.new(ww/2-gw/2, wh/2-gh/2)

        Poly @, @main, vector.new(100, 30), pieces.one
        Poly @, @main, vector.new(100, 60), pieces.twoH
        Poly @, @main, vector.new(100, 90), pieces.thrH
        Poly @, @main, vector.new(100, 120), pieces.fouH
        Poly @, @main, vector.new(100, 150), pieces.fivH
        Poly @, @main, vector.new(100, 180), pieces.ssm
        Poly @, @main, vector.new(100, 240), pieces.slg
        Poly @, @main, vector.new(100, 330), pieces.csmNW
        Poly @, @main, vector.new(100, 390), pieces.clgNW


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
                love.graphics.setColor colors.toFloats({255, 255, 255})
                love.graphics.print str, 2, position
                position += 15
            @debugStrings = {}


return Game
