local Input = require 'lib/input'
local Timer = require 'lib/timer'
local M = require 'lib/moses'
local F = require 'lib/f'
local HyperCircle = require 'obj/HyperCircle'

-- local circle
local hyperCircle
local input
local sum = 0
local timer

local rect_1
local rect_2

local hp_1
local hp_2

local circle

local a
local b
local c
local d

function love.load()
    print('LOVE loaded...')
    -- circle = Circle(400, 300, 50)

    -- counter_table = createCounterTable()
    -- counter_table:increment()
    -- print(counter_table.value)

    -- foo = createFoo()
    -- foo:sum()
    -- print(foo.c)

    input = Input()
    -- input:bind('d', 'lower_hp')
    -- input:bind('dpdown', 'add')
    -- hyperCircle = HyperCircle(400, 300, 50, 10, 120)

    timer = Timer()
    
    -- e = 10
    -- timer:tween(1, _G, { e = 20 }, 'linear', function() print(a) end)

    circle = { radius = 24 }
    -- local circleTimer

    -- input:bind('e', function()
    --     if (circleTimer ~= nil) then timer:cancel(circleTimer) end
    --     circleTimer = timer:tween(6, circle, { radius = 96 }, 'in-out-cubic')
    -- end)

    -- input:bind('s', function()
    --     if (circleTimer ~= nil) then timer:cancel(circleTimer) end
    --     circleTimer = timer:tween(6, circle, { radius = 24 }, 'in-out-cubic')
    -- end)


    function animateCircle()
        print('animating...')
        timer:after(2, function()
            timer:tween(6, circle, {radius = 96}, 'in-out-cubic', function()
                timer:tween(6, circle, {radius = 24}, 'in-out-cubic', function() animateCircle() end)
            end)
        end)
    end

    -- animateCircle()


    -- rect_1 = {x = 400, y = 300, w = 50, h = 200}
    -- rect_2 = {x = 400, y = 300, w = 200, h = 50}

    -- hp_1 = {x = 400, y = 300, w = 200, h = 50}
    -- hp_2 = {x = 400, y = 300, w = 200, h = 50}

    -- timer:tween(1, rect_1, { w = 0 }, 'in-out-cubic', function()
    --     timer:tween(1, rect_2, { h = 0 }, 'in-out-cubic', function()
    --         timer:tween(2, rect_1, { w = 50 }, 'in-out-cubic')
    --         timer:tween(2, rect_2, { h = 50 }, 'in-out-cubic')
    --     end)
    -- end)

    a = {1, 2, '3', 4, '5', 6, 7, true, 9, 10, 11, a = 1, b = 2, c = 3, {1, 2, 3}}
    b = {1, 1, 3, 4, 5, 6, 7, false}
    c = {'1', '2', '3', 4, 5, 6}
    d = {1, 4, 3, 4, 5, 6}

    M.each(a, print)
    print(F"number of 1s in b: {M.count(b, 1)}")
    -- d = M.map(d, function(v) return v + 1 end)
    -- M.each(d, print)

    print('printing a again...')
    a = M.map(a, function(v)
        if (type(v) == 'string') then return v .. ' xD' end
        if (type(v) == 'number') then return v * 2 end
        if (type(v) == 'boolean') then return not v end
        if (type(v) == 'table') then return nil end
        return v
    end)

    M.each(a, print)

    print('getting sum of d...')
    d = M.reduce(d, function(a, b) return a + b end, 0)
    print(d)
end

function love.update(dt)
    -- circle:update(dt)
    -- hyperCircle:update(dt)

    -- if input:down('add', 0.25) then
    --     sum = sum + 1
    --     print(sum)
    -- end

    -- if input:pressed('lower_hp') then
    --     timer:tween(1.2, hp_1, { w = hp_1.w - 25, x = hp_1.x - (25 / 2) }, 'in-out-cubic')
    --     timer:tween(0.4, hp_2, { w = hp_2.w - 25, x = hp_2.x - (25 / 2) }, 'in-out-cubic')
    -- end

    timer:update(dt)
end

function love.draw()
    -- circle:draw()
    -- hyperCircle:draw()
    -- love.graphics.rectangle('fill', rect_1.x - rect_1.w/2, rect_1.y - rect_1.h/2, rect_1.w, rect_1.h)
    -- love.graphics.rectangle('fill', rect_2.x - rect_2.w/2, rect_2.y - rect_2.h/2, rect_2.w, rect_2.h)

    -- love.graphics.setColor(1, 0.1, 0.1)
    -- love.graphics.rectangle('fill', hp_1.x - hp_1.w/2, hp_1.y - hp_1.h/2, hp_1.w, hp_1.h)

    -- love.graphics.setColor(1, 0.5, 0.5)
    -- love.graphics.rectangle('fill', hp_2.x - hp_2.w/2, hp_2.y - hp_2.h/2, hp_2.w, hp_2.h)

    love.graphics.circle('fill', 400, 300, circle.radius)
end

function createCounterTable()
    return {
        value = 1,
        increment = function(self) self.value = self.value + 1 end
    }
end

function createFoo()
    return {
        a = 1,
        b = 2,
        c = 3,
        sum = function(self) self.c = self.a + self.b + self.c end
    }
end