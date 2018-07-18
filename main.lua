vector = require('ext.hump.vector')

colors = require('colors')
Block = require('blocks')


function withinRect(mx, my)
    setBounds()

    if mx >= bounds[1] and mx <= bounds[2] and my >= bounds[3] and my <= bounds[4] then
        return true
    else
        return false
    end
end

function resetColor()
    love.graphics.setColor(colors.toFloats({255, 255, 255}))
end

function love.mousepressed(x, y, button, istouch)
    block:mousepressed(x, y, button, istouch)
end

function love.mousereleased(x, y, button, istouch)
    block:mousereleased(x, y, button, istouch)
end

function love.mousemoved(x, y, dx, dy, istouch)
    block:mousemoved(x, y, istouch)
end

function love.load()
    love.graphics.setBackgroundColor(colors.Dark.bg)
    block = Block(vector.new(100, 100), colors.Dark.one)
end

function love.update(dt)
    block:update(dt)
end

function love.draw()
    block:draw()

    love.graphics.print(string.format('fps: %i', love.timer.getFPS()), 2, 0)

    love.graphics.print(string.format('mouse.x: %i', love.mouse.getX()), 2, 12)
    love.graphics.print(string.format('mouse.y: %i', love.mouse.getY()), 2, 24)
    love.graphics.print(string.format('mouse.down: %s', love.mouse.isDown(1) and 'true' or 'false'), 2, 36)
end
