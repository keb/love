local Object = require 'lib/classic'
local Timer = require 'lib/timer'
local Circle_old = require 'obj/Circle_old'

local Stage2 = Object:extend()

-- Exercise 49

function Stage2:new()
    self.timer = Timer()
    self.objects = {}

    self.timer:every(2, function()
        local x = love.math.random(0, love.graphics.getWidth())
        local y = love.math.random(0, love.graphics.getHeight())
        local radius = love.math.random(50, 150)

        local circle = Circle_old(x, y, radius)
        table.insert(self.objects, circle)
        circle.dead = false

        local lifespan = love.math.random(2, 4)
        self.timer:after(lifespan, function()
            circle.dead = true
        end)
    end)
end

function Stage2:update(dt)
    self.timer:update(dt)

    for i = #self.objects, 1, -1 do
        local game_object = self.objects[i]
        game_object:update(dt)

        if game_object.dead then
            table.remove(self.objects, i)
        end
    end
end

function Stage2:draw()
    for _, game_object in ipairs(self.objects) do
        game_object:draw()
    end
end

return Stage2