arr=Array.new(3){Array.new(3)}
def show arr
    i=0
    puts
    while i<3 do
    	j=0
    	while j<3 do
    		if arr[i][j]==nil
    			print " "
    		elsif arr[i][j]==1
    			print "O"
    		else  
    			print "X"
    		end
    		if j<2
    		print " |"
    	    end
            j=j+1
            end
        if i<2
        puts 
        puts "---------"
        end 
    	i=i+1
    end
    puts 
    puts
end
def checkresult arr 
    i=0
    while i<3 do
        j=0
        while j<3 do
            if arr[i][j]==nil
                return true
            end
            j=j+1
        end
        i=i+1
    end
    return false
end
def check x,y,arr
	if arr[x][y]==nil
		return true
	else
		return false
    end
end
def fill x,y,i,arr
	if i%2==0
		arr[x][y]=1
	else
		arr[x][y]=-1
	end
end
def evaluate arr
	i=0
	while i<3 do
		if arr[i][0]==arr[i][1]&&arr[i][1]==arr[i][2]
			if arr[i][0]==-1
				return +10
			elsif arr[i][0]==1
				return -10
			end
		end
		i=i+1
    end
    i=0
	while i<3 do
		if arr[0][i]==arr[1][i]&&arr[1][i]==arr[2][i]
			if arr[0][i]==-1
				return +10
			elsif arr[0][i]==1
				return -10
			end
		end
		i=i+1
    end
    if arr[0][0]==arr[1][1]&&arr[1][1]==arr[2][2]
    	if arr[0][0]==-1
    		return +10
    	elsif arr[0][0]==1
    		return -10
    	end
    end
     if arr[0][2]==arr[1][1]&&arr[1][1]==arr[2][0]
    	if arr[0][2]==-1
    		return +10
    	elsif arr[0][2]==1
    		return -10
    	end
    end
    return 0
end
def minimax arr, depth, isMax
	score=evaluate arr
	if score==10
		return score
	end
	if score==-10
		return score
	end
    me=checkresult arr
	if  me==false
		return 0
	end
	if isMax
		best=-1000
		i=0
	    while i<3 do
		  j=0
		   while j<3 do
              if arr[i][j]==nil
            	  arr[i][j]=-1
            	  best2=minimax arr,depth+1,!isMax
            	  if best2>best
            		best=best2
            	  end
            	  arr[i][j]=nil
                end
			  j=j+1
		    end
		    i=i+1
		end
        return best
    else
    	best=1000
		i=0
	    while i<3 do
		  j=0
		   while j<3 do
              if arr[i][j]==nil
            	  arr[i][j]=1
            	  best2=minimax arr,depth+1,!isMax
            	  if best2<best
            		best=best2
            	 end
               	  arr[i][j]=nil
                end
			  j=j+1
		    end
		    i=i+1
		end
        return best
    end
end
def findbestmove arr
	bestval=-1000
	i=0
	a=[3]
	while i<3 do
		j=0
		while j<3 do
            if arr[i][j]==nil
            	arr[i][j]=-1
            	moveval=minimax arr,0,false
            	arr[i][j]=nil
            	if moveval>bestval
                    a[0]=i
                    a[1]=j
            	end
            end
			j=j+1
		end
		i=i+1
	end
	return a
end
count =true
i=0
puts "O is player","X is computer","Player will move first"
while count do
	a=[3]
	if i%2==0
          puts "O turn : Enter the position to fill"
          x=gets
          y=gets
          x=x.to_i;
          y=y.to_i;
          if check x,y,arr
    	     fill x,y,i,arr
          else
    	    puts "Position already fill try another position"
          end
    else
    	 puts "X turn : "
         a=findbestmove arr
         x=a[0]
         y=a[1]
         fill x,y,i,arr
    end
    show arr
    result=evaluate arr
    if result==-10
    	puts "Player wins .....Congratulation!!!"
    	count=false
    elsif result==10
    	puts "bots win......play again!!"
    	count=false
    end
    if i==8
    	puts "Game Draw"
    	count=false
    end
    i=i+1
end