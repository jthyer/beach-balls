local score, displayScore,colorCycle,timer

function gameOverLoad(s)
  setScene(3)
  
  score = s
  if score > hiScore then
    hiScore = score
    love.filesystem.write( "score", hiScore )
    colorCycle = 1
  else
    colorCycle = 0
  end
  displayScore = returnDisplayScore(score)
  displayHiScore = returnDisplayScore(hiScore)
  
  timer = 0
end

function gameOverUpdate(dt)
  timer = timer + dt
  if colorCycle > 0 and timer > 0.15 then
    colorCycle = colorCycle + 1
    if colorCycle > 3 then
      colorCycle = 1
    end
    timer = 0
  end
end

function gameOverDraw()
  love.graphics.setColor(0,0,0)
  love.graphics.printf("Game Over",fontBig,0,60,600,"center")
  love.graphics.printf("Click to try again!",fontSmall,0,400,600,"center")
  love.graphics.setColor(setColor(1), setColor(2), setColor(3))
  love.graphics.printf("Your Time:\n" .. displayScore,font,0,520,300,"center")
  love.graphics.printf("Best Time:\n" .. displayHiScore,font,300,520,300,"center")
  love.graphics.setColor(1,1,1)
end

function gameOverMouseClick(x, y)
  mainGameLoad()
end

function setColor(i)
  if i == colorCycle then
    return 255
  else
    return 0
  end
end