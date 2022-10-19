function titleScreenDraw()
  love.graphics.draw(sprTitle,0,0,0)
  love.graphics.setColor(0,0,0)
  love.graphics.printf("Click in the\nbounce zone to start!",fontSmall,0,406,600,"center")
  love.graphics.printf("Best Time:\n" .. displayHiScore,font,0,520,600,"center")
  love.graphics.setColor(1,1,1)
end

function titleScreenMouseClick(x, y)
  mainGameLoad()
end