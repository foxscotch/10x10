colors = {}


-- Color class that just converts from 0-255 to 0.0-1.0
-- Instances should be considered immutable
class colors.Color
    new: (red, green, blue, alpha) =>
        @red = red / 255
        @green = green / 255
        @blue = blue / 255

        if alpha
            @alpha = alpha / 255
        else
            @alpha = 1

        @[1], @[2], @[3], @[4] = @red, @green, @blue, @alpha

-- Shortcut alias for theme definitions
C = colors.Color


-- Theme interface
class BaseTheme
    -- Main UI colors
    bg:    C(0, 0, 0)
    stars: C(0, 0, 0)
    score: C(0, 0, 0)
    high:  C(0, 0, 0)
    pause: C(0, 0, 0)

    -- Block colors
    def: C(0, 0, 0)  -- default / empty block
    one: C(0, 0, 0)  -- 1x1
    two: C(0, 0, 0)  -- 1x2
    thr: C(0, 0, 0)  -- 1x3
    fou: C(0, 0, 0)  -- 1x4
    fiv: C(0, 0, 0)  -- 1x5
    ssm: C(0, 0, 0)  -- small square (2x2)
    slg: C(0, 0, 0)  -- large square (3x3)
    csm: C(0, 0, 0)  -- small corner
    clg: C(0, 0, 0)  -- large corner


class colors.Light extends BaseTheme
    bg:    C(255, 255, 255)
    stars: C(238, 149,  74)
    score: C( 92, 189, 227)
    high:  C(153, 220,  91)
    pause: C(245, 201, 163)

    def: C(227, 227, 227)
    one: C(123, 135, 193)
    two: C(255, 198,  63)
    thr: C(238, 148,  73)
    fou: C(232, 107, 132)
    fiv: C(220, 102,  85)
    ssm: C(151, 222,  85)
    slg: C( 78, 214, 176)
    csm: C( 89, 203, 135)
    clg: C( 92, 189, 228)


class colors.Dark extends colors.Light
    bg:    C( 28,  28,  28)
    score: C( 92, 113, 227)
    high:  C(147, 213,  83)
    pause: C(254, 254, 254)

    def: C(54, 54, 54)


class colors.Soft extends colors.Dark
    bg:    C(221, 224, 203)
    stars: C(191, 150, 115)
    score: C(147, 156, 169)
    high:  C(190, 187, 201)

    def: C(201, 205, 193)
    one: C(117, 101, 179)
    two: C(165, 115, 184)
    thr: C(201, 135, 109)
    fou: C(201, 108, 134)
    fiv: C(183, 115, 170)
    ssm: C(102, 156,  94)
    slg: C( 92, 152, 173)
    csm: C(144, 177,  97)
    clg: C(102, 123, 178)


-- Individual colors (just because I like them)

colors.cool_pink = C(255, 0, 85)


return colors
