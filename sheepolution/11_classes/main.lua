function love.load()
    Object = require 'lib.classic'
    require 'rectangle'

    r1 = Rectangle()
    r2 = Rectangle()
end

function love.update(dt)
    -- r1.update(r1, dt)
    r1:update(dt) -- equivalent of above; passes self as first argument
end

function love.draw()
    r1:draw()
end