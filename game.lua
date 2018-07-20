local Block = require('blocks')
local colors = require('colors')

local deep = require('ext.deep')
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
    love.graphics.setBackgroundColor(Game.theme.bg)

    Block(vector.new(100, 100), Game.theme.one)
    Block(vector.new(150, 100), Game.theme.def)
    Block(vector.new(200, 100), Game.theme.def)
    Block(vector.new(250, 100), Game.theme.def)

    Block(vector.new(100, 150), Game.theme.two)
    Block(vector.new(150, 150), Game.theme.thr, Block.PLACED_SIZE)
    Block(vector.new(200, 150), Game.theme.fou, Block.GRABBED_SIZE)
    Block(vector.new(250, 150), Game.theme.fiv, Block.SELECT_SIZE)

    to_delete1 = Block(vector.new(100, 200), Game.theme.ssm)
    to_delete2 = Block(vector.new(150, 200), Game.theme.slg)
    to_delete3 = Block(vector.new(200, 200), Game.theme.csm)
    to_delete4 = Block(vector.new(250, 200), Game.theme.clg)

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

    for i,node in ipairs(Game.nodes) do
        node:draw(dt)
    end

    deep.execute()
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
        love.graphics.setColor(colors.toFloats({255, 255, 255}))
        love.graphics.print(str, 2, Game.debugPosition)
        Game.debugPosition = Game.debugPosition + 15
    end
end


return Game
