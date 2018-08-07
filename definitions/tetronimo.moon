-- This file only contains the three tetronimoes, as the other two are already
-- part of the base game.


polies = {}


polies.tet_L = {
    weight: 2
    color: 'one'
    {0, 0}
    {0, 1}
    {0, 2}
    {1, 2}
}

polies.tet_T = {
    weight: 2
    color: 'one'
    {0, 0}
    {0, 1}
    {1, 1}
    {1, 2}
}

polies.tet_S = {
    weight: 2
    color: 'one'
    {0, 0}
    {1, 0}
    {2, 0}
    {1, 1}
}


return polies
