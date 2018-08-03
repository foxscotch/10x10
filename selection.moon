Node = require 'node'
V = require 'vector'


class PolyDef
    new: (@name, rawDef) =>
        {color: @color, weight: @weight} = rawDef
        @max = V(0, 0)
        @blocks = {}
        for i,b in ipairs rawDef
            @blocks[i] = b
            if b[0] > @max.x then @max.x = b[0]
            if b[1] > @max.y then @max.y = b[1]


class PolyDefCollection
    new: (defs) =>
        @defs = {}
        for name,def in pairs defs
            table.insert @defs, PolyDef(name, def)


import p from require 'moon'
pdc = PolyDefCollection require 'definitions.classic'
p pdc
