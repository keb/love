local Object = require 'lib.classic'
local Bullet = require 'Bullet'

local Player = Object:extend()
function Player:new(x, y)
    self.image = love.graphics.newImage('assets/panda.png')
    self.x = x
    self.y = y
    self.speed = 500
    self.bullets = {}
    self.width = self.image:getWidth()
end

function Player:update(dt)
    if love.keyboard.isDown('left') then
        self.x = self.x - self.speed * dt
    elseif love.keyboard.isDown('right') then
        self.x = self.x + self.speed * dt
    end

    local window_width = love.graphics.getWidth()
    if self.x < 0 then
        self.x = 0
    elseif self.x + self.width > window_width then -- make sure to check for x + sprite width
        self.x = window_width - self.width
    end
end

function Player:draw()
    love.graphics.draw(self.image, self.x, self.y)
end

function Player:keyPressed(key)
    if key == 'space' then
        table.insert(self.bullets, Bullet(self.x, self.y))
    end
end

return Player