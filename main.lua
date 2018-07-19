local Game = require('game')


Game.DEBUG = true


function love.mousepressed(x, y, button, istouch)
    Game.mousepressed(x, y, button, istouch)
end

function love.mousereleased(x, y, button, istouch)
    Game.mousereleased(x, y, button, istouch)
end

function love.mousemoved(x, y, dx, dy, istouch)
    Game.mousemoved(x, y, dx, dy, istouch)
end

function love.load()
    Game.init()
end

function love.update(dt)
    Game.update(dt)
end

function love.draw()
    Game.draw()
end
