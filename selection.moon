Node = require 'node'
V = require 'vector'


class PolyDef
    @NONE:               0
    @ROTATE_ONCE:        1
    @ROTATE_ALL:         2
    @REFLECT:            3
    @ROTATE_AND_REFLECT: 4

    new: (@name, @color, @weight, blocks) =>
        @max = V(0, 0)
        @blocks = {}
        for i,b in ipairs blocks
            @blocks[i] = b
            if b[1] > @max.x then @max.x = b[1]
            if b[2] > @max.y then @max.y = b[2]
    
    fromDef: (name, rawDef) ->
        {:color, :weight} = rawDef
        return PolyDef name, color, weight, rawDef
    
    transform: (name, transFunc) =>
        newBlocks = {}
        for block in *@blocks
            table.insert newBlocks, transFunc(block)
        return PolyDef name, @color, @weight, newBlocks
    
    rotate: (coords) =>
        {-coords[2] + @max.x + 1, coords[1]}
    
    reflect: (coords) =>
        {-coords[1] + @max.x, coords[2]}


class PolyDefCollection
    new: (...) =>
        args = {...}
        @defs = {}
        @weight = 0
        for arg in *args
            for name,def in pairs arg
                pdef = PolyDef.fromDef name, def
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
