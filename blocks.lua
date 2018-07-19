local deep = require('ext.deep')
local Timer = require('ext.hump.timer')
local vector = require('ext.hump.vector')

local Node = require('node')


-- Size of blocks in the selection panel (TBD)
local BLOCK_SELECT_SIZE  = {w=25, h=25, r=5}

-- Size of blocks currently grabbed by the player (TBD)
local BLOCK_GRABBED_SIZE = {w=25, h=25, r=5}

-- Size of blocks placed on the grid
local BLOCK_PLACED_SIZE  = {w=25, h=25, r=5}


local Block = Node:extend()

function Block:constructor(pos, color)
    Node.constructor(self, pos, BLOCK_PLACED_SIZE)
    self.starting_pos = pos  -- read-only hump.vector
    self.color = color or Game.theme.def  -- LÖVE-compatible rgb(a) color table
    self.grabbed = false
end

function Block:mousepressed(x, y, button, istouch)
    if button == 1 and self:pointWithin() then
        xOffset = self.pos.x - x
        yOffset = self.pos.y - y
        self.grabbed = vector.new(xOffset, yOffset)
    end
end

function Block:mousereleased(x, y, button, istouch)
    self.grabbed = false
    Game.timer:tween(.25, self.pos, self.starting_pos, 'out-quad')
end

function Block:mousemoved(x, y, istouch)
    if self.grabbed then 
        local newX = x
        local newY = y
        self.pos = vector.new(x, y) + self.grabbed
    end
end

function Block:draw()
    deep.queue(self.grabbed and 2 or 1, function ()
        love.graphics.setColor(self.color)
        love.graphics.rectangle('fill',
                                self.pos.x, self.pos.y,
                                self.size.w, self.size.h,
                                self.size.r, self.size.r)
    end)
end


return Block
