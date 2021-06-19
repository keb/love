local vars = require 'vars'
local GameObject = require 'engine.GameObject'
local ProjectileDeathEffect = GameObject:extend()

function ProjectileDeathEffect:new(area, x, y, opts)
    ProjectileDeathEffect.super.new(self, area, x, y, opts)

    self.first = true

    self.timer:after(0.1, function()
        self.first = false
        self.second = true
        self.timer:after(0.15, function()
            self.second = false
            self:kill()
        end)
    end)
end

function ProjectileDeathEffect:update(dt)
    ProjectileDeathEffect.super.update(self, dt)
end

function ProjectileDeathEffect:draw()
    -- love.graphics.circle(self.drawMode, self.x, self.y, self.radius)
    if self.first then
        love.graphics.setColor(self.first_color)
    elseif self.second then
        love.graphics.setColor(self.second_color)
    end

    love.graphics.rectangle('fill', self.x - self.w / 2, self.y - self.w / 2, self.w, self.w)
end

return ProjectileDeathEffect
