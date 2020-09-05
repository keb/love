love.load = ->
    image = love.graphics.newImage('cake.png')

love.draw = ->
    love.graphics.draw(image, 50, 50)
    -- love.graphics.print('this text is not black because of the line below', 100, 100)
    -- love.graphics.setColor(255, 0, 0)
    -- love.graphics.print('this text is red', 100, 200)
    -- moonc -w -t .\build\ main.moon