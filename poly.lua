local Timer = require('ext.hump.timer')
local vector = require('ext.hump.vector')

local Node = require('node')
local Block = require('block')


local Poly = Node:extend()

function Poly:constructor(parent, pos, polyDef)
    Node.constructor(self, parent, pos)
    self.starting_pos = pos:clone()  -- read-only hump.vector
    self.grabbed = false

    local maxX = 0
    local maxY = 0

    self.blocks = {}
    for i,offsets in ipairs(polyDef) do
        if offsets[1] > maxX then maxX = offsets[1] end
        if offsets[2] > maxY then maxY = offsets[1] end

        bl = {}
        bl.block = Block(self, pos:clone(), polyDef.color, Block.STATES.SELECT)
        bl.offset = vector.new(offsets[1], offsets[2])
        table.insert(self.blocks, bl)
    end

    local blockSize = self.blocks[1].block.size.w
    local spacing = self.blocks[1].block:getSpacing()
    local w = ((maxX + 1) * blockSize) + (maxX * spacing)
    local h = ((maxY + 1) * blockSize) + (maxY * spacing)
    self.size = {w=w, h=h}
end

function Poly:setOnTop(onTop)
    for i,bl in ipairs(self.blocks) do
        bl.block.onTop = onTop
    end
end

function Poly:mousepressed(x, y, button, istouch)
    if button == 1 and self:pointWithin() then
        self.grabbed = vector.new(self.pos.x - x, self.pos.y - y)
        self:setOnTop(true)
    end
end

function Poly:mousereleased(x, y, button, istouch)
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
        local distance = bl.block.size.w + bl.block:getSpacing()
        local xOffset = bl.offset.x * distance
        local yOffset = bl.offset.y * distance
        bl.block.pos = self.pos + vector.new(xOffset, yOffset)
    end
end


return Poly
