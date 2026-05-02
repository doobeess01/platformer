local push = require "libraries.push"
local inspect = require "libraries.inspect"

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

	Map, World, Items = level:load(1)

  	N_platforms = 2

 	LevelNumber = 1

	Score = 0


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
  if other.name == "platform" then
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
	if item.name == "platform"
	and col.normal.y == 1 then -- Collided from below
	  Player.vy = -Player.vy/4
	elseif item.name == "coin" then
		item.delete = true
		Score = Score + 1
	elseif item.name == "goal" then
		LevelNumber = LevelNumber + 1
		Map, World, Items = level:load(LevelNumber)
	end
  end

  local newItems = {}

  for i = 1, #Items, 1 do
	local item = Items[i]
	if item.delete then
	  World:remove(item)
	  Map:setLayerTile("all", item.x, item.y, 0)
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

	Map:draw()

  	push:apply('end')
end
