local deep = require('ext.deep')
local Timer = require('ext.hump.timer')
local vector = require('ext.hump.vector')

local Node = require('node')


local Block = Node:extend()

-- Block sizes
Block.SIZES = {
    SELECT=20,
    GRABBED=29,
    PLACED=32
}
Block.DEFAULT_SIZE = Block.SIZES.PLACED

function Block:constructor(pos, color, blockSize)
    Node.constructor(self, pos)
    blockSize = blockSize or Block.DEFAULT_SIZE
    self.size = {w=blockSize, h=blockSize}
    self.radius = blockSize/5
    self.starting_pos = pos  -- read-only hump.vector
    self.color = color or Game.theme.def  -- LÖVE-compatible rgb(a) color table
    self.grabbed = false
    self.onTop = false
end

function Block:mousepressed(x, y, button, istouch)
    if button == 1 and self:pointWithin() then
        xOffset = self.pos.x - x
        yOffset = self.pos.y - y
        self.grabbed = vector.new(xOffset, yOffset)
        self.onTop = true
    end
end

function Block:mousereleased(x, y, button, istouch)
    self.grabbed = false
    Game.timer:tween(.25, self.pos, self.starting_pos, 'out-quad', function()
        self.onTop = false
    end)
end

function Block:mousemoved(x, y, istouch)
    if self.grabbed then 
        local newX = x
        local newY = y
        self.pos = vector.new(x, y) + self.grabbed
    end
end

function Block:draw()
    deep.queue(self.onTop and 2 or 1, function ()
        love.graphics.setColor(self.color)
        love.graphics.rectangle('fill',
                                self.pos.x, self.pos.y,
                                self.size.w, self.size.h,
                                self.radius, self.radius)
    end)
end


return Block
