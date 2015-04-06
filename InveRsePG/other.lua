other = {}
otherList={}
numOthers=0


function other:loadOthers(num)
	for i=1,num do
		otherList[i]={--[[grid_x]]math.random(1,12),--[[grid_y]]math.random(1,9),--[[red]]math.random(1,255),--[[green]]math.random(1,255),--[[blue]]math.random(1,255),--[[alpha]]255}		
		numOthers = numOthers + 1
	end
end 

