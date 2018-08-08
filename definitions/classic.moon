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


polies = {}


polies.one = {
    weight: 2
    color: 'one'
    transform: 'none'
    {0, 0}
}

polies.two = {
    weight: 3
    color: 'two'
    transform: 'rotate_once'
    {0, 0}
    {1, 0}
}

polies.three = {
    weight: 3
    color: 'thr'
    transform: 'rotate_once'
    {0, 0}
    {1, 0}
    {2, 0}
}

polies.four = {
    weight: 2
    color: 'fou'
    transform: 'rotate_once'
    {0, 0}
    {1, 0}
    {2, 0}
    {3, 0}
}

polies.five = {
    weight: 2
    color: 'fiv'
    transform: 'rotate_once'
    {0, 0}
    {1, 0}
    {2, 0}
    {3, 0}
    {4, 0}
}

polies.ssm = {
    weight: 6
    color: 'ssm'
    transform: 'none'
    {0, 0}
    {1, 0}
    {1, 1}
    {0, 1}
}

polies.slg = {
    weight: 2
    color: 'slg'
    transform: 'none'
    {0, 0}
    {1, 0}
    {2, 0}
    {2, 1}
    {2, 2}
    {1, 2}
    {0, 2}
    {0, 1}
    {1, 1}
}

polies.small_corner = {
    weight: 2
    color: 'csm'
    transform: 'rotate_all'
    {1, 0}
    {0, 0}
    {0, 1}
}

polies.large_corner = {
    weight: 1
    color: 'clg'
    transform: 'rotate_all'
    {2, 0}
    {1, 0}
    {0, 0}
    {0, 1}
    {0, 2}
}


return polies
