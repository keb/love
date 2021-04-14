local Object = require 'lib/classic'

local RectangleRoom = Object:extend()

function RectangleRoom:new()

end

function RectangleRoom:update(dt)

end

function RectangleRoom:draw()
    love.graphics.rectangle('fill', 400, 300, 400, 160)
end

return RectangleRoom