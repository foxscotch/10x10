-- A piece definition is a simple array of coordinates relative to the piece's
-- origin. A block is present at each coordinate. The origin is ALWAYS the top
-- left block of any piece, however, a block does not have to actually exist in
-- that origin.

-- A definition should also contain a "weight", which represents the piece's
-- likelihood to be given to the player, relative to the total sum of every 
-- piece's weight. Higher is more likely.

-- Lastly, a definition should contain a color, which is a color name defined in
-- colors.lua.


-- Definitions for classic 1010! pieces follow.


local pieces = {}


------------
-- Single --
------------

pieces.one = {
    weight=2,
    color='one',
    {0, 0}
}


----------------
-- Horizontal --
----------------

pieces.twoH = {
    weight=3,
    color='two',
    {0, 0},
    {1, 0}
}

pieces.thrH = {
    weight=3,
    color='thr',
    {0, 0},
    {1, 0},
    {2, 0}
}

pieces.fouH = {
    weight=2,
    color='fou',
    {0, 0},
    {1, 0},
    {2, 0},
    {3, 0}
}

pieces.fivH = {
    weight=2,
    color='fiv',
    {0, 0},
    {1, 0},
    {2, 0},
    {3, 0},
    {4, 0}
}


--------------
-- Vertical --
--------------

pieces.twoV = {
    weight=3,
    color='two',
    {0, 1},
    {0, 2}
}

pieces.thrV = {
    weight=3,
    color='thr',
    {0, 1},
    {0, 2},
    {0, 3}
}

pieces.fouV = {
    weight=2,
    color='fou',
    {0, 1},
    {0, 2},
    {0, 3},
    {0, 4}
}

pieces.fivV = {
    weight=2,
    color='fiv',
    {0, 1},
    {0, 2},
    {0, 3},
    {0, 4},
    {0, 5}
}


-------------
-- Squares --
-------------

pieces.ssm = {
    weight=6,
    color='ssm',
    {0, 0},
    {1, 0},
    {1, 1},
    {0, 1},
}

pieces.slg = {
    weight=2,
    color='slg',
    {0, 0},
    {1, 0},
    {2, 0},
    {2, 1},
    {2, 2},
    {1, 2},
    {0, 2},
    {0, 1},
    {1, 1}
}


------------------
-- Corner Small --
------------------

pieces.csmNW = {
    weight=2,
    color='csm',
    {1, 0},
    {0, 0},
    {0, 1}
}

pieces.csmNE = {
    weight=2,
    color='csm',
    {0, 0},
    {1, 0},
    {1, 1}
}

pieces.csmSW = {
    weight=2,
    color='csm',
    {0, 0}
    {0, 1},
    {1, 1}
}

pieces.csmSE = {
    weight=2,
    color='csm',
    {0, 1},
    {1, 1},
    {1, 0}
}


------------------
-- Corner Large --
------------------

pieces.clgNW = {
    weight=1,
    color='clg',
    {2, 0},
    {1, 0},
    {0, 0},
    {0, 1},
    {0, 2}
}

pieces.clgNE = {
    weight=1,
    color='clg',
    {0, 0},
    {1, 0},
    {2, 0},
    {2, 1},
    {2, 2}
}

pieces.clgSW = {
    weight=1,
    color='clg',
    {0, 0},
    {0, 1},
    {0, 2},
    {1, 2},
    {2, 2}
}

pieces.clgSE = {
    weight=1,
    color='clg',
    {0, 2},
    {1, 2},
    {2, 2},
    {2, 1},
    {2, 0},
}


return pieces
