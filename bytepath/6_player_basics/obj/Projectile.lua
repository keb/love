local GameObject = require 'engine.GameObject'
local utils = require 'engine.utils';
local vars = require 'vars'

local Projectile = GameObject:extend()

function Projectile:new(area, x, y, opts)
    Projectile.super.new(self, area, x, y, opts)

    self.radius = opts.radius or 2.5
    self.v = opts.v or 200
    self.max_v = 400
    self.a = 400

    -- alternative way to accelerate over 0.5 sec
    -- my current way doesn't ensure it's over 0.5 sec
    -- self.timer:tween(0.5, self, { v = self.max_v }, 'linear')

    self.collider = self.area.world:newCircleCollider(self.x, self.y, self.radius)
    self.collider:setObject(self)
    self.collider.body:setLinearVelocity(
        self.v * math.cos(self.parentRotation),
        self.v * math.sin(self.parentRotation)
    )
end

function Projectile:update(dt)
    Projectile.super.update(self, dt)

    if self.x < 0 then self:kill() end
    if self.y < 0 then self:kill() end
    if self.x > vars.gw then self:kill() end
    if self.y > vars.gh then self:kill() end

    -- accelerate
    self.v = math.min(self.v + self.a * dt, self.max_v)

    self.collider.body:setLinearVelocity(
        self.v * math.cos(self.parentRotation),
        self.v * math.sin(self.parentRotation)
    )
end

function Projectile:draw()
    love.graphics.setColor(vars.colors.default_color)
    love.graphics.circle('line', self.x, self.y, self.radius)
end

function Projectile:kill()
    Projectile.super.kill(self) -- can't do Project.super:kill() cuz that would just pass GameObject to itself?
    self.area:addGameObject('fx.ProjectileDeathEffect', self.x, self.y, {
        first_color = vars.colors.default_color,
        second_color = vars.colors.hp_color,
        w = (3 * self.radius)
    })
end

return Projectile