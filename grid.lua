local vector = require('ext.hump.vector')

local Node = require('node')
local Block = require('blocks')


local Grid = Node:extend()

-- The number of blocks it contains, not size in pixels
Grid.DEFAULT_SIZE = {w=10, h=10}

-- Space, in pixels, between blocks
Grid.SPACING = Block.DEFAULT_SIZE * 0.06

function Grid:constructor(parent, pos, size)
    Node.constructor(self, parent, pos)
    self.size = size or Grid.DEFAULT_SIZE
    self.blocks = {}

    for i = 1, self.size.w do
        table.insert(self.blocks, {})
        for j = 1, self.size.h do
            local x = self:getOffset(i, 'y')
            local y = self:getOffset(j, 'y')
            local block = Block(self, vector.new(x, y))
            table.insert(self.blocks[i], block)
        end
    end
end

function Grid:setPos(vect)
    Node.setPos(self, vect)
    for i = 1, self.size.w do
        for j = 1, self.size.h do
            local x = self:getOffset(i, 'x')
            local y = self:getOffset(j, 'y')
            self.blocks[i][j]:setPos(vector.new(x, y))
        end
    end
end

function Grid:getOffset(i, dimension)
    return (Block.DEFAULT_SIZE + Grid.SPACING) * (i - 1) + self.pos[dimension]
end

function Grid:getFullSize()
    local w, h = self.size.w, self.size.h
    local b = self.blocks[1][1].size.w
    local width = b * w + Grid.SPACING * (w-1)
    local height = b * h + Grid.SPACING * (h-1)
    return width, height
end

function Grid:mousereleased(x, y, button, istouch) end


return Grid
