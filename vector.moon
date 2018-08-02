class Vector
    new: (@x, @y) =>

    __add: (v) =>
        Vector @x+v.x, @y+v.y

    __sub: (v) =>
        Vector @x-v.x, @y-v.y

    __mul: (v) =>
        if type(v) == 'number'
            Vector @x*v, @y*v
        else
            Vector @x*v.x, @y*v.y
    
    clone: =>
        Vector @x, @y


return Vector
