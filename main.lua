local Timer = require('ext.hump.timer')
local vector = require('ext.hump.vector')

local colors = require('colors')
local Block = require('blocks')


local debugPosition = 2

function debugDisplay(str)
    love.graphics.print(str, 2, debugPosition)
    debugPosition = debugPosition + 15
end

function resetDebugDisplay()
    debugPosition = 2
end

function resetColor()
    love.graphics.setColor(colors.toFloats({255, 255, 255}))
end

function love.mousepressed(x, y, button, istouch)
    block:mousepressed(x, y, button, istouch)
    block2:mousepressed(x, y, button, istouch)
end

function love.mousereleased(x, y, button, istouch)
    block:mousereleased(x, y, button, istouch)
    block2:mousereleased(x, y, button, istouch)
end

function love.mousemoved(x, y, dx, dy, istouch)
    block:mousemoved(x, y, istouch)
    block2:mousemoved(x, y, istouch)
end

function love.load()
    love.graphics.setBackgroundColor(colors.Dark.bg)
    block = Block(vector.new(100, 100), colors.Dark.one)
    block2 = Block(vector.new(150, 100), colors.Dark.two)
end

function love.update(dt)
    block:update(dt)
    block2:update(dt)
    Timer.update(dt)
end

function love.draw()
    debugDisplay(string.format('fps: %i', love.timer.getFPS()))
    debugDisplay(string.format('mouse.x: %i', love.mouse.getX()))
    debugDisplay(string.format('mouse.y: %i', love.mouse.getY()))
    debugDisplay(string.format('mouse.down: %s', love.mouse.isDown(1) and 'true' or 'false'))

    block:draw()
    block2:draw()

    resetDebugDisplay()
end
