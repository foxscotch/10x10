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
    color: 'one'
    groups: {'classic', 'monomino'}
    transform: 'none'
    weight: 2
    {0, 0}
}

polies.two = {
    color: 'two'
    groups: {'classic', 'domino'}
    transform: 'rotate_once'
    weight: 3
    {0, 0}
    {1, 0}
}

polies.three = {
    color: 'thr'
    groups: {'classic', 'trominoes'}
    transform: 'rotate_once'
    weight: 3
    {0, 0}
    {1, 0}
    {2, 0}
}

polies.four = {
    color: 'fou'
    groups: {'classic', 'tetrominoes'}
    transform: 'rotate_once'
    weight: 2
    {0, 0}
    {1, 0}
    {2, 0}
    {3, 0}
}

polies.five = {
    color: 'fiv'
    groups: {'classic', 'pentominoes'}
    transform: 'rotate_once'
    weight: 2
    {0, 0}
    {1, 0}
    {2, 0}
    {3, 0}
    {4, 0}
}

polies.small_square = {
    color: 'ssm'
    groups: {'classic', 'tetrominoes'}
    transform: 'none'
    weight: 6
    {0, 0}
    {1, 0}
    {1, 1}
    {0, 1}
}

polies.large_square = {
    color: 'slg'
    groups: {'classic'}
    transform: 'none'
    weight: 2
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
    color: 'csm'
    groups: {'classic', 'trominoes'}
    transform: 'rotate_all'
    weight: 2
    {1, 0}
    {0, 0}
    {0, 1}
}

polies.large_corner = {
    color: 'clg'
    groups: {'classic', 'pentominoes'}
    transform: 'rotate_all'
    weight: 1
    {2, 0}
    {1, 0}
    {0, 0}
    {0, 1}
    {0, 2}
}

polies.tet_L = {
    color: 'one'
    groups: {'tetrominoes'}
    transform: 'rotate_all_and_reflect'
    weight: 2
    {0, 0}
    {0, 1}
    {0, 2}
    {1, 2}
}

polies.tet_T = {
    color: 'one'
    groups: {'tetrominoes'}
    transform: 'rotate_all'
    weight: 2
    {0, 0}
    {1, 0}
    {2, 0}
    {1, 1}
}

polies.tet_S = {
    color: 'one'
    groups: {'tetrominoes'}
    transform: 'rotate_once_and_reflect'
    weight: 2
    {0, 0}
    {0, 1}
    {1, 1}
    {1, 2}
}

polies.pent_F = {
    color: 'one'
    groups: {'pentominoes'}
    transform: 'rotate_all_and_reflect'
    weight: 1
    {1, 0}
    {2, 0}
    {0, 1}
    {1, 1}
    {1, 2}
}

polies.pent_L = {
    color: 'one'
    groups: {'pentominoes'}
    transform: 'rotate_all_and_reflect'
    weight: 1
    {0, 0}
    {0, 1}
    {0, 2}
    {0, 3}
    {1, 3}
}

polies.pent_N = {
    color: 'one'
    groups: {'pentominoes'}
    transform: 'rotate_all_and_reflect'
    weight: 1
    {1, 0}
    {1, 1}
    {0, 2}
    {1, 2}
    {0, 3}
}

polies.pent_P = {
    color: 'one'
    groups: {'pentominoes'}
    transform: 'rotate_all_and_reflect'
    weight: 1
    {0, 0}
    {1, 0}
    {0, 1}
    {1, 1}
    {0, 2}
}

polies.pent_T = {
    color: 'one'
    groups: {'pentominoes'}
    transform: 'rotate_all'
    weight: 1
    {0, 0}
    {1, 0}
    {2, 0}
    {1, 1}
    {1, 2}
}

polies.pent_U = {
    color: 'one'
    groups: {'pentominoes'}
    transform: 'rotate_all'
    weight: 1
    {0, 0}
    {0, 1}
    {1, 1}
    {2, 1}
    {1, 0}
}

polies.pent_W = {
    color: 'one'
    groups: {'pentominoes'}
    transform: 'rotate_all'
    weight: 1
    {2, 0}
    {2, 1}
    {1, 1}
    {1, 2}
    {0, 2}
}

polies.pent_X = {
    color: 'one'
    groups: {'pentominoes'}
    transform: 'none'
    weight: 1
    {1, 0}
    {0, 1}
    {1, 1}
    {2, 1}
    {1, 2}
}

polies.pent_Y = {
    color: 'one'
    groups: {'pentominoes'}
    transform: 'rotate_all_and_reflect'
    weight: 1
    {1, 0}
    {0, 1}
    {1, 1}
    {1, 2}
    {1, 3}
}

polies.pent_Z = {
    color: 'one'
    groups: {'pentominoes'}
    transform: 'rotate_once_and_reflect'
    weight: 1
    {0, 0}
    {1, 0}
    {1, 1}
    {1, 2}
    {2, 2}
}


return polies
