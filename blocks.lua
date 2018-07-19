local Base = require('ext.knife.base')
local Timer = require('ext.hump.timer')
local vector = require('ext.hump.vector')


-- Size of blocks in the selection panel (TBD)
local BLOCK_SELECT_SIZE  = {w=25, h=25, r=5}

-- Size of blocks currently grabbed by the player (TBD)
local BLOCK_GRABBED_SIZE = {w=25, h=25, r=5}

-- Size of blocks placed on the grid
local BLOCK_PLACED_SIZE  = {w=25, h=25, r=5}


local Block = Base:extend()

function Block:constructor(pos, color)
    self.pos = pos  -- hump.vector
    self.starting_pos = pos  -- read-only hump.vector
    self.color = color  -- LÖVE-compatible rgb(a) color table
    self.size = BLOCK_PLACED_SIZE  -- Default to the full size
    self.grabbed = false
end

function Block:update(dt) end

function Block:mousepressed(x, y, button, istouch)
    if self:pointWithin() then
        xOffset = self.pos.x - love.mouse.getX()
        yOffset = self.pos.y - love.mouse.getY()
        self.grabbed = vector.new(xOffset, yOffset)
    end
end

function Block:mousereleased(x, y, button, istouch)
    self.grabbed = false
    Timer.tween(.5, self.pos, self.starting_pos, 'out-quad')
end

function Block:mousemoved(x, y, istouch)
    if self.grabbed then 
        local newX = love.mouse.getX()
        local newY = love.mouse.getY()
        self.pos = vector.new(x, y) + self.grabbed
    end
end

function Block:draw()
    debugDisplay(string.format('within: %s', self:pointWithin() and 'true' or 'false'))

    love.graphics.setColor(self.color)
    love.graphics.rectangle('fill',
                            self.pos.x, self.pos.y,
                            self.size.w, self.size.h,
                            self.size.r, self.size.r)
    resetColor()
end

function Block:getBounds()
    local xmin = self.pos.x
    local xmax = self.pos.x + self.size.w - 1
    local ymin = self.pos.y
    local ymax = self.pos.y + self.size.h - 1
    return {xmin, xmax, ymin, ymax}
end

function Block:pointWithin(x, y)
    if x == nil then x = love.mouse.getX() end
    if y == nil then y = love.mouse.getY() end

    local bounds = self:getBounds()
    local withinX = x >= bounds[1] and x <= bounds[2]
    local withinY = y >= bounds[3] and y <= bounds[4]
    return withinX and withinY
end


return Block
