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
	updateColor(player.red,player.green,player.blue,player.alpha)
	loadOthers(100)
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
	--love.graphics.print("Player.grid_x: "..player.grid_x,0)
	--love.graphics.print("Player.grid_y: "..player.grid_y,0,10)
	camera:unset()
	--love.graphics.setShader()
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
    	updateColor(255,0,0,255)
    elseif key == "l" then
    	updateColor(0,255,0,255)
    elseif key == "k" then
    	updateColor(0,0,255,255)
    end 

end


function loadOthers(num)
	for i=1,num do
		x = love.math.random(-12,12)
		y = love.math.random(-9,9)
		if (checkOverlap(x,y) == false) then 
			otherList[i]={--[[grid_x]]x,--[[grid_y]]y,--[[red]]love.math.random(1,255),--[[green]]love.math.random(1,255),--[[blue]]love.math.random(1,255),--[[alpha]]255}		
			numOthers = numOthers + 1
		else
			i = i - 1
		end 
	end
end 

function checkOverlap(x,y)
	if (not numOthers == 0) then 
		for i=1,numOthers do
			if(not otherList[i] == nil)then
				if (otherList[i][1] == x) then 
					if (otherList[i][2] == y) then
						return true
					end 
				end 
			end
		end
	end
	return false
end


function updateColor(r,g,b,a)
	player.red = (player.red + r)/2
	player.green = (player.green + g)/2
	player.blue = (player.blue + b)/2
	player.alpha = (player.alpha + a)/2
	--myShader:send("red",(player.red/255))
	--myShader:send("green",(player.green/255))
	--myShader:send("blue",(player.blue/255))
	--myShader:send("alpha",player.alpha)
end

function love.quit()
	otherList = {}
end 