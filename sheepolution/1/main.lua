function love.load()
    -- square coordinates
    x = 100
    y = 50

    -- tables
    fruits = {'apple', 'banana', 'cherry', 'pear'}
    table.insert(fruits, 'orange')
    print(#fruits) -- outputs length of table, so in this case, 5

    -- lesson 8
    -- objects
    listOfRectangles = {}
end

function createRect()
    -- lesson 8
    rect = {}
    rect.x = 100
    rect.y = 100
    rect.width = 70
    rect.height = 90
    rect.speed = 100
    return rect
end

function love.keypressed(key)
    if key == 'space' then
        table.insert(listOfRectangles, createRect())
    end
end

function love.update(dt)
    -- lessons 1- 7
    -- up = love.keyboard.isDown('up')
    -- down = love.keyboard.isDown('down')
    -- right = love.keyboard.isDown('right')
    -- left = love.keyboard.isDown('left')

    -- if right then
    --     x = x + (100 * dt)
    -- elseif left then
    --     x = x - (100 * dt)
    -- end

    -- rect.x = rect.x + rect.speed * dt

    -- lesson 8
    for i,v in ipairs(listOfRectangles) do
        v.x = v.x + v.speed * dt
    end
end

function love.draw()
    -- lessons 1 - 7
    -- love.graphics.rectangle('line', rect.x, rect.y, rect.width, rect.height)

    -- -- for i = 1, #fruits do
    -- --     love.graphics.print(fruits[i], 100, 100 + 50 * i)
    -- -- end
    -- -- or do this:
    -- for i, fruit in ipairs(fruits) do
    --     love.graphics.print(fruit, 100, 100 + 50 * i)
    -- end

    -- lesson 8
    for i,v in ipairs(listOfRectangles) do
        love.graphics.rectangle('line', v.x, v.y, v.width, v.height)
    end
end