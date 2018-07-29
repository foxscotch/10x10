local deep = require('ext.deep')
local Timer = require('ext.hump.timer')
local vector = require('ext.hump.vector')

local Node = require('node')
local util = require('util')


local Block = Node:extend()


-- Base size of blocks,
Block.BASE_SIZE = 38

-- Block spacing factor
Block.SPACING_FACTOR = 0.07

-- Default Block spacing
Block.DEFAULT_SPACING = Block.BASE_SIZE * Block.SPACING_FACTOR

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
    self.state = util.copy(state or Block.STATES.PLACED)
    local size = Block.BASE_SIZE * self.state.factor
    self.size = {w=size, h=size}
    self.color = color or 'def'  -- string corresponding to theme color name
    self.onTop = false  -- set by Polies
end

function Block:getSpacing()
    return self.size.w * Block.SPACING_FACTOR
end

function Block:setState(state)
    Game.timer:tween(.2, self.state, state, 'out-back')
end

function Block:update()
    local size = Block.BASE_SIZE * self.state.factor
    self.size = {w=size, h=size}
end

function Block:draw()
    local padding = self.state.padding * self.size.w
    local size = self.size.w - padding
    local radius = size / Block.RADIUS_DIVISOR
    deep.queue(self.onTop and 2 or 1, function ()
        love.graphics.setColor(Game.theme[self.color])
        love.graphics.rectangle('fill',
                                self.pos.x + padding, self.pos.y + padding,
                                size, size,
                                radius)
    end)
end


return Block
