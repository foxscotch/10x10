local Timer = require('ext.hump.timer')
local vector = require('ext.hump.vector')

local Node = require('node')
local Block = require('block')


local Poly = Node:extend()

function Poly:constructor(parent, pos, polyDef)
    Node.constructor(self, parent, pos)
    self.starting_pos = pos:clone()  -- read-only hump.vector
    self.grabbed = false

    self.maxX = 0
    self.maxY = 0

    self.blocks = {}
    for i,offsets in ipairs(polyDef) do
        if offsets[1] > self.maxX then self.maxX = offsets[1] end
        if offsets[2] > self.maxY then self.maxY = offsets[2] end

        bl = {}
        bl.block = Block(self, pos:clone(), polyDef.color, Block.STATES.SELECT)
        bl.offset = vector.new(offsets[1], offsets[2])
        table.insert(self.blocks, bl)
    end

    local blockSize = self.blocks[1].block.size.w
    local spacing = self.blocks[1].block:getSpacing()
    local w = ((self.maxX + 1) * blockSize) + (self.maxX * spacing)
    local h = ((self.maxY + 1) * blockSize) + (self.maxY * spacing)
    self.size = self:getSize()
end

function Poly:setOnTop(onTop)
    for i,bl in ipairs(self.blocks) do
        bl.block.onTop = onTop
    end
end

function Poly:getSize()
    local blockSize = self.blocks[1].block.size.w
    local spacing = self.blocks[1].block:getSpacing()
    local w = ((self.maxX + 1) * blockSize) + (self.maxX * spacing)
    local h = ((self.maxY + 1) * blockSize) + (self.maxY * spacing)
    return {w=w, h=h}
end

function Poly:mousepressed(x, y, button, istouch)
    if button == 1 and self:pointWithin() then
        for i,bl in ipairs(self.blocks) do
            bl.block:setState(Block.STATES.GRABBED)
        end
        self.grabbed = vector.new(self.pos.x - x, self.pos.y - y)
        self:setOnTop(true)
    end
end

function Poly:mousereleased(x, y, button, istouch)
    for i,bl in ipairs(self.blocks) do
        bl.block:setState(Block.STATES.SELECT)
    end
    self.grabbed = false
    Game.timer:tween(.25, self.pos, self.starting_pos, 'out-quad', function()
        self:setOnTop(false)
    end)
end

function Poly:mousemoved(x, y, istouch)
    if self.grabbed then
        local newX = x
        local newY = y
        self.pos = vector.new(x, y) + self.grabbed
    end
end

function Poly:update()
    for i,bl in ipairs(self.blocks) do
        self.size = self:getSize()

        local distance = bl.block.size.w + bl.block:getSpacing()
        local xOffset = bl.offset.x * distance
        local yOffset = bl.offset.y * distance
        bl.block.pos = self.pos + vector.new(xOffset, yOffset)
    end
end


return Poly
