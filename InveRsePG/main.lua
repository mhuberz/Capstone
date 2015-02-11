require('camera')

function love.load()
	player = {
		grid_x = 256,
		grid_y = 256,
		act_x = 200,
		act_y = 200,
		speed = 10
	}
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
	love.graphics.print(player.act_x,200)
	love.graphics.print(player.act_y,200,100)
	camera:unset()
end

function love.keypressed(key)
	if key == "w" then 
		player.grid_y = player.grid_y - 32 
	elseif key == "s" then
		player.grid_y = player.grid_y + 32
	elseif key == "a" then 
		player.grid_x = player.grid_x - 32
    elseif key == "d" then 
    	player.grid_x = player.grid_x + 32
    end 
end
