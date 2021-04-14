local Object = require 'lib/classic'
local M = require 'lib/moses'

local Area = Object:extend()
local OBJ_DIR = 'obj/'

function Area:new(room)
    self.room = room
    self.game_objects = {}
end

function Area:update(dt)
    -- One important thing here is that the loop is happening backwards,
    -- from the end of the list to the start. This is because if
    -- you remove elements from a Lua table while moving forward in
    -- it it will end up skipping some elements, as this discussion shows.
    -- http://stackoverflow.com/questions/12394841/safely-remove-items-from-an-array-table-while-iterating
    for i = #self.game_objects, 1, -1 do
        local game_object = self.game_objects[i]
        game_object:update(dt)

        if game_object.dead then
            table.remove(self.game_objects, i)
        end
    end
end

function Area:draw()
    for _, game_object in ipairs(self.game_objects) do
        game_object:draw()
    end
end

function Area:addGameObject(game_object_type, x, y, opts)
    local opts = opts or {}
    local game_object = require(OBJ_DIR .. game_object_type)(self, x or 0, y or 0, opts)
    table.insert(self.game_objects, game_object)
    return game_object
end

function Area:getGameObjects(fn)
    return M.select(self.game_objects, fn)
end

return Area