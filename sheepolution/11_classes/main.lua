function love.load()
    local Circle = require 'Circle'
    local Rectangle = require 'Rectangle'

    r1 = Rectangle(100, 100, 200, 50)
    r2 = Circle(350, 80, 40)
end

function love.update(dt)
    -- r1.update(r1, dt)
    r1:update(dt) -- equivalent of above; passes self as first argument
    r2:update(dt)
end

function love.draw()
    r1:draw()
    r2:draw()
end