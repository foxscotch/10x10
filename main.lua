local Game = require('game')
local game


function love.load()
    game = Game()
    game.DEBUG = true
end

function love.update(dt)
    game:update(dt)
end

function love.draw()
    game:draw()
end

function love.mousepressed(x, y, button, istouch)
    game:mousepressed(x, y, button, istouch)
end

function love.mousereleased(x, y, button, istouch)
    game:mousereleased(x, y, button, istouch)
end

function love.mousemoved(x, y, dx, dy, istouch)
    game:mousemoved(x, y, dx, dy, istouch)
end
