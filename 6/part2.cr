#advent of code day 6 part 2

input = File.read_lines("input")

timetemp = input[0].split(":")[1].split(" ").reject { |ele| ele.empty? }
time = "#{timetemp[0]}#{timetemp[1]}#{timetemp[2]}#{timetemp[3]}"
time = time.to_i64
disttemp = input[1].split(":")[1].split(" ").reject { |ele| ele.empty? }
dist = "#{disttemp[0]}#{disttemp[1]}#{disttemp[2]}#{disttemp[3]}"
dist = dist.to_i64

speed = 0_i64
ways = 0_i64
while time > 0
  if speed * time > dist
    ways += 1
  end
  speed += 1
  time -= 1
end

puts ways