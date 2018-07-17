colors = require('colors')

grabbed = false
rp = {x=50, y=50, w=25, h=25}
bounds = nil
mouse = {x=0, y=0}

joystick = 0
js_val = 0

function setBounds()
    local xmin = rp.x
    local xmax = rp.x + rp.w - 1
    local ymin = rp.y
    local ymax = rp.y + rp.h - 1
    bounds = {xmin, xmax, ymin, ymax}
end
setBounds()

function color(r, g, b)
    local red = r / 255
    local green = g / 255
    local blue = b / 255
    return {red, green, blue}
end

function drawRect()
    love.graphics.setColor(colors.Dark.two)
    love.graphics.rectangle('fill', rp.x, rp.y, rp.h, rp.w, 2, 2)
    love.graphics.setColor(color(255, 255, 255))
end

function withinRect(mx, my)
    setBounds()

    if mx >= bounds[1] and mx <= bounds[2] and my >= bounds[3] and my <= bounds[4] then
        return true
    else
        return false
    end
end

function love.mousepressed(x, y, button, istouch)
    if withinRect(x, y) then
        grabbed = true
    end
end

function love.mousereleased(x, y, button, istouch)
    grabbed = false
end

function love.mousemoved(x, y, dx, dy, istouch)
    mouse.x = x
    mouse.y = y

    if grabbed then
        rp.x = rp.x + dx
        rp.y = rp.y + dy
    end
end

function love.load()
    love.graphics.setBackgroundColor(colors.Dark.bg)
end

function love.update(dt) end

function love.draw()
    drawRect()
    love.graphics.print(string.format('fps: %i', love.timer.getFPS()), 2, 0)

    love.graphics.print(string.format('mouse.x: %i', mouse.x), 2, 12)
    love.graphics.print(string.format('mouse.y: %i', mouse.y), 2, 24)

    love.graphics.print(string.format('grabbed: %s', grabbed and 'true' or 'false'), 2, 36)
end
