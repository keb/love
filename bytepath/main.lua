local love = love

function love.load()
    image = love.graphics.newImage('assets/pic.jpg')
end

function love.update(dt)

end

function love.draw()
    love.graphics.draw(image, 0, 0)
end