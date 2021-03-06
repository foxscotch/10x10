require 'moonscript'


-- Using os.time() didn't seem to return random values. So, this instead.
d = os.date('*t')
math.randomseed(d.hour * d.min * d.sec)


function love.conf(t)
    t.window.title = '10x10'
    t.window.width = 896
    t.window.height = 504
    t.window.vsync = 0
    t.window.msaa = 4
    
    t.modules.joystick = false
    t.modules.physics = false
end
