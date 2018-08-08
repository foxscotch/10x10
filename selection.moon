Node = require 'node'
V = require 'vector'


class PolyDef
    new: (@name, @color, @groups, @weight, blocks) =>
        @max = V(0, 0)
        @blocks = {}
        for i,b in ipairs blocks
            @blocks[i] = b
            if b[1] > @max.x then @max.x = b[1]
            if b[2] > @max.y then @max.y = b[2]
    
    fromDef: (name, rawDef) ->
        {:color, :groups, :weight} = rawDef
        return PolyDef name, color, groups, weight, rawDef
    
    inGroups: (groups) =>
        for group in *groups
            for sgroup in *@groups
                if group == sgroup then return true
        return false
    
    toMatrix: =>
        matrix = {}
        for y=1,@max.y+1
            matrix[y] = {}
            for x=1,@max.x+1
                matrix[y][x] = false
        for block in *@blocks
            matrix[block[2]+1][block[1]+1] = true
        return matrix
    
    rotateMatrix: (m) ->
        matrix = {}
        for y=1,#m[1]
            matrix[y] = {}
            for x=1,#m
                matrix[y][x] = false
        for i = 1,#m
            for j = 1,#m[1]
                matrix[j][#m-i+1] = m[i][j]
        return matrix
    
    deriveFromMatrix: (name, matrix) =>
        newBlocks = {}
        for y=1,#matrix
            for x=1,#matrix[y]
                if matrix[y][x]
                    table.insert newBlocks, {x-1, y-1}
        return PolyDef name, @color, @groups, @weight, newBlocks

    reflect: (name) =>
        newBlocks = {}
        for bl in *@blocks
            table.insert newBlocks, {-bl[1] + @max.x, bl[2]}
        return PolyDef name, @color, @groups, @weight, newBlocks
    
    rotate: (name, num) =>
        matrix = @toMatrix!
        for i=1,num
            matrix = PolyDef.rotateMatrix matrix
        return @deriveFromMatrix name, matrix

    rotate90: (name) => @rotate name, 1
    rotate180: (name) => @rotate name, 2
    rotate270: (name) => @rotate name, 3


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
                    @add pdef\rotate90 name .. '_90'
                    if string.find(t, 'all')
                        @add pdef\rotate180 name .. '_180'
                        @add pdef\rotate270 name .. '_270'
                if string.find(t, 'reflect')
                    reflected = pdef\reflect name .. '_M'
                    @add reflected
                    if string.find(t, 'rotate')
                        @add reflected\rotate90 name .. '_M90'
                        if string.find(t, 'all')
                            @add reflected\rotate180 name .. '_M180'
                            @add reflected\rotate270 name .. '_M270'
    
    add: (def) =>
        @weight += def.weight
        table.insert @defs, def
    
    filter: (...) =>
        groups = {...}
        pdc = PolyDefCollection!
        for def in *@defs
            -- TODO: Actually make it check for containment lol
            if def\inGroups groups
                pdc\add def
        return pdc
    
    select: (n=3) =>
        [@random! for i=1,n]
    
    random: =>
        r = math.random(1, @weight)
        for def in *@defs
            r -= def.weight
            if r <= 0
                return def


return {:PolyDef, :PolyDefCollection}
