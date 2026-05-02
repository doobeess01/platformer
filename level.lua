local bump = require "libraries.bump"
local sti = require "libraries.sti"
local inspect = require "libraries.inspect".inspect


local level = {}


function level:load(levelnum)
	local map = sti("levels/level"..levelnum..'.lua')
	
	local items = {}

	local world = bump.newWorld()
	local player_pos
	for tile_y, row in ipairs(map.layers["all"].data) do
		for tile_x, tile in pairs(row) do
			local prop = tile.properties
			if prop.collider then
				local uid = #items+1
				local item = {
					x=tile_x,
					y=tile_y,
					name=prop.name,
					uid=uid,
				}
				table.insert(items, item)
				world:add(item, (tile_x-1)*map.tilewidth+prop.collider.x, (tile_y-1)*map.tileheight+prop.collider.y, prop.collider.w, prop.collider.h)
			elseif prop.name == "player" then
				Player = require "player"
				world:add(Player, (tile_x-1)*map.tilewidth, (tile_y-1)*map.tileheight, 8, 8)
				player_pos = {x=tile_x, y=tile_y}
			end
		end
	end
	map:setLayerTile("all", player_pos.x, player_pos.y, 0)

	return map, world, items

end


return level