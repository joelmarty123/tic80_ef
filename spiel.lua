t=0
x=0
y=0
dir_x=1
dir_y=0
game_state = 1

score = 0
speed = 0
hp = 1

x_r = math.random(0, 29)
y_r = math.random(0, 16)

x_r_up = math.random(0, 29)
y_r_up = math.random(0, 16)

snake_body = {} 

prev_num = 0
respawn = 0

walls = {}

for i = 1, 10 do 
	table.insert(walls, {math.random(0, 29), math.random(0, 16)})
end

function TIC()

	if btnp(0) then 
		dir_x = 0
		dir_y = -1
	elseif btnp(1) then 
		dir_x = 0
		dir_y = 1
	elseif btnp(2) then 
		dir_x = -1 
		dir_y = 0
	elseif btnp(3) then 
		dir_x = 1
		dir_y = 0
	end

	if t%(9) == 0 then
		x=x+dir_x
		y=y+dir_y

		for i = 2, #snake_body do
			if x == snake_body[i][1] and y == snake_body[i][2] then
				game_state = 0
			end
		end

		if x > 30 or x < 0 then 
			game_state = 0
			
		elseif y > 17 or y < 0 then 
			game_state = 0
			
		end
		
		table.remove(snake_body, snake_body.length)
		table.insert(snake_body, 1, {x, y})
	end
	
	if keyp(48) then 
		if game_state == 2 then game_state = 1
		elseif game_state == 1 then game_state = 2
		end
	end

	if game_state == 1 then 
	
		if x == x_r and y == y_r then 
		
			c = 0
		
			while c == 0 do 
			
				x_r = math.random(0, 29)
				y_r = math.random(0, 16)
				
				for i = 1, #walls do
					if (x_r * y_r - (29 - x_r%29)) == (walls[i][1] * walls[i][2] - (29 - walls[i][1]%29)) then c = 1 end
				end
				
			end
			
			table.insert(snake_body, {x - dir_x, y - dir_y})
			
			score = score + 1
			speed = speed + 1
		end
		
		if x == x_r_up and y == y_r_up then
			
			x_r_up = math.random(0, 29)
			y_r_up = math.random(0, 16)
			
			hp = hp + 1
			
		end
			
		cls(7)
		
		for i, n in pairs(walls) do 
			spr(7,8*x,8*y,0,1,0,0,1,1)
		end
		
		for i, n in pairs(snake_body) do
		
			if i == 1 then spr(0,8*x,8*y,0,1,0,0,1,1)
			else spr(5, 8*n[1], 8*n[2], 0, 1, 0, 0, 1, 1)
			end
		end
		
		if respawn == 1 then 
		
			if prev_num > 0 then 
				table.insert(snake_body, 1, {x, y})
				prev_num = prev_num - 1
			end
		
		end
 
		print("Score: "..score, 95, 20)
		print("HP: "..hp, 20, 20)
		spr(16, 8*x_r, 8*y_r,0, 1, 0, 0, 1, 1)
		spr(6, 8*x_r_up, 8*y_r_up, 0, 1, 0, 0, 1, 1)
		
		t=t+1
		
	end
		
	if game_state == 0 then 
		print("Game over!", 84, 84)
		
		if hp > 0 then 
			x = 0
			y = 0
			dir_x = 1
			dir_y = 0
			score = #snake_body - 1
			speed = 0
			prev_num = #snake_body - 1
			snake_body = {}
			game_state = 1
			hp = hp - 1
			respawn = 1
			
		end
		
		if btnp(0) then 
			x = 0
			y = 0
			dir_x = 1
			dir_y = 0
			score = 0
			speed = 0
			hp = 1
			snake_body = {}
			game_state = 1
		end
		
	end
	
	if game_state == 2 then
		cls(5)
		print("Pause", 95, 60)
	end
	
end
-- <TILES>
-- 000:011111101cc11cc11c0110c11111111114133141111111111222222101222210
-- 001:eccccccccc888888caaaaaaaca888888cacccccccacc0ccccacc0ccccacc0ccc
-- 002:ccccceee8888cceeaaaa0cee888a0ceeccca0ccc0cca0c0c0cca0c0c0cca0c0c
-- 003:eccccccccc888888caaaaaaaca888888cacccccccacccccccacc0ccccacc0ccc
-- 004:ccccceee8888cceeaaaa0cee888a0ceeccca0cccccca0c0c0cca0c0c0cca0c0c
-- 005:0111111013131313313131311111111111111111111111111111111101111110
-- 006:0006000000055000044444404444c444433c4444443444444443444404444440
-- 007:0edeedd0dfcdefdeeddfffdfddefcffdffeeedfdfeedcedefdfddedd0ddefff0
-- 016:0000020000002200000230000066660006666660065566600665566000666600
-- 017:cacccccccaaaaaaacaaacaaacaaaaccccaaaaaaac8888888cc000cccecccccec
-- 018:ccca00ccaaaa0ccecaaa0ceeaaaa0ceeaaaa0cee8888ccee000cceeecccceeee
-- 019:cacccccccaaaaaaacaaacaaacaaaaccccaaaaaaac8888888cc000cccecccccec
-- 020:ccca00ccaaaa0ccecaaa0ceeaaaa0ceeaaaa0cee8888ccee000cceeecccceeee
-- </TILES>

-- <WAVES>
-- 000:00000000ffffffff00000000ffffffff
-- 001:0123456789abcdeffedcba9876543210
-- 002:0123456789abcdef0123456789abcdef
-- </WAVES>

-- <SFX>
-- 000:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000304000000000
-- </SFX>

-- <TRACKS>
-- 000:100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- </TRACKS>

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>

