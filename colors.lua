local colors = {}

function colors.convert_theme(theme)
    local new_theme = {}
    for name, color in pairs(theme) do
        new_theme[name] = colors.to_floats(color)
    end
    return new_theme
end

function colors.to_floats(color)
    local red = color[1] / 255
    local green = color[2] / 255
    local blue = color[3] / 255
    local alpha = 1
    if color[4] then
        alpha = color[4] / 255
    end
    return {red, green, blue, alpha}
end

-- Theme interface
colors.Theme = colors.convert_theme({
    -- Main UI colors
    bg={0, 0, 0},
    stars={0, 0, 0},
    score={0, 0, 0},
    high={0, 0, 0},
    pause={0, 0, 0},

    -- Block colors, the first of which is the default
    def={0, 0, 0},
    one={0, 0, 0},  -- 1x1
    two={0, 0, 0},  -- 1x2
    thr={0, 0, 0},  -- 1x3
    fou={0, 0, 0},  -- 1x4
    fiv={0, 0, 0},  -- 1x5
    ssm={0, 0, 0},  -- small square (2x2)
    slg={0, 0, 0},  -- large square (3x3)
    csm={0, 0, 0},  -- small corner
    clg={0, 0, 0}   -- large corner
})

colors.Light = colors.convert_theme({
    bg={255, 255, 255},
    stars={238, 149, 74},
    score={92, 189, 227},
    high={153, 220, 91},
    pause={245, 201, 163},

    def={255, 255, 255},
    one={123, 135, 193},
    two={255, 198, 63},
    thr={238, 148, 73},
    fou={232, 107, 132},
    fiv={220, 102, 85},
    ssm={151, 222, 85},
    slg={78, 214, 176},
    csm={89, 203, 135},
    clg={92, 189, 228}
})

colors.Dark = colors.convert_theme({
    bg={28, 28, 28},
    stars={238, 149, 74},  -- same as Light
    score={92, 113, 227},
    high={147, 213, 83},
    pause={254, 254, 254},

    -- All block colors are the same as Light. I need to figure out a way to
    -- inherit instead of just sticking the same colors in again.
    def={255, 255, 255},
    one={123, 135, 193},
    two={255, 198, 63},
    thr={238, 148, 73},
    fou={232, 107, 132},
    fiv={220, 102, 85},
    ssm={151, 222, 85},
    slg={78, 214, 176},
    csm={89, 203, 135},
    clg={92, 189, 228}
})

colors.Soft = colors.convert_theme({
    bg={221, 224, 203},
    stars={191, 150, 115},
    score={147, 156, 169},
    high={190, 187, 201},
    pause={254, 254, 254},  -- same as Dark

    one={117, 101, 179},
    two={165, 115, 184},
    thr={201, 135, 109},
    fou={201, 108, 134},
    fiv={183, 115, 170},
    ssm={102, 156, 94},
    slg={92, 152, 173},
    csm={144, 177, 97},
    clg={102, 123, 178},
})

colors.cool_pink = colors.to_floats({255, 0, 85})

return colors
