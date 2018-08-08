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

    transform: (name, transFunc) =>
        newBlocks = {}
        for block in *@blocks
            table.insert newBlocks, transFunc(block)
        return PolyDef name, @color, @weight, newBlocks
    
    swapAxes: (co) => {co[2], co[1]}
    reflectPointV: (co) => {-co[1] + @max.x, co[2]}
    reflectPointH: (co) => {co[1], -co[2] + @max.y}
    rotatePoint90: (co) => {-co[2] + @max.x + 1, co[1]}
    rotatePoint180: (co) => @reflectPointH @reflectPointV co
    rotatePoint270: (co) => @rotatePoint90 @reflectPointH @reflectPointV co

    swap: (name) => @transform name, @\swapAxes
    reflect: (name) => @transform name, @\reflectPointV
    rotate90: (name) => @transform name, @\rotatePoint90
    rotate180: (name) => @transform name, @\rotatePoint180
    rotate270: (name) => @transform name, @\rotatePoint270


class PolyDefCollection
    new: (...) =>
        args = {...}
        @defs = {}
        @weight = 0
        for arg in *args
            for name,def in pairs arg
                pdef = PolyDef.fromDef name, def
                @add pdef
                t = def.transform
                if string.find(t, 'rotate')
                    if string.find(t, 'once')
                        @add pdef\swap name .. '_90'
                    else
                        @add pdef\rotate90 name .. '_90'
                    if string.find(t, 'all')
                        @add pdef\rotate180 name .. '_180'
                        @add pdef\rotate270 name .. '_270'
                if string.find(t, 'reflect')
                    reflected = pdef\reflect name .. '_M'
                    @add reflected
                    if string.find(t, 'rotate')
                        if string.find(t, 'once')
                            @add reflected\swap name .. '_M90'
                        else
                            @add reflected\rotate90 name .. '_M90'
                        if string.find(t, 'all')
                            @add reflected\rotate180 name .. '_M180'
                            @add reflected\rotate270 name .. '_M270'
    
    add: (def) =>
        @weight += def.weight
        table.insert @defs, def
    
    select: (n=3) =>
        [@random! for i=1,n]
    
    random: =>
        r = math.random(1, @weight)
        for def in *@defs
            r -= def.weight
            if r <= 0
                return def


return {:PolyDef, :PolyDefCollection}
