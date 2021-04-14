local GameObject = require 'engine/GameObject'
local Circle = GameObject:extend()

function Circle:new(area, x, y, opts)
    Circle.super.new(self, area, x, y, opts)
end

function Circle:update(dt)
    Circle.super.update(self, dt)
end

function Circle:draw()
    love.graphics.circle('fill', self.x, self.y, self.radius)
end

return Circle