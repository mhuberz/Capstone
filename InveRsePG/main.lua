require('camera')
require('player')
--[[todo: 	character sprite
			map
			enemies
			battle system
	]]


function love.load()
	camera:setPosition(player.grid_x- love.window.getWidth()/2+32,player.grid_y- love.window.getHeight()/2+32)
end

function love.update(dt)
	player.act_y = player.act_y - ((player.act_y - 
		player.grid_y) * player.speed * dt)
	player.act_x = player.act_x - ((player.act_x - 
		player.grid_x) * player.speed * dt)	
end

function love.draw()
	camera:set()
	love.graphics.rectangle("fill", player.act_x, player.act_y, 32, 32)
	camera:unset()
end

function love.keypressed(key)
	if key == "w" then 
		player.grid_y = player.grid_y - 32
		camera:move(0,-32) 
	elseif key == "s" then
		player.grid_y = player.grid_y + 32
		camera:move(0,32)
	elseif key == "a" then 
		player.grid_x = player.grid_x - 32
		camera:move(-32,0)
    elseif key == "d" then 
    	player.grid_x = player.grid_x + 32
    	camera:move(32,0)
    end 
end
