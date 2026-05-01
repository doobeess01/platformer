--[[ Low resolution ]]--

local push = require "libraries/push"

local level = require "level"

function love.resize(w, h)
  push:resize(w, h)
end

love.graphics.setDefaultFilter("nearest", "nearest") --disable blurry scaling

local gameWidth, gameHeight = 128, 128

local windowWidth, windowHeight = love.window.getDesktopDimensions()
windowWidth, windowHeight = windowWidth*.5, windowHeight*.5

push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {
  fullscreen = false,
  resizable = true,
  pixelperfect = true
})

push:setBorderColor {0, 0, 0}


function love.load()
	local font = love.graphics.newFont("assets/press_start_2p/PressStart2P.ttf", 8)
	love.graphics.setFont(font)

	World, Items = level:load(1)

  	N_platforms = 2

 	LevelNumber = 1

	Score = 0
	Sprites = {
		Coin=love.graphics.newImage('assets/coin.png'),
		Goal=love.graphics.newImage('assets/goal flag.png'),
		Platform=love.graphics.newImage('assets/platform.png')
	}


	GRAVITY = 400
end


function getRect(item)
  local x,y,w,h = World:getRect(item)
  return {
	x=x,
	y=y,
	w=w,
	h=h
  }
end


function collisionType(item, other)
  if other.name == Platform then
	return "slide"
  end
  return "cross"
end


function love.update(dt)
  Player:updateMovement(dt)

  local playerPos = getRect(Player)
  local actualX, actualY, cols, len = World:move(Player, playerPos.x + Player.vx*dt, playerPos.y + Player.vy*dt, collisionType)
  
  for i = 1, len, 1 do
	local col = cols[i]
	local item = col.other
	if item.name == Platform 
	and col.normal.y == 1 then -- Collided from below
	  Player.vy = -Player.vy/4
	elseif item.name == Coin then
	  item.delete = true
	  Score = Score + 1
	elseif item.name == Goal then
		LevelNumber = LevelNumber + 1
		World, Items = level:load(LevelNumber)
	end
  end

  local newItems = {}

  for i = 1, #Items, 1 do
	if Items[i].delete then
	  World:remove(Items[i])
	else
	  table.insert(newItems, Items[i])
	end
  end

  Items = newItems
end


function love.draw()
  push:apply('start')

  love.graphics.clear(.4,.65,1)
  love.graphics.print('Score: '..Score,1,1)
  local playerPos = getRect(Player)
  love.graphics.draw(Player.sprite, playerPos.x+4, playerPos.y, 0, Player.facing, 1, 4,0)


  for i = 1, #Items, 1 do
	local item = Items[i]

	local itemPos = getRect(Items[i])
	if Sprites[item.name] then
	  love.graphics.draw(Sprites[item.name], itemPos.x, itemPos.y)
	else
	  love.graphics.rectangle('fill',itemPos.x,itemPos.y,itemPos.w,itemPos.h)
	end
  end

  push:apply('end')
end
