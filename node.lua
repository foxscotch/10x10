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


-- The following functions should not be overwritten in subclasses. They call
-- the event handlers for themselves and all children.

function Node:updateAll(...)
    self:update(...)
    for i,v in ipairs(self.children) do
        v:update(...)
    end
end


function Node:drawAll(...)
    self:draw(...)
    for i,v in ipairs(self.children) do
        v:draw(...)
    end
end


function Node:quitAll(...)
    self:quit(...)
    for i,v in ipairs(self.children) do
        v:quit(...)
    end
end


function Node:resizeAll(...)
    self:resize(...)
    for i,v in ipairs(self.children) do
        v:resize(...)
    end
end


function Node:focusAll(...)
    self:focus(...)
    for i,v in ipairs(self.children) do
        v:focus(...)
    end
end


function Node:mousefocusAll(...)
    self:mousefocus(...)
    for i,v in ipairs(self.children) do
        v:mousefocus(...)
    end
end


function Node:wheelmovedAll(...)
    self:wheelmoved(...)
    for i,v in ipairs(self.children) do
        v:wheelmoved(...)
    end
end


function Node:mousepressedAll(...)
    self:mousepressed(...)
    for i,v in ipairs(self.children) do
        v:mousepressed(...)
    end
end


function Node:mousereleasedAll(...)
    self:mousereleased(...)
    for i,v in ipairs(self.children) do
        v:mousereleased(...)
    end
end


function Node:mousemovedAll(...)
    self:mousemoved(...)
    for i,v in ipairs(self.children) do
        v:mousemoved(...)
    end
end


function Node:touchmovedAll(...)
    self:touchmoved(...)
    for i,v in ipairs(self.children) do
        v:touchmoved(...)
    end
end


function Node:touchpressedAll(...)
    self:touchpressed(...)
    for i,v in ipairs(self.children) do
        v:touchpressed(...)
    end
end


function Node:touchreleasedAll(...)
    self:touchreleased(...)
    for i,v in ipairs(self.children) do
        v:touchreleased(...)
    end
end


function Node:keypressedAll(...)
    self:keypressed(...)
    for i,v in ipairs(self.children) do
        v:keypressed(...)
    end
end


function Node:keyreleasedAll(...)
    self:keyreleased(...)
    for i,v in ipairs(self.children) do
        v:keyreleased(...)
    end
end


return Node
