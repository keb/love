local Object = require 'lib/classic'
local Area = require 'areas/Area'
local Timer = require 'lib/timer'

local Stage = Object:extend()

function Stage:new()
    self.area = Area(Stage)
    self.timer = Timer()

    self.timer:every(2, function()
        local x = love.math.random(0, love.graphics.getWidth())
        local y = love.math.random(0, love.graphics.getHeight())
        local radius = love.math.random(50, 150)
        self.area:addGameObject('Circle', x, y, { radius = radius })
    end)
end

function Stage:update(dt)
    self.area:update(dt)
    self.timer:update(dt)
end

function Stage:draw()
    self.area:draw()
end

return Stage