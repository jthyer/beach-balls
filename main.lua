require("sceneCircle")   -- functions for the main game scene
require("sceneTitle")    -- title screen
require("sceneGameOver") -- game over screen
require("bg")            -- background

hiScore = 0
displayHiScore = "0:00"

local LINEHEIGHT = 300
local scene = 1
local mouseX = -50  -- spawn off screen
local mouseY = -50 

function love.load()
  -- read high score file if present
  local info = love.filesystem.getInfo( "score" )
  if info ~= nil then
    local read = love.filesystem.read( "score" )
    hiScore = tonumber(read)
  else
    love.filesystem.write( "score", hiScore )
  end
  
  -- window settings
  love.graphics.setDefaultFilter("nearest", "nearest", 1)
  love.window.setTitle("Beach Balls")
  
  -- set font
  font = love.graphics.newFont(28)
  fontSmall = love.graphics.newFont(22)
  fontBig = love.graphics.newFont(32)

  -- set score display
  displayHiScore = returnDisplayScore(hiScore)

  -- load graphics
  bgBeach = love.graphics.newImage("images/bg_beach.png")
  sprBeachBall = love.graphics.newImage("images/spr_beachball.png")
  sprTitle = love.graphics.newImage("images/spr_title.png")
  sprMouse = love.graphics.newImage("images/spr_mouse.png")
  sprCloud = love.graphics.newImage("images/spr_cloud.png")
  
  -- play music
  song = love.audio.newSource("music/beachsong.ogg", "stream")
  song:setLooping(true)
  song:play()

  -- background load
  bgLoad()
end

function love.update(dt)
  -- adding music check for javascript port
  -- music stops if browser tab is minimized
  if song:isPlaying() == false then
    song:play()
  end
  
  -- main loop
  if scene == 2 then
    bgUpdate(dt)    
    mainGameUpdate(dt)
  elseif scene == 3 then
    bgUpdate(dt)    
    gameOverUpdate(dt)
  end
end

function love.draw()
  bgDraw()
  if scene == 1 then
    titleScreenDraw()
  elseif scene == 2 then
    bgDrawCloud()
    mainGameDraw()
  elseif scene == 3 then
    bgDrawCloud()
    gameOverDraw()
  end
  drawMouseHand()
end

function love.mousepressed(x, y, button, istouch)
  if y > LINEHEIGHT and button == 1 then
    if scene == 1 then 
      titleScreenMouseClick(x, y)
    elseif scene == 2 then
      mainGameMouseClick(x, y)
    elseif scene == 3 then
      gameOverMouseClick(x, y)
    end
  end
end

function returnDisplayScore(s)
  return math.floor(s/60) .. ":" ..
  math.floor((s % 60)/10) .. 
  s % 10
end

function setScene(s)
  scene = s
end

function drawMouseHand()
  -- draw mouse hand
  local userMouseX, userMouseY = love.mouse.getPosition()
  
  if userMouseY > LINEHEIGHT then
    love.mouse.setVisible(false)
    mouseX, mouseY = userMouseX, userMouseY
  else
    love.mouse.setVisible(true)
  end
  
  love.graphics.draw(sprMouse, mouseX, mouseY, 0, 1, 1, 0, 0)
end