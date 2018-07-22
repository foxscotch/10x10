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

Block.RADIUS_DIVISOR = 5

function Block:constructor(parent, pos, color, blockSize)
    Node.constructor(self, parent, pos)
    blockSize = blockSize or Block.DEFAULT_SIZE
    self.size = {w=blockSize, h=blockSize}
    self.color = color or 'def'  -- string corresponding to theme color name
end

function Block:draw()
    deep.queue(2, function ()
        love.graphics.setColor(Game.theme[self.color])
        love.graphics.rectangle('fill',
                                self.pos.x, self.pos.y,
                                self.size.w, self.size.h,
                                self.size.w / Block.RADIUS_DIVISOR)
    end)
end


return Block
