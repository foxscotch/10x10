local Block = require('blocks')
local colors = require('colors')
local Grid = require('grid')

local deep = require('ext.deep')
local Timer = require('ext.hump.timer')
local vector = require('ext.hump.vector')


-- Create a *global* Game variable, so other modules need not require() it.
Game = {}


-- Game Constants --

-- Debug property; controls whether debugDisplay() calls are printed.
Game.DEBUG = false


-- Game Variables --

Game.nodes = {}
Game.startTime = love.timer.getTime()
Game.theme = colors.Dark
Game.timer = Timer.new()


function Game.init()
    love.graphics.setBackgroundColor(Game.theme.bg)
    g = Grid(vector.new(100, 100), {w=10, h=10})
    gw, gh = g:getFullSize()
    ww, wh = love.window.getMode()
    g:setPos(vector.new(ww/2-gw/2, wh/2-gh/2))
end


-- LÖVE callbacks --

function Game.update(dt)
    for i,node in ipairs(Game.nodes) do
        node:update(dt)
    end
    Game.timer:update(dt)
end

function Game.draw()
    Game.debugDisplay(string.format('fps: %i', love.timer.getFPS()))
    Game.debugDisplay(string.format('time: %.2f', love.timer.getTime() - Game.startTime))

    for i,node in ipairs(Game.nodes) do
        node:draw(dt)
    end

    deep.execute()
    Game.printDebug()
end

function Game.mousepressed(x, y, button, istouch)
    for i,node in ipairs(Game.nodes) do
        node:mousepressed(x, y, button, istouch)
    end
end

function Game.mousereleased(x, y, button, istouch)
    for i,node in ipairs(Game.nodes) do
        node:mousereleased(x, y, button, istouch)
    end
end

function Game.mousemoved(x, y, dx, dy, istouch)
    for i,node in ipairs(Game.nodes) do
        node:mousemoved(x, y, istouch)
    end
end


-- Utility functions --

function Game.addNode(node)
    table.insert(Game.nodes, node)
end

function Game.removeNode(node)
    for i,n in ipairs(Game.nodes) do
        if n == node then
            table.remove(Game.nodes, i)
            return
        end
    end
end

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
