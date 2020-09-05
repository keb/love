function love.load()
    tick = require 'lib.tick'

    -- create boolean
    drawRectangle = false
    tick.delay(function () drawRectangle = true end, 2)

    x = 30
    y = 50
end

function love.update(dt)
    tick.update(dt)
end

function love.keypressed(key)
    if key == 'space' then
        -- x and y become a random number between 100 and 500
        x = math.random(100, 500)
        y = math.random(100, 500)
    end
end

function love.draw()
    if drawRectangle then
        love.graphics.rectangle('fill', 100, 100, 300, 200)
    end

    love.graphics.rectangle('line', x, y, 100, 100)
end