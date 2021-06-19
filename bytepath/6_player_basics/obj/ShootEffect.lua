local GameObject = require 'engine.GameObject'
local utils = require 'engine.utils';

local ShootEffect = GameObject:extend()

function ShootEffect:new(area, x, y, opts)
    ShootEffect.super.new(self, area, x, y, opts)

    self.width = 8
    self.default_color = {1, 1, 1, 1}

    self.timer:tween(0.1, self, { width = 0 }, 'in-out-cubic', function()
        self:kill()
    end)
end

function ShootEffect:update(dt)
    ShootEffect.super.update(self, dt)

    if self.player then
        -- if this object has a reference to a player object that spawned it...
        -- then update the x and y position along with the player object on each tick
        self.x = self.player.x + self.distanceFromCenter * math.cos(self.player.r)
        self.y = self.player.y + self.distanceFromCenter * math.sin(self.player.r)
    end
end

function ShootEffect:draw()
    -- utils.pushRotate(self.player.x, self.player.y, math.pi / 2)
    utils.pushRotate(self.x, self.y, self.player.r + math.pi / 4)

    love.graphics.setColor(self.default_color)
    love.graphics.rectangle('fill', self.x - self.width / 2, self.y - self.width / 2, self.width, self.width)
    love.graphics.pop()
    -- love.graphics.pop()
end

return ShootEffect