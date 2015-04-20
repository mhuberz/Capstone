require('camera')
require('player')
require('other')
otherList={}
numOthers=0

function love.load()
	square = love.graphics.newImage("square.png")
	camera:setPosition(player.grid_x- love.window.getWidth()/2+16,player.grid_y- love.window.getHeight()/2+16)
	--[[player.color_xLeft = love.window.getWidth()/2-16
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
	--updateColor(player.red,player.green,player.blue,player.alpha)
	loadOthers(20)
	debug.debug()
end


function love.update(dt)
	
end

function love.draw()
	camera:set()
	--love.graphics.setShader(myShader)
	for i=1,numOthers do 
		love.graphics.setColor(otherList[i][3],otherList[i][4],otherList[i][5],otherList[i][6])
		love.graphics.draw(square,otherList[i][1]*32,otherList[i][2]*32)
	end 
	love.graphics.setColor(player.red, player.green, player.blue, player.alpha)
	love.graphics.draw(square,player.grid_x,player.grid_y)
	camera:unset()
	--love.graphics.setShader()
end

function love.keypressed(key)
	if key == "w" then 
		player.grid_y = player.grid_y - 32
		camera:move(0,-32) 
		updateColor(checkCollision(player.grid_x,player.grid_y))
	elseif key == "s" then
		player.grid_y = player.grid_y + 32
		camera:move(0,32)
		updateColor(checkCollision(player.grid_x,player.grid_y))
	elseif key == "a" then 
		player.grid_x = player.grid_x - 32
		camera:move(-32,0)
		updateColor(checkCollision(player.grid_x,player.grid_y))
    elseif key == "d" then 
    	player.grid_x = player.grid_x + 32
    	camera:move(32,0)
    	updateColor(checkCollision(player.grid_x,player.grid_y))
    elseif key == "escape" then 
    	love.event.quit()
    end 	
end

function checkCollision(x,y)
	for i=1,numOthers do 
		if (x == otherList[i][1]*32 and y == otherList[i][2]*32) then 
			return i 
		end 
	end 
	return 0
end 


function loadOthers(num)
	for i=1,num do
		x = love.math.random(-12,12)
		y = love.math.random(-9,9)
		if (checkOverlap(x,y) == false) then 
			otherList[i]={--[[grid_x]]x,--[[grid_y]]y,--[[red]]love.math.random(1,255),--[[green]]love.math.random(1,255),--[[blue]]love.math.random(1,255),--[[alpha]]255}		
			numOthers = numOthers + 1
		else
			num = num + 1
		end 
	end
end 

function checkOverlap(x,y)--fix this
	if (numOthers > 0) then 
		for i=1,numOthers do
			if (x == otherList[i][1] and y == otherList[i][2]) then
				return true 
			end 
		end
	end
	return false
end


function updateColor(i)
	if (i >= 1) then 
		player.red = (player.red + otherList[i][3])/2
		player.green = (player.green + otherList[i][4])/2
		player.blue = (player.blue + otherList[i][5])/2
		player.alpha = (player.alpha + otherList[i][6])/2
		removeOther(i)
	end 
end

function removeOther(num)
	for i = num,numOthers do 
		if (i==numothers) then 
			otherList[i] = {}
		else 
			otherList[i] = otherList[i+1]
		end 
	end 
	numOthers = numOthers - 1
end 

function love.quit()
	otherList = {}
end 