-- A poly definition is a simple array of coordinates relative to the poly's
-- origin. A block is present at each coordinate. The origin is ALWAYS the top
-- left block of any piece, however, a block does not have to actually exist in
-- that origin.

-- A definition should also contain a "weight", which represents the poly's
-- likelihood to be given to the player, relative to the total sum of every 
-- poly's weight. Higher is more likely.

-- Lastly, a definition should contain a color, which is a color name defined in
-- colors.lua.


-- Definitions for classic 1010! polies follow.


local polies = {}


------------
-- Single --
------------

polies.one = {
    weight=2,
    color='one',
    {0, 0}
}


----------------
-- Horizontal --
----------------

polies.twoH = {
    weight=3,
    color='two',
    {0, 0},
    {1, 0}
}

polies.thrH = {
    weight=3,
    color='thr',
    {0, 0},
    {1, 0},
    {2, 0}
}

polies.fouH = {
    weight=2,
    color='fou',
    {0, 0},
    {1, 0},
    {2, 0},
    {3, 0}
}

polies.fivH = {
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

polies.twoV = {
    weight=3,
    color='two',
    {0, 1},
    {0, 2}
}

polies.thrV = {
    weight=3,
    color='thr',
    {0, 1},
    {0, 2},
    {0, 3}
}

polies.fouV = {
    weight=2,
    color='fou',
    {0, 1},
    {0, 2},
    {0, 3},
    {0, 4}
}

polies.fivV = {
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

polies.ssm = {
    weight=6,
    color='ssm',
    {0, 0},
    {1, 0},
    {1, 1},
    {0, 1},
}

polies.slg = {
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

polies.csmNW = {
    weight=2,
    color='csm',
    {1, 0},
    {0, 0},
    {0, 1}
}

polies.csmNE = {
    weight=2,
    color='csm',
    {0, 0},
    {1, 0},
    {1, 1}
}

polies.csmSW = {
    weight=2,
    color='csm',
    {0, 0}
    {0, 1},
    {1, 1}
}

polies.csmSE = {
    weight=2,
    color='csm',
    {0, 1},
    {1, 1},
    {1, 0}
}


------------------
-- Corner Large --
------------------

polies.clgNW = {
    weight=1,
    color='clg',
    {2, 0},
    {1, 0},
    {0, 0},
    {0, 1},
    {0, 2}
}

polies.clgNE = {
    weight=1,
    color='clg',
    {0, 0},
    {1, 0},
    {2, 0},
    {2, 1},
    {2, 2}
}

polies.clgSW = {
    weight=1,
    color='clg',
    {0, 0},
    {0, 1},
    {0, 2},
    {1, 2},
    {2, 2}
}

polies.clgSE = {
    weight=1,
    color='clg',
    {0, 2},
    {1, 2},
    {2, 2},
    {2, 1},
    {2, 0},
}


return polies
