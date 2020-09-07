function love.load()
    img = love.graphics.newImage('assets/sheep.png')
    local width = img:getWidth()
    -- local width = img:getWidth()
    -- local height = img:getHeight()
    -- print(width)
    -- print(height)
    
    love.graphics.setBackgroundColor(1, 1, 1)
end

function love.draw()
    love.graphics.setColor(1, 0.78, 0.15, 0.5)
    love.graphics.draw(img, 100, 100)
    
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(img, 200, 200)
end