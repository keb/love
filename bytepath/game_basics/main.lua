local vars = require 'vars'
local utils = require 'engine.utils'
local RoomManager = require 'engine.RoomManager'
local Camera = require 'lib.camera'
local baton = require 'lib.baton'

local input
local rooms
camera = Camera() -- global camera

function love.load()
    input = baton.new({
        controls = {
            collect_garbage = { 'key:f1' },
            go_to_stage = { 'key:f2' },
            destroy_current_room = { 'key:f3' }
        }
    })

    rooms = RoomManager()

    -- scale window
    resize(3)

    -- adjust filter mode and line style for pixelated look
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.graphics.setLineStyle('rough')
end

function love.update(dt)
    if rooms.current_room then rooms.current_room:update(dt) end
    camera:update(dt)
    input:update()

    if input:pressed('collect_garbage') then utils.collectGarbage() end
    if input:pressed('go_to_stage') then rooms:goToRoom('Stage') end
    if input:pressed('destroy_current_room') then rooms:destroyCurrentRoom() end
end

function love.draw()
    if rooms.current_room then rooms.current_room:draw() end
end

function resize(s)
    love.window.setMode(s * vars.gw, s * vars.gh)
    vars.sx, vars.sy = s, s
end

