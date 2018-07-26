local deep = require('ext.deep')
local Timer = require('ext.hump.timer')
local vector = require('ext.hump.vector')

local Node = require('node')


local Block = Node:extend()


-- Base size of blocks,
Block.BASE_SIZE = 32

-- Block states
Block.STATES = {
    SELECT  = {factor=0.62, padding=0.00},
    GRABBED = {factor=1.00, padding=0.10},
    PLACED  = {factor=1.00, padding=0.00}
}

-- Divisor used to find corner radius.
Block.RADIUS_DIVISOR = 5


function Block:constructor(parent, pos, color, state)
    Node.constructor(self, parent, pos)
    self.state = state or Block.STATES.PLACED
    local size = Block.BASE_SIZE * self.state.factor
    self.size = {w=size, h=size}
    self.color = color or 'def'  -- string corresponding to theme color name
end

function Block:getSpacing()
    return self.size.w * 0.06
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