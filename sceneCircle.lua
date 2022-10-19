require("objectCircle")  -- functions for circle object

local listOfCircle, score, scoreTimer, displayScore

function mainGameLoad()
  setScene(2)

  -- initialize object list and score
  listOfCircles = {}
  score = 0
  scoreTimer = 0
  displayScore = returnDisplayScore(score)

  -- randomize seed
  math.randomseed(os.time())
  
  -- create circles
  local offsetL, offsetM, offsetR = getRandomSetOfThree()
  
  createCircle(100,30 + math.random(50) + (offsetL * 90))
  createCircle(300,30 + math.random(50) + (offsetM * 90))
  createCircle(500,30 + math.random(50) + (offsetR * 90))
end

function mainGameUpdate(dt)
  -- run through updating position and speed of all circles
  -- check collision for all later circles in table
  for i,v in ipairs(listOfCircles) do
    updateCircle(v, dt)
    for a=i,#listOfCircles do
      if a ~= i then
        checkCollision(listOfCircles[i], listOfCircles[a],dt)
      end
    end
  end
  
  updateScore(dt)
end

function mainGameDraw()
  -- draw all circles
  for i,v in ipairs(listOfCircles) do
    love.graphics.draw(sprBeachBall,v.x,v.y,math.deg(v.angle),1,1,v.radius,v.radius)
  end
  
  -- draw score
  love.graphics.setColor(0,0,0)
  love.graphics.printf(" \n" .. displayScore,font,0,520,600,"center")
  love.graphics.setColor(1,1,1)
end

function mainGameMouseClick(x, y)
  -- bounce any circles mouse is touching on click
  for i,v in ipairs(listOfCircles) do
    if x > v.x - v.radius and x < v.x + v.radius and 
      y > v.y - v.radius and y < v.y + v.radius then
      bounceCircle(v, (v.x-x)*10)
    end
  end
end

function updateScore(dt) 
  -- update score
  scoreTimer = scoreTimer + dt
  if scoreTimer > 1 then
    score = score + 1  
    scoreTimer = 0
    displayScore = returnDisplayScore(score)
  end
end

function insertCircle(circle)
  table.insert(listOfCircles, circle)
end

function mainGameEnd()
  gameOverLoad(score)
end

function getRandomSetOfThree()
  local set = { 1, 2, 3 }
  local randomSet = {}

  while #set > 0
  do
    local i = math.random(#set)
    table.insert(randomSet,set[i]-1)
    table.remove(set,i)  
  end
  
  return randomSet[1], randomSet[2], randomSet[3]
end