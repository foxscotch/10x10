local Block = require('block')
local colors = require('colors')
local Grid = require('grid')
local Poly = require('poly')

local deep = require('ext.deep')
local Timer = require('ext.hump.timer')
local vector = require('ext.hump.vector')


-- Create a *global* Game variable, so other modules need not require() it.
Game = {}


-- Game Constants --

-- Debug property; controls whether debugDisplay() calls are printed.
Game.DEBUG = false


-- Game Variables --

Game.startTime = love.timer.getTime()
Game.theme = colors.Dark
Game.timer = Timer.new()


function Game.init()
    g = Grid(nil, vector.new(100, 100))
    gw, gh = g.size.w, g.size.h
    ww, wh = love.window.getMode()
    g:setPos(vector.new(ww/2-gw/2, wh/2-gh/2))

    p = Poly()
end


-- LÖVE callbacks --

function Game.update(dt)
    g:updateAll(dt)
    Game.timer:update(dt)
end

function Game.draw()
    love.graphics.setBackgroundColor(Game.theme['bg'])

    Game.debugDisplay(string.format('fps: %i', love.timer.getFPS()))
    Game.debugDisplay(string.format('time: %.2f', love.timer.getTime() - Game.startTime))

    g:drawAll(dt)

    deep.execute()
    Game.printDebug()
end

function Game.mousepressed(x, y, button, istouch)
    g:mousepressedAll(x, y, button, istouch)
end

function Game.mousereleased(x, y, button, istouch)
    g:mousereleasedAll(x, y, button, istouch)
end

function Game.mousemoved(x, y, dx, dy, istouch)
    g:mousemovedAll(x, y, istouch)
end


-- Utility functions --

Game.debugStrings = {}

function Game.debugDisplay(str)
    table.insert(Game.debugStrings, str)
end

function Game.printDebug()
    if Game.DEBUG then
        position = 2
        for i,str in ipairs(Game.debugStrings) do
            love.graphics.setColor(colors.toFloats({255, 255, 255}))
            love.graphics.print(str, 2, position)
            position = position + 15
        end
        Game.debugStrings = {}
    end
end


return Game
