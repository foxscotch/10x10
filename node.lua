local Base = require('ext.knife.base')
local vector = require('ext.hump.vector')


local Node = Base:extend()

function Node:constructor(parent, pos, size)
    if parent then
        self.parent = parent
        self.parent:addChild(self)
    else
        self.parent = nil
    end

    self.children = {}
    self.pos = pos or vector.new(0, 0)  -- hump.vector
    self.size = size or {w=0, h=0, r=0}
end

function Node:delete()
    if self.parent then
        parent:removeChild(self)
    end
end

function Node:addChild(node)
    table.insert(self.children, node)
end

function Node:removeChild(node)
    for i,n in ipairs(self.children) do
        if n == node then
            table.remove(self.children, i)
            return
        end
    end
end

function Node:setPos(vect)
    self.pos = vector.new(vect.x, vect.y)
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


-- The following functions should not be overwritten in subclasses

function eventAll(event)
    return function (self, ...)
        self[event](self, ...)
        for i,v in ipairs(self.children) do
            v[event](v, ...)
        end
    end
end

Node['updateAll'] = eventAll('update')
Node['drawAll'] = eventAll('draw')
Node['quitAll'] = eventAll('quit')
Node['resizeAll'] = eventAll('resize')
Node['focusAll'] = eventAll('focus')
Node['mousefocusAll'] = eventAll('mousefocus')
Node['wheelmovedAll'] = eventAll('wheelmoved')
Node['mousepressedAll'] = eventAll('mousepressed')
Node['mousereleasedAll'] = eventAll('mousereleased')
Node['mousemovedAll'] = eventAll('mousemoved')
Node['touchmovedAll'] = eventAll('touchmoved')
Node['touchpressedAll'] = eventAll('touchpressed')
Node['touchreleasedAll'] = eventAll('touchreleased')
Node['keypressedAll'] = eventAll('keypressed')
Node['keyreleasedAll'] = eventAll('keyreleased')


return Node
