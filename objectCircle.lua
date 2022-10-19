-- define constants
local GRAVITY = 300
local MAXVSPEED = 800
local BOUNCESPEED = 500
local COLLISIONMASK = 40
local SPINFACTOR = 180000

function createCircle(x_pos,y_pos)
  -- initialize circle
  local circle = {}
  circle.x = x_pos
  circle.y = y_pos
  circle.radius = 50
  circle.hspeed = math.random(-75,75)
  circle.vspeed = 0
  circle.angle = 0 -- degrees
  circle.spinSpeed = 0.001
  
  insertCircle(circle)
end

function updateCircle(circle, dt)
  -- update vertical acceleration and speed
  if (circle.vspeed < MAXVSPEED) then
    circle.vspeed = circle.vspeed + (GRAVITY * dt)
  end
  circle.y = circle.y + (circle.vspeed * dt)
  
  -- update horizontal speed
  circle.x = circle.x + (circle.hspeed * dt)
  
  -- check for walls
  if (circle.x - COLLISIONMASK < 0 and circle.hspeed < 0) or
     (circle.x + COLLISIONMASK > love.graphics.getWidth() and circle.hspeed > 0) then
    circle.hspeed = circle.hspeed * -1
  end
  if circle.y > love.graphics.getHeight() + circle.radius then
    mainGameEnd()
  end
  
  -- update sprite angle and spinspeed
  circle.spinSpeed = circle.hspeed / SPINFACTOR
  circle.angle = circle.angle + circle.spinSpeed
  if circle.angle < -360 or circle.angle > 360 then 
    circle.angle = 0 
  end
end

function bounceCircle(circle, hbounce)
  -- make bounce direction dependent on what side of the circle you click
  circle.vspeed = -BOUNCESPEED
  circle.hspeed = hbounce
end

function checkCollision(a, b, dt)
  local a_left = a.x - COLLISIONMASK
  local a_right = a.x + COLLISIONMASK
  local a_top = a.y - COLLISIONMASK
  local a_bottom = a.y + COLLISIONMASK
  
  local b_left = b.x - COLLISIONMASK
  local b_right = b.x + COLLISIONMASK
  local b_top = b.y - COLLISIONMASK
  local b_bottom = b.y + COLLISIONMASK
  
  if a_right > b_left and a_left < b_right and 
     a_bottom > b_top and a_top < b_bottom then
    collideCircles(a, b, dt)
  end
end

function collideCircles(a, b, dt)
  -- move to contact position
  -- prevents circles from getting stuck in each other
  a.x = a.x - (a.hspeed * dt)      
  a.y = a.y - (a.vspeed * dt)
  b.x = b.x - (b.hspeed * dt)      
  b.y = b.y - (b.vspeed * dt)
  
  -- swap hspeed if colliding from side
  -- swap vspeed if colliding from top/bottom
  if math.abs(a.x-b.x) > math.abs(a.y-b.y) then
    local swap = a.hspeed
    a.hspeed = b.hspeed
    b.hspeed = swap
  else
    local swap = a.vspeed
    a.vspeed = b.vspeed
    b.vspeed = swap         
  end
end