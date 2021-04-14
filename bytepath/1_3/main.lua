-- https://github.com/a327ex/blog/issues/17
local Input = require 'lib/input'

local current_room
local input

function love.load()
    input = Input()

    current_room = nil
    -- gotoRoom('Stage')
    gotoRoom('Stage2')

    input:bind('f1', function() gotoRoom('CircleRoom') end)
    input:bind('f2', function() gotoRoom('RectangleRoom') end)
    input:bind('f3', function() gotoRoom('PolygonRoom') end)
end

function love.update(dt)
    if current_room then current_room:update(dt) end
end

function love.draw()
    if current_room then current_room:draw() end
end

function gotoRoom(room_type, ...)
    local roomClass = require('rooms/' .. room_type)
    current_room = roomClass(...)
end
