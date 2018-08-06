Node = require 'node'
V = require 'vector'


class PolyDef
    new: (@name, rawDef) =>
        {color: @color, weight: @weight} = rawDef
        @max = V(0, 0)
        @blocks = {}
        for i,b in ipairs rawDef
            @blocks[i] = b
            if b[1] > @max.x then @max.x = b[1]
            if b[2] > @max.y then @max.y = b[2]


class PolyDefCollection
    new: (defs) =>
        @defs = {}
        @weight = 0
        for name,def in pairs defs
            pdef = PolyDef name, def
            @weight += pdef.weight
            table.insert @defs, pdef
    
    select: (n=3) =>
        [@random! for i=1,n]
    
    random: =>
        r = math.random(1, @weight)
        for def in *@defs
            r -= def.weight
            if r <= 0
                return def

return {:PolyDef, :PolyDefCollection}
