local Base = require('ext.knife.base')


local Node = Base:extend()

function Node:constructor(pos, size)
    Game.addNode(self)
    self.pos = pos  -- hump.vector
    self.size = size or {w=0, h=0}
end

function Node:delete()
    Game.removeNode(self)
end

function Node:getBounds()
    local xmin = self.pos.x
    local xmax = self.pos.x + self.size.w - 1
    local ymin = self.pos.y
    local ymax = self.pos.y + self.size.h - 1
    return {xmin, xmax, ymin, ymax}
end

function Node:pointWithin(x, y)
    if x == nil then x = love.mouse.getX() end
    if y == nil then y = love.mouse.getY() end

    local bounds = self:getBounds()
    local withinX = x >= bounds[1] and x <= bounds[2]
    local withinY = y >= bounds[3] and y <= bounds[4]
    return withinX and withinY
end


return Node
