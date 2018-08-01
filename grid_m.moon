vector = require 'ext.hump.vector'
import copy from require 'moon'

Node = require 'node_m'
Block = require 'block_m'


class Grid extends Node
    -- The number of blocks it contains, not size in pixels
    @DEFAULT_SIZE = w: 10, h: 10

    new: (game, parent, pos, size) =>
        super game, parent, pos
        @gridSize = copy size or @@DEFAULT_SIZE
        @blocks = {}

        for i = 1, @gridSize.w
            table.insert(@blocks, {})
            for j = 1, @gridSize.h
                block = Block(@game, @)
                x,y = @getOffsets(i, j)
                block.pos = vector.new(x, y)
                table.insert(@blocks[i], block)

        w, h = @gridSize.w, @gridSize.h
        b = @blocks[1][1].size.w
        width = b * w + Block.DEFAULT_SPACING * (w-1)
        height = b * h + Block.DEFAULT_SPACING * (h-1)
        @size = w: width, h: height

    setPos: (pos) =>
        @pos = pos
        for i = 1, @gridSize.w
            for j = 1, @gridSize.h
                x,y = @getOffsets(i, j)
                @blocks[i][j].pos = vector.new(x, y)

    getOffset: (row, dimension) =>
        spacing = Block.DEFAULT_SPACING
        return (Block.BASE_SIZE + spacing) * (row - 1) + @pos[dimension]

    getOffsets: (row, col) =>
        @getOffset(row, 'x'), @getOffset(col, 'y')


return Grid
