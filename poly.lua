local Timer = require('ext.hump.timer')
local vector = require('ext.hump.vector')

local Node = require('node')
local Block = require('block')


local Poly = Node:extend()

function Poly:constructor(parent, pos, polyDef)
    Node.constructor(self, parent, pos)
    self.starting_pos = pos:clone()  -- read-only hump.vector
    self.grabbed = false
    self.onTop = false

    self.blocks = {}
    for i,offsets in ipairs(polyDef) do
        bl = {}
        bl.block = Block(self, pos:clone(), polyDef.color, Block.STATES.SELECT)
        bl.offset = vector.new(offsets[1], offsets[2])
        table.insert(self.blocks, bl)
    end
end

function Poly:mousepressed(x, y, button, istouch)
    if button == 1 and self:pointWithin() then
        self.grabbed = vector.new(self.pos.x - x, self.pos.y - y)
        self.onTop = true
    end
end

function Poly:mousereleased(x, y, button, istouch)
    self.grabbed = false
    Game.timer:tween(.25, self.pos, self.starting_pos, 'out-quad', function()
        self.onTop = false
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
        local distance = bl.block.size.w + block:getSpacing()
        local xOffset = bl.offset.x * distance
        local yOffset = bl.offset.y * distance
        bl.block.pos = self.pos + vector.new(xOffset, yOffset)

        if self.onTop then
            bl.block.onTop = true
        else
            bl.block.onTop = false
        end
    end
end

function Poly:draw()
    deep.queue(self.onTop and 2 or 1, function ()
        love.graphics.setColor(self.color)
        love.graphics.rectangle('fill',
                                self.pos.x, self.pos.y,
                                self.size.w, self.size.h,
                                self.radius, self.radius)
    end)
end


return Poly
