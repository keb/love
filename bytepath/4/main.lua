-- https://github.com/a327ex/blog/issues/18
local Input = require 'lib/input'

local current_room
local input

function love.load()
    input = Input()
    current_room = nil

    gotoRoom('ShapeRoom')
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

function printTable(t)
    for index, data in ipairs(t) do
        print(index)

        for key, value in pairs(data) do
            print('\t', key, value)
        end
    end
end

function printAll(...)
    print(...)
end

function printText(...)
    local arg = {...}
    local str = ''
    for i = 1, #arg do
        str = str .. arg[i]
    end
    print(str)
end

-- collect garbage like this; runs a single garbage collection cycle
-- collectgarbage("collect") 

-- show memory like
-- collectgarbage("count")

-- throw errors like this
-- error('Custom Message')
-- can go up the callstack like
-- error('Custom Message', 1) -- or 2,3,4, etc.