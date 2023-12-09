#advent of code day 8 part 1

dir = [] of Int32
input = File.read_lines("input")

temparr = input[0]
temparr = temparr.gsub("L", "0")
temparr = temparr.gsub("R", "1")
temparr = temparr.split("")

(0..temparr.size-1).each do |n|
  dir << temparr[n].to_i
end
puts dir

map = Hash(String, Tuple(String, String)).new()
(2..input.size-1).each do |n|
  dest = input[n][0..2]
  src = {input[n][7..9], input[n][12..14]}
  #puts dest
  map[dest] = src
end
#puts map
#puts temparr
x = "AAA"
steps = 0
while x != "ZZZ"
  dir.each do |n|
    steps += 1
    x = map[x][n]
    if x == "ZZZ"
      break
    end
  end
end

puts steps
