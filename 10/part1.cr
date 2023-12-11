#advent of code day 10 part 1

def connect(x, y, map, dir)
  #up, right, down left (clockwise)
  #connect north
  if dir == 'N'
    return true if map[x][0] == 1 && map[y][2] == 1
  elsif dir == 'S'
    return true if map[x][2] == 1 && map[y][0] == 1
  elsif dir == 'E'
    return true if map[x][1] == 1 && map[y][3] == 1
  elsif dir == 'W'
    return true if map[x][3] == 1 && map[y][1] == 1
  end
  return false
end

input = File.read_lines("input")

#map of where things connect
#up, right, down, left (clockwise)
map = {
  '|' => [1, 0, 1, 0],
  '-' => [0, 1, 0, 1],
  'L' => [1, 1, 0, 0],
  'J' => [1, 0, 0, 1],
  '7' => [0, 0, 1, 1],
  'F' => [0, 1, 1, 0],
  '.' => [0, 0, 0, 0],
  'S' => [1, 1, 1, 1]
}

#find the start point
x = 0
y = 0
(0..input.size-1).each do |i|
  (0..input[i].size-1).each do |j|
    if input[i][j] == 'S'
      x = i
      y = j
      break
    end
  end
end

i = 0

path = Array(Tuple(Int32, Int32)).new
path << {0, 0}
while true
  #print "#{input[x][y]}"
  #check north
  if (x-1 >= 0) && connect(input[x][y], input[x-1][y], map, 'N') && path[i] != {x-1, y}
    path << {x, y}
    x = x-1
  #check west
  elsif (y-1 >= 0) && connect(input[x][y], input[x][y-1], map, 'W') && path[i] != {x, y-1}
    path << {x, y}
    y = y-1
  #check south
  elsif (x+1 < input.size) && connect(input[x][y], input[x+1][y], map, 'S') && path[i] != {x+1, y}
    path << {x, y}
    x = x+1
  #check east
  elsif (y+1 < input[x].size) && connect(input[x][y], input[x][y+1], map, 'E') && path[i] != {x, y+1}
    path << {x, y}
    y = y+1
  #its either lost or solved it
  else
    break
  end
  #puts path[i]

  #reached end
  if input[x][y] == 'S'
    break
  end
  i+=1
end

#puts path
#subtract the extra added at the start
puts ((path.size-1) / 2).ceil