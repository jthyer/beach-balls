local CLOUDSTART = -300
local CLOUDEND = 900

local cloud_x

function bgLoad()
  cloud_x = CLOUDSTART
end

function bgDraw()
  love.graphics.draw(bgBeach, 0, 0, 0, 1, 1)
end

function bgUpdate(dt)
  cloud_x = cloud_x + (15 * dt)
  if cloud_x > CLOUDEND then
    cloud_x = CLOUDSTART
  end
end

function bgDrawCloud()
  love.graphics.draw(sprCloud, cloud_x, 25, 0, 1, 1)
end