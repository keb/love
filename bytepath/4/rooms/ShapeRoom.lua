local Object = require 'lib/classic'
local Area = require 'engine/Area'
local Input = require 'lib/input'

local ShapeRoom = Object:extend()

function ShapeRoom:new()
    self.area = Area(ShapeRoom)
    self.input = Input()
    local rectangles = self:generateRectangles()

    self.input:bind('d', function()
        local idx = love.math.random(1, #rectangles)
        local rectangleRef = rectangles[idx]
        rectangleRef:kill()
        table.remove(rectangles, idx)
        if #rectangles == 0 then
            rectangles = self:generateRectangles()
        end
    end)
end

function ShapeRoom:update(dt)
    self.area:update(dt)
end

function ShapeRoom:draw()
    self.area:draw()
end

function ShapeRoom:generateRectangles()
    local props = {}
    local rectangles = {}

    for i = 1, 10 do
        table.insert(props, {
            x = love.math.random(0, love.graphics.getWidth()),
            y = love.math.random(0, love.graphics.getHeight()),
            width = love.math.random(22, 38),
            height = love.math.random(4, 20)
        })
    end

    for _, prop in pairs(props) do
        local rectangleRef = self.area:addGameObject('Rectangle',
            prop.x,
            prop.y,
            { width = prop.width, height = prop.height }
        )

        table.insert(rectangles, rectangleRef)
    end

    return rectangles
end

return ShapeRoom