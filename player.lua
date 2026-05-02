Player = {
  sprite=love.graphics.newImage('assets/player.png'),
  facing=1,
  vx = 0,
  vy = 0,
  jumpAcceleration = 150,
}


function isGrounded(item)
  local itemPos = getRect(item)
  local actualX, actualY, cols, len = World:check(item, itemPos.x, itemPos.y+0.01)
  for i = 1, len, 1 do
    if cols[i].other.name == "platform" then
      return true
    end
  end
  return false
end


function Player:updateMovement(dt)
  if isGrounded(Player) then
    Player.vy = 0
    if love.keyboard.isDown("up") or love.keyboard.isDown("space") then
      if not JumpIsHeld then
        Player.vy = -Player.jumpAcceleration
        JumpIsHeld = true
      end
    else
      JumpIsHeld = false
    end
  end
  if Player.vy ~= 0 or not isGrounded(Player) then
    Player.vy = Player.vy + GRAVITY*dt
  end
  Player.vx = 0
  if love.keyboard.isDown("right") then
    Player.vx = 80
    Player.facing = 1
  elseif love.keyboard.isDown("left") then
    Player.vx = -80
    Player.facing = -1
  end
end


return Player
