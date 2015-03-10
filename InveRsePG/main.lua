require('camera')
require('player')


function love.load()
	hero = love.graphics.newImage("hero.png")
	camera:setPosition(player.grid_x- love.window.getWidth()/2+16,player.grid_y- love.window.getHeight()/2+16)
	player.color_xLeft = love.window.getWidth()/2-16
	player.color_xRight = love.window.getWidth()/2+16
	player.color_yUp = love.window.getHeight()/2-16
	player.color_yDown = love.window.getHeight()/2+16
	myShader = love.graphics.newShader[[
		extern number red;
		extern number green;
		extern number blue;
		extern number alpha;
		//extern number playerXLeft;
		//extern number playerXRight;
		//extern number playerYUp;
		//extern number playerYDown;
		vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
			vec4 pixel = Texel(texture, texture_coords);
			if(screen_coords.x>(400-16)&&screen_coords.x<(400+16)){
				if(screen_coords.y>(300-16)&&screen_coords.y<(300+16)){
					return vec4(red,green,blue,alpha);
				}
			}
			return pixel*color;
		}]]
	updateColor(player.red,player.green,player.blue,player.alpha)
end

function love.update(dt)
	player.act_y = player.act_y - ((player.act_y - 
		player.grid_y) * player.speed * (dt/2))
	player.act_x = player.act_x - ((player.act_x - 
		player.grid_x) * player.speed * (dt/2))	
	player.color_xLeft = player.color_xLeft - ((player.color_xLeft -
		player.grid_x) * player.speed * (dt/2))
	player.color_xRight = player.color_xRight - ((player.color_xRight -
		player.grid_x) * player.speed * (dt/2))
	player.color_yUp = player.color_yUp - ((player.color_yUp -
		player.grid_y) * player.speed * (dt/2))
	player.color_yDown = player.color_yDown - ((player.color_yDown -
		player.grid_y) * player.speed * (dt/2))
	--myShader:send("playerXLeft",player.color_xLeft)
	--myShader:send("playerXRight",player.color_xRight)
	--myShader:send("playerYUp",player.color_yUp)
	--myShader:send("playerYDown",player.color_yDown)
end

function love.draw()
	camera:set()
	love.graphics.setShader(myShader)
	love.graphics.draw(hero,player.grid_x,player.grid_y)
	love.graphics.rectangle("fill", 256, 256, 32, 32)
	love.graphics.print("Player.act_x: "..player.act_x,0,0)
	love.graphics.print("Player.act_y: "..player.act_y,0,10)
	love.graphics.print("Player.grid_x: "..player.grid_x,0,20)
	love.graphics.print("Player.grid_y: "..player.grid_y,0,30)
	camera:unset()
	love.graphics.setShader()
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
    elseif key == " " then
    	updateColor(255,0,0,1)
    elseif key == "l" then
    	updateColor(0,255,0,1)
    elseif key == "k" then
    	updateColor(0,0,255,1)
    end 

end

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function updateColor(r,g,b,a)
	player.red = (player.red + r)/2
	player.green = (player.green + g)/2
	player.blue = (player.blue + b)/2
	player.alpha = (player.alpha + a)/2
	myShader:send("red",(player.red/255))
	myShader:send("green",(player.green/255))
	myShader:send("blue",(player.blue/255))
	myShader:send("alpha",player.alpha)
end
