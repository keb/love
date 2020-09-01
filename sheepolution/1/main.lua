function love.load()
    -- square coordinates
    x = 100
    y = 50

    -- tables
    fruits = {'apple', 'banana', 'cherry', 'pear'}
    table.insert(fruits, 'orange')
    print(#fruits) -- outputs length of table, so in this case, 5
end

function love.update(dt)
    up = love.keyboard.isDown('up')
    down = love.keyboard.isDown('down')
    right = love.keyboard.isDown('right')
    left = love.keyboard.isDown('left')

    if right then
        x = x + (100 * dt)
    elseif left then
        x = x - (100 * dt)
    end
end

function love.draw()
    love.graphics.rectangle('line', x, y, 200, 150)

    -- for i = 1, #fruits do
    --     love.graphics.print(fruits[i], 100, 100 + 50 * i)
    -- end
    -- or do this:
    for i, fruit in ipairs(fruits) do
        love.graphics.print(fruit, 100, 100 + 50 * i)
    end
end