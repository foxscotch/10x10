local Base = require('ext.knife.base')
local vector = require('ext.hump.vector')


local Node = Base:extend()

function Node:constructor(pos, size)
    Game.addNode(self)
    self.pos = pos or vector.new(0, 0)  -- hump.vector
    self.size = size or {w=0, h=0, r=0}
end

function Node:delete()
    Game.removeNode(self)
end

function Node:setPos(x, y)
    self.pos = vector.new(x, y)
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


-- Define stubs for relevant callbacks

function Node:update() end
function Node:draw() end
function Node:quit() end
function Node:resize() end
function Node:focus() end
function Node:mousefocus() end
function Node:wheelmoved() end
function Node:mousepressed() end
function Node:mousereleased() end
function Node:mousemoved() end
function Node:touchmoved() end
function Node:touchpressed() end
function Node:touchreleased() end
function Node:keypressed() end
function Node:keyreleased() end


return Node
