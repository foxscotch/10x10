Node = require 'node'
V = require 'vector'


class PolyDef
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
    
    reflect: =>
        newBlocks = {}
        for block in *@blocks
            table.insert newBlocks, {-block[1] + @max.x, block[2]}
        return PolyDef @name .. 'M', @color, @weight, newBlocks


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
