module = {}


function module.bind(obj, f, ...)
    return function(...) f(obj, ...) end
end

function module.select(list)
    return list[math.random(1, #list)]
end

function module.copy(orig)
    -- Taken from http://lua-users.org/wiki/CopyTable
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end


return module
