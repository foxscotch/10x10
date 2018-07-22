local deep = require('ext.deep')
local Timer = require('ext.hump.timer')
local vector = require('ext.hump.vector')

local Node = require('node')


local Block = Node:extend()


-- Base size of blocks,
Block.BASE_SIZE = 32

-- Block sizes
Block.SIZE_FACTORS = {
    SELECT  = 0.62,
    GRABBED = 0.90,
    PLACED  = 1.00
}

-- Divisor used to find corner radius.
Block.RADIUS_DIVISOR = 5


function Block:constructor(parent, pos, color, sizeFactor)
    Node.constructor(self, parent, pos)
    local sF = sizeFactor or Block.SIZE_FACTORS.PLACED
    self.size = {w=Block.BASE_SIZE*sF, h=Block.BASE_SIZE*sF}
    self.color = color or 'def'  -- string corresponding to theme color name
end

function Block:draw(onTop)
    deep.queue(onTop and 1 or 2, function ()
        love.graphics.setColor(Game.theme[self.color])
        love.graphics.rectangle('fill',
                                self.pos.x, self.pos.y,
                                self.size.w, self.size.h,
                                self.size.w / Block.RADIUS_DIVISOR)
    end)
end


return Block
