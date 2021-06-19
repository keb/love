local GameObject = require 'engine.GameObject'
local baton = require 'lib.baton'
local lume =require 'lib.lume'
local utils = require 'engine.utils'

local Player = GameObject:extend()

function Player:new(area, x, y, opts)
    Player.super.new(self, area, x, y, opts)
    self.w, self.h = 12, 12
    self.collider = self.area.world:newCircleCollider(self.x, self.y, self.w)
    self.collider:setObject(self)

    -- controls
    self.input = baton.new({
        controls = { left = { 'key:left' }, right = { 'key:right' } }
    })

    -- movement
    self.r = -math.pi / 2 -- ROTATION; angle the player is moving towards, pointing up; math.pi/2 is down, -math.pi/2 is up
    self.rv = 1.66 * math.pi -- ROTATIONAL VEL; velocity of angle change when the user presses left or right
    self.v = 0 -- player's velocity
    self.max_v = 100 -- maximum velocity
    self.a = 100 -- acceleration

    -- shooting
    self.attack_speed = 1

    self.timer:every(5, function()
        self.attack_speed = utils.random(1, 2)
    end)

    local shootFn
    shootFn = function()
        self:shoot()
        self.timer:after(0.24 / self.attack_speed, shootFn)
    end

    self.timer:after(0.24 / self.attack_speed, shootFn)
end

function Player:update(dt)
    Player.super.update(self, dt)

    -- inputs
    self.input:update()
    if self.input:down('left') then
        self.r = self.r - self.rv * dt
    end

    if self.input:down('right') then
        self.r = self.r + self.rv * dt
    end

    self.v = math.min(self.v + self.a * dt, self.max_v)
    self.collider.body:setLinearVelocity(self.v * math.cos(self.r), self.v * math.sin(self.r))

    -- example of removing acceleration
    -- self.collider.body:setLinearVelocity(self.v * math.cos(self.r), self.v * math.sin(self.r))
end

function Player:draw()
    -- reverse player
    -- utils.pushRotate(self.x, self.y, math.pi)

    love.graphics.circle('line', self.x, self.y, self.w)
    --[[
        Generally whenever you want to get a position B that is
        distance units away from position A such that position B is
        positioned at a specific angle in relation to position A,
        the pattern is something like: bx = ax + distance*math.cos(angle)
        and by = ay + distance*math.sin(angle). Doing this is a very very
        common occurence in 2D gamedev (in my experience at least) and
        so getting an instinctive handle on how this works is useful.
    ]] --

    -- puts line flat against front
    -- utils.pushRotate(
    --     self.x + (self.w * math.cos(self.r)),
    --     self.y + (self.w * math.sin(self.r)),
    --     -math.pi / 2
    -- )

    -- utils.pushRotate(
    --     self.x,
    --     self.y,
    --     math.pi / 2
    -- )

    -- love.graphics.circle('line', self.x + (self.w * math.cos(self.r)), self.y + (self.w * math.sin(self.r)), 4)

    love.graphics.line(
        self.x,
        self.y,
        self.x + (2 * self.w * math.cos(self.r)),
        self.y + (2 * self.w * math.sin(self.r))
    )

    -- love.graphics.pop()
end

function Player:destroy()
    Player.super.destroy(self)

    if self.input then self.input = nil end
end

function Player:kill()
    Player.super.kill(self)

    
end

function Player:shoot()
    local distanceFromCenter = 1.2 * self.w
    local effect_x = self.x + distanceFromCenter * math.cos(self.r)
    local effect_y = self.y + distanceFromCenter * math.sin(self.r)

    self.area:addGameObject('ShootEffect', effect_x, effect_y, {
        player = self,
        distanceFromCenter = distanceFromCenter
    })

    local projectile_x = self.x + (1.5 * distanceFromCenter * math.cos(self.r))
    local projectile_y = self.y + (1.5 * distanceFromCenter * math.sin(self.r))

    local projectiles = {
        left = {
            x = projectile_x
                + (0.5 * distanceFromCenter * math.cos(self.r - math.pi / 2))
            ,
            y = projectile_y
                + (0.5 * distanceFromCenter * math.sin(self.r - math.pi / 2))
            ,
            -- parentRotation = self.r + (math.pi / 6)
            parentRotation = self.r
        },
        middle = {
            x = projectile_x,
            y = projectile_y,
            parentRotation = self.r
        },
        right = {
            x = projectile_x
                + (0.5 * distanceFromCenter * math.cos(self.r + math.pi / 2))
            ,
            y = projectile_y
                + (0.5 * distanceFromCenter * math.sin(self.r + math.pi / 2))
            ,
            parentRotation = self.r
        }
    }

    for _, projectile in pairs(projectiles) do
        self.area:addGameObject('Projectile', projectile.x, projectile.y,
            lume.extend({
                v = 100,
                parentRotation = projectile.parentRotation
            })
        )
    end
end

return Player
