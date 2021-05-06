local Object = require 'lib/classic'
local Area = require 'engine/Area'
local Input = require 'lib/input'
local Timer = require 'lib.timer'

local ShapeRoom = Object:extend()

function ShapeRoom:new()
    self.area = Area(ShapeRoom)
    self.input = Input()
    self.timer = Timer()
    -- local rectangles = self:generateRectangles()

    -- self.input:bind('d', function()
    --     local idx = love.math.random(1, #rectangles)
    --     local rectangleRef = rectangles[idx]
    --     rectangleRef:kill()
    --     table.remove(rectangles, idx)
    --     if #rectangles == 0 then
    --         rectangles = self:generateRectangles()
    --     end
    -- end)

    -- self:generateCircles()
end

function ShapeRoom:update(dt)
    self.area:update(dt)
    self.timer:update(dt)
end

function ShapeRoom:draw()
    self.area:draw()
end

function ShapeRoom:generateRectangles()
    local props = {}
    local rectangles = {}

    for _ = 1, 10 do
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

function ShapeRoom:generateCircles()
    local triggerAdding, triggerRemoval
    local circles = {}
    local count = 0
    local addTimer = nil
    local removeTimer = nil

    local addCircle = function()
        count = count + 1
        local ref = self.area:addGameObject('Circle',
            love.math.random(0 , love.graphics.getWidth()),
            love.math.random(0, love.graphics.getHeight()),
            { radius = love.math.random(13, 42) }
        )

        table.insert(circles, ref)
    end

    triggerAdding = function()
        if removeTimer then self.timer:cancel(removeTimer) end

        addCircle()
        addTimer = self.timer:every(0.25, function()
            if count == 10 then
                triggerRemoval()
                return false
            end

            addCircle()
        end)
    end

    triggerRemoval = function()
        if addTimer then self.timer:cancel(addTimer) end
        removeTimer = self.timer:every(love.math.random(0.5, 1.0), function()
            if count == 0 then
                triggerAdding()
                return false
            end

            local randomIdx = love.math.random(1, #circles)
            local randomCircle = circles[randomIdx]
            randomCircle:kill()
            table.remove(circles, randomIdx)
            count = count - 1
        end)
    end

    triggerAdding()
end

return ShapeRoom