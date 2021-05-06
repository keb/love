local GameObject = require 'engine.GameObject'
local baton = require 'lib.baton'

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
    self.r = -math.pi / 2 -- angle the player is moving towards, pointing up; math.pi/2 is down, -math.pi/2 is up
    self.rv = 1.66 * math.pi -- velocity of angle change when the user presses left or right
    self.v = 0 -- player's velocity
    self.max_v = 100 -- maximum velocity
    self.a = 100 -- acceleration
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
    love.graphics.line(
        self.x,
        self.y,
        self.x + (2 * self.w * math.cos(self.r)),
        self.y + (2 * self.w * math.sin(self.r))
    )
end

function Player:destroy()
    print('player object destroy')
    Player.super.destroy(self)

    if self.input then self.input = nil end
end

return Player
