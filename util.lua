module = {}


function module.bind(obj, f, ...)
    return function(...) f(obj, ...) end
end


return module
