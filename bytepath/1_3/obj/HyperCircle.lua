local Circle = require 'obj/Circle'
local HyperCircle = Circle:extend()

function HyperCircle:new(x, y, radius, line_width, outer_radius)
    HyperCircle.super.new(self, x, y, radius) -- call Circle constructor

    self.line_width = line_width
    self.outer_radius = outer_radius
end

function HyperCircle:update(dt)

end

function HyperCircle:draw()
    HyperCircle.super.draw(self)
    love.graphics.circle('line', self.x, self.y, self.outer_radius)
    love.graphics.setLineWidth(self.line_width)
end

return HyperCircle