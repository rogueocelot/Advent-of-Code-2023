#advent of code day 6 part 1

input = File.read_lines("input")
time = [] of Int32
dist = [] of Int32

timetemp = input[0].split(":")[1].split(" ").reject { |ele| ele.empty? }
timetemp.each do |ele|
  time << ele.to_i
end

disttemp = input[1].split(":")[1].split(" ").reject { |ele| ele.empty? }
disttemp.each do |ele|
  dist << ele.to_i
end

speed = 0
ways = [0, 0, 0, 0]
x = 0
time.each do |run|
  speed = 0
  (0..run).each do |i|
    speed += 1
    run -= 1
    if speed * run > dist[x]
      ways[x] += 1
    end
  end
  x += 1
end
puts ways[0] * ways[1] * ways[2] * ways[3]