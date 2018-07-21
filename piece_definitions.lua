-- A piece definition is a simple array of coordinates relative to the piece's
-- origin. A block is present at each coordinate. The origin is ALWAYS the top
-- left block of any piece, however, a block does not have to actually exist in
-- that origin. Furthermore, a definition should also contain a "weight", which
-- represents the piece's likelihood to be given to the player. Higher is more
-- likely. Definitions for classic 1010! pieces follow.

local pieces = {}

pieces.one = {
    weight=2,
    {0, 0}
}

pieces.two = {
    weight=3,
    {0, 0},
    {1, 0}
}  -- +1 rotation

pieces.thr = {
    weight=3,
    {0, 0},
    {1, 0},
    {2, 0}
}  -- +1 rotation

pieces.fou = {
    weight=2,
    {0, 0},
    {1, 0},
    {2, 0},
    {3, 0}
}  -- +1 rotation

pieces.fiv = {
    weight=2,
    {0, 0},
    {1, 0},
    {2, 0},
    {3, 0},
    {4, 0}
}  -- +1 rotation

x x
x x        ssm, 6

x x x
x x x
x x x      slg, 2

x x
x          csm, 2 (*4 rotations)

x
x
x x x      clg, 1 (*4 rotations)


return pieces
