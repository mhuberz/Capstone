require('camera')
require('player')
require('other')
otherList={}
numOthers=0
offsetX = 0
offsetY = 0
boundUp = -9
boundDown = 9
boundRight = -12
boundLeft = 12
worldColor = {--[[red]]0,--[[green]]0,--[[blue]]0}

function love.load()
	love.window.setTitle("Square")
	square = love.graphics.newImage("square.png")
	camera:setPosition(player.grid_x- love.window.getWidth()/2+16,player.grid_y- love.window.getHeight()/2+16)
	for i = 1, 20 do 
		addOther()
	end 
	debug.debug()
end


function love.update(dt)
	if (worldColor[1]==255 and worldColor[2]==255 and worldColor[3]==255) then 
		love.event.quit()
	end 
end

function love.draw()
	camera:set()
	for i=1,numOthers do 
		love.graphics.setColor(otherList[i][3],otherList[i][4],otherList[i][5],otherList[i][6])
		love.graphics.draw(square,otherList[i][1]*32,otherList[i][2]*32)
	end 
	love.graphics.setColor(player.red, player.green, player.blue, player.alpha)
	love.graphics.draw(square,player.grid_x,player.grid_y)
	love.graphics.setBackgroundColor(worldColor[1], worldColor[2], worldColor[3])
	camera:unset()
end

function love.keypressed(key)
	if key == "w" then --up
		player.grid_y = player.grid_y - 32
		camera:move(0,-32) 
		updateColor(checkCollision(player.grid_x,player.grid_y))
		offsetY = offsetY + 1
		if ((offsetY + 9) > boundUp) then 
			boundUp = offsetY +9
			boundDown = 9
			generateUp()
		end 

	elseif key == "s" then --down
		player.grid_y = player.grid_y + 32
		camera:move(0,32)
		updateColor(checkCollision(player.grid_x,player.grid_y))
		offsetY = offsetY - 1
		if (offsetY - 9 < boundDown) then 
			boundDown = offsetY -9
			boundUp = -9
			generateDown()
		end 

	elseif key == "a" then --left
		player.grid_x = player.grid_x - 32
		camera:move(-32,0)
		updateColor(checkCollision(player.grid_x,player.grid_y))
		offsetX = offsetX - 1
		if (offsetX - 12 < boundLeft) then 
			boundLeft = offsetX -12
			boundRight = -12
			generateLeft()
		end 

    elseif key == "d" then --right
    	player.grid_x = player.grid_x + 32
    	camera:move(32,0)
    	updateColor(checkCollision(player.grid_x,player.grid_y))
    	offsetX = offsetX + 1
		if (offsetX + 12 > boundRight) then 
			boundRight = offsetX +12
			boundLeft = 12
			generateRight()
		end 


    elseif key == "escape" then 
    	love.event.quit()
    end 	
end

function checkCollision(x,y)
	if (numOthers == 0) then
		return 0
	else 
		for i=1,numOthers do 
			if (x == otherList[i][1]*32 and y == otherList[i][2]*32) then 
				return i 
			end 
		end 
		return 0
	end 
end 

function generateUp()
	for i=1,2 do
		repeat
		x = love.math.random(-12 + offsetX,12+offsetX)
		y = -boundUp
		until (checkCollision(x*32,y*32)==0)
		otherList[numOthers+1]={--[[grid_x]]x,--[[grid_y]]y,--[[red]]love.math.random(1,255),--[[green]]love.math.random(1,255),--[[blue]]love.math.random(1,255),--[[alpha]]255}
		numOthers = numOthers + 1
	end
end  

function generateDown()
	for i=1,2 do
		repeat
		x = love.math.random(-12,12) + offsetX
		y = -boundDown
		until (checkCollision(x*32,y*32)==0)
		otherList[numOthers+1]={--[[grid_x]]x,--[[grid_y]]y,--[[red]]love.math.random(1,255),--[[green]]love.math.random(1,255),--[[blue]]love.math.random(1,255),--[[alpha]]255}
		numOthers = numOthers + 1
	end
end

function generateLeft()
	for i=1,2 do
		repeat
		x = boundLeft
		y = love.math.random(-9,9) + -offsetY
		until (checkCollision(x*32,y*32)==0)
		otherList[numOthers+1]={--[[grid_x]]x,--[[grid_y]]y,--[[red]]love.math.random(1,255),--[[green]]love.math.random(1,255),--[[blue]]love.math.random(1,255),--[[alpha]]255}
		numOthers = numOthers + 1
	end
end 

function generateRight()
	for i=1,2 do
		repeat
		x = boundRight
		y = love.math.random(-9,9) + -offsetY
		until (checkCollision(x*32,y*32)==0)
		otherList[numOthers+1]={--[[grid_x]]x,--[[grid_y]]y,--[[red]]love.math.random(1,255),--[[green]]love.math.random(1,255),--[[blue]]love.math.random(1,255),--[[alpha]]255}
		numOthers = numOthers + 1
	end
end  

function addOther()
	repeat
		x = love.math.random(-12,12)
		y = love.math.random(-9,9)
	until (checkCollision(x*32,y*32)==0 and (x ~= 0 and y ~= 0))
	otherList[numOthers+1]={--[[grid_x]]x,--[[grid_y]]y,--[[red]]love.math.random(1,255),--[[green]]love.math.random(1,255),--[[blue]]love.math.random(1,255),--[[alpha]]255}
	numOthers = numOthers + 1
end 
	

function updateColor(i)
	if (i >= 1) then 
		player.red = (player.red + otherList[i][3])/2
		player.green = (player.green + otherList[i][4])/2
		player.blue = (player.blue + otherList[i][5])/2
		player.alpha = (player.alpha + otherList[i][6])/2
		num = findLargest(i) -2
		if (worldColor[num]<255) then 
			worldColor[num] = (worldColor[num] + 1)
		end 
		removeOther(i)
	end 
end

function findLargest(i)
	largest = 3
	for j=4,5 do 
		if(otherList[i][largest] < otherList[i][j]) then 
			largest = j
		end
	end 
	return largest
end 

function removeOther(num)
	for i = num,numOthers do 
		if (i==numOthers) then 
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