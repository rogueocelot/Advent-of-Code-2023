#advent of code day 8 part 2

#since there are always n number of full instruction sets before it ends on a '__Z', find those numbers
def search(steps, x, map, dir)
  g = true
  while g
    (0..dir.size-1).each do |n|
      steps += 1
      x = map[x][dir[n]]
      if x[2] == 'Z' && n == dir.size-1
        g = false
        break
      end
    end
    if x[2] == 'Z' && g == false
      break
    end
  end
  return steps
end

#gcd and lcm algorithms (learned the hard way this is not pratically brute forcable)
def gcd(x : UInt64, y : UInt64)
  if y == 0
    x
  else
    gcd(y, (x % y))
  end
end

def lcm(x : UInt64, y : UInt64)
  ((x//gcd(x, y)) * y)
end


dir = [] of Int32
input = File.read_lines("input")

temparr = input[0]
temparr = temparr.gsub("L", "0")
temparr = temparr.gsub("R", "1")
temparr = temparr.split("")

(0..temparr.size-1).each do |n|
  dir << temparr[n].to_i
end

map = Hash(String, Tuple(String, String)).new()
starts = [] of String
(2..input.size-1).each do |n|
  dest = input[n][0..2]
  src = {input[n][7..9], input[n][12..14]}
  if input[n][2] == 'A'
    starts << dest
  end
  map[dest] = src
end

steps = Array(UInt64).new(starts.size, 0)
#get the number of steps for each start
(0..starts.size-1).each do |i|
  steps[i] = search(steps[i], starts[i], map, dir)
end

#find the lcm of the steps from above
#its certainly not the cleanest line ive ever written
e = lcm(steps[0], lcm(steps[1], lcm(steps[2], lcm(steps[3], (lcm(steps[4], steps[5]))))))
print "#{e}\n"