function love.load()
  image = love.graphics.newImage("cake.jpg")
end
love.draw = function()
  return love.graphics.draw(image, 50, 50)
end
