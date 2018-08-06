Timer = require 'vendor.hump.timer'
V = require 'vector'

Node = require 'node'
Block = require 'block'

import p from require 'moon'


class Poly extends Node
    new: (game, parent, pos, def) =>
        super game, parent, pos
        @starting_pos = pos\clone()
        @grabbed = false

        @max = def.max

        @blocks = {}
        for offsets in *def.blocks
            bl = {}
            bl.block = Block(@game, @, pos\clone(), def.color, Block.STATES.SELECT)
            bl.offset = V(offsets[1], offsets[2])
            table.insert(@blocks, bl)

        blockSize = @blocks[1].block.size.w
        spacing = @blocks[1].block\getSpacing()
        w = ((@max.x + 1) * blockSize) + (@max.x * spacing)
        h = ((@max.y + 1) * blockSize) + (@max.y * spacing)
        @size = @\getSize()

    setOnTop: (onTop) =>
        for bl in *@blocks
            bl.block.onTop = onTop

    getSize: =>
        blockSize = @blocks[1].block.size.w
        spacing = @blocks[1].block\getSpacing()
        w = ((@max.x + 1) * blockSize) + (@max.x * spacing)
        h = ((@max.y + 1) * blockSize) + (@max.y * spacing)
        return w: w, h: h

    mousepressed: (x, y, button, istouch) =>
        if button == 1 and @\pointWithin()
            for bl in *@blocks
                bl.block\setState(Block.STATES.GRABBED)
            @grabbed = V(@pos.x - x, @pos.y - y)
            @\setOnTop(true)

    mousereleased: (x, y, button, istouch) =>
        for bl in *@blocks
            bl.block\setState(Block.STATES.SELECT)
        @grabbed = false
        @game.timer\tween .25, @pos, @starting_pos, 'out-quad', ->
            @\setOnTop(false)

    mousemoved: (x, y, istouch) =>
        if @grabbed
            newX = x
            newY = y
            @pos = V(x, y) + @grabbed

    update: =>
        for bl in *@blocks
            @size = @\getSize()

            distance = bl.block.size.w + bl.block\getSpacing()
            bl.block.pos = @pos + bl.offset * distance


return Poly
