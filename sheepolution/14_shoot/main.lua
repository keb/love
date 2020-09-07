local Player = require 'Player'
local Enemy = require 'Enemy'

local player
local enemy

function love.load()
    enemy = Enemy(325, 450)
    player = Player(300, 20)
end

function love.update(dt)
    player:update(dt)
    for i,v in ipairs(player.bullets) do
        v:update(dt)
        v:checkCollision(enemy)

        if v.dead then
            table.remove(player.bullets, i)
        end
    end

    enemy:update(dt)
end

function love.draw()
    player:draw()
    for i,v in ipairs(player.bullets) do
        v:draw()
    end

    enemy:draw()
end

function love.keypressed(key)
    player:keyPressed(key)
end