local Object = require 'lib/classic'
local Circle = require 'obj/Circle'

local CircleRoom = Object:extend()

local circle

function CircleRoom:new()
    circle = Circle(400, 300, 50)
end

function CircleRoom:update(dt)

end

function CircleRoom:draw()
    circle:draw()
end

return CircleRoom