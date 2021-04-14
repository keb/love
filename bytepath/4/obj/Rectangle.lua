local GameObject = require 'engine/GameObject'
local Rectangle = GameObject:extend()

function Rectangle:new(area, x, y, opts)
    Rectangle.super.new(self, area, x, y, opts)
end

function Rectangle:update(dt)
    Rectangle.super.update(self, dt)
end

function Rectangle:draw()
    love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
end

return Rectangle