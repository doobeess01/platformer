local bump = require "libraries/bump"


local level = {}


local levels = require "levels"


local hitboxes = {
	Platform={x=0,y=0,w=8,h=6},
	Coin={x=1,y=1,w=6,h=6},
	Goal={x=1,y=1,w=6,h=7},
	Player={x=0,y=0,w=8,h=8},
}



function level:load(levelnum)
	local map = levels[levelnum]

	local items = {}
	local world = bump.newWorld()
	local itemCounts = {
		Platform=0,
		Coin=0,
		Goal=0,
	}

	local mapWidth = #map[1]
	local mapHeight = #map

	for i = 1, mapHeight, 1 do
		for j = 1, mapWidth, 1 do
			local tile = map[i][j]
			if tile then
				local item
				local hitbox
				if tile == PlayerStart then
					Player = require "player"
					item = Player
					hitbox = hitboxes.Player
				else
					itemCounts[tile] = itemCounts[tile] + 1
					item = {name=tile, id=itemCounts[tile]}
					table.insert(items, item)
					hitbox = hitboxes[tile]
				end
				world:add(item, (j-1)*8+hitbox.x, (i-1)*8+hitbox.y, hitbox.w,hitbox.h)
			end
		end
	end

	return world, items
end


return level