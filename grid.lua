local vector = require('ext.hump.vector')

local Node = require('node')
local Block = require('block')


local Grid = Node:extend()


-- The number of blocks it contains, not size in pixels
Grid.DEFAULT_SIZE = {w=10, h=10}


function Grid:constructor(parent, pos, size)
    Node.constructor(self, parent, pos)
    self.gridSize = size or Grid.DEFAULT_SIZE
    self.blocks = {}

    for i = 1, self.gridSize.w do
        table.insert(self.blocks, {})
        for j = 1, self.gridSize.h do
            local block = Block(self)
            local x,y = self:getOffsets(i, j)
            block.pos = vector.new(x, y)
            table.insert(self.blocks[i], block)
        end
    end

    local w, h = self.gridSize.w, self.gridSize.h
    local b = self.blocks[1][1].size.w
    local width = b * w + Block.DEFAULT_SPACING * (w-1)
    local height = b * h + Block.DEFAULT_SPACING * (h-1)
    self.size = {w=width, h=height}
end

function Grid:setPos(pos)
    self.pos = pos
    for i = 1, self.gridSize.w do
        for j = 1, self.gridSize.h do
            local x,y = self:getOffsets(i, j)
            self.blocks[i][j].pos = vector.new(x, y)
        end
    end
end

function Grid:getOffset(row, dimension)
    local spacing = Block.DEFAULT_SPACING
    return (Block.BASE_SIZE + spacing) * (row - 1) + self.pos[dimension]
end

function Grid:getOffsets(row, col)
    return self:getOffset(row, 'x'), self:getOffset(col, 'y')
end


return Grid
