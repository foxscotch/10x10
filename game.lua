local Block = require('blocks')
local colors = require('colors')


local Timer = require('ext.hump.timer')
local vector = require('ext.hump.vector')


-- Create a *global* Game variable, so other modules need not require() it.
Game = {}


-- Game Constants --

-- Debug property; controls whether debugDisplay() calls are printed.
Game.DEBUG = false

-- Start with empty value, just to indicate that this property actually exists
Game.debugPosition = nil
Game.nodes = {}
Game.startTime = love.timer.getTime()
Game.theme = colors.Dark
Game.timer = Timer.new()


function Game.init()
    love.graphics.setBackgroundColor(colors.Dark.bg)

    Block(vector.new(100, 100), colors.Dark.one)

    Block(vector.new(100, 150), colors.Dark.two)
    Block(vector.new(150, 150), colors.Dark.thr)
    Block(vector.new(200, 150), colors.Dark.fou)
    Block(vector.new(250, 150), colors.Dark.fiv)

    to_delete1 = Block(vector.new(100, 200), colors.Dark.ssm)
    to_delete2 = Block(vector.new(150, 200), colors.Dark.slg)
    to_delete3 = Block(vector.new(200, 200), colors.Dark.csm)
    to_delete4 = Block(vector.new(250, 200), colors.Dark.clg)

    -- Delete the last row after five seconds
    Game.timer:after(5, function ()
        to_delete1:delete()
        to_delete2:delete()
        to_delete3:delete()
        to_delete4:delete()
    end)
end


-- LÖVE callbacks --

function Game.update(dt)
    for i,node in ipairs(Game.nodes) do
        node:update(dt)
    end
    Game.timer:update(dt)
    Game.debugPosition = 2
end

function Game.draw()
    Game.debugDisplay(string.format('fps: %i', love.timer.getFPS()))
    Game.debugDisplay(string.format('time: %.2f', love.timer.getTime() - Game.startTime))
    Game.debugDisplay(string.format('mouse.x: %i', love.mouse.getX()))
    Game.debugDisplay(string.format('mouse.y: %i', love.mouse.getY()))
    Game.debugDisplay(string.format('mouse.m1.down: %s', love.mouse.isDown(1) and 'true' or 'false'))

    for i,node in ipairs(Game.nodes) do
        node:draw(dt)
    end
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

function Game.debugDisplay(str)
    if Game.DEBUG then
        love.graphics.print(str, 2, Game.debugPosition)
        Game.debugPosition = Game.debugPosition + 15
    end
end

function Game.resetColor()
    love.graphics.setColor(colors.toFloats({255, 255, 255}))
end


return Game
