module = {}


function module.bind(obj, f, ...)
    return function(...) f(obj, ...) end
end

function module.select(list)
    return list[math.random(1, #list)]
end


return module
