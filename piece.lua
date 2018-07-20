local Timer = require('ext.hump.timer')
local vector = require('ext.hump.vector')

local Node = require('node')


local Piece = Node:extend()

function Piece:constructor(pos)
    Node.constructor(self, pos)
    self.starting_pos = pos  -- read-only hump.vector
    self.grabbed = false
    self.onTop = false
end

function Piece:mousepressed(x, y, button, istouch)
    if button == 1 and self:pointWithin() then
        xOffset = self.pos.x - x
        yOffset = self.pos.y - y
        self.grabbed = vector.new(xOffset, yOffset)
        self.onTop = true
    end
end

function Piece:mousereleased(x, y, button, istouch)
    self.grabbed = false
    Game.timer:tween(.25, self.pos, self.starting_pos, 'out-quad', function()
        self.onTop = false
    end)
end

function Piece:mousemoved(x, y, istouch)
    if self.grabbed then 
        local newX = x
        local newY = y
        self.pos = vector.new(x, y) + self.grabbed
    end
end

function Piece:draw()
    deep.queue(self.onTop and 2 or 1, function ()
        love.graphics.setColor(self.color)
        love.graphics.rectangle('fill',
                                self.pos.x, self.pos.y,
                                self.size.w, self.size.h,
                                self.radius, self.radius)
    end)
end


return Piece
