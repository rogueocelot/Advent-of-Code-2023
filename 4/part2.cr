#advent of code day 4 part 2

input = File.read_lines("input")
y = 0
copies = [] of Int32

(0..input.size+100).each do
  copies << 0
end
total = [] of Int32

input.each do |line|
  #get my numbers and the winning numbers
  winnum = line.split("|")[0].split(":")[1].split(" ").reject { |ele| ele.empty? }
  mynum = line.split("|")[1].split(" ").reject { |ele| ele.empty? }
  cardpoint = 0

  #check if each of my number is in the winning array
  mynum.each do |num|
    if winnum.includes?(num)
      #tally points by card
      cardpoint += 1
    end
  end

  #add a copy to the next n cards depending on points
  if cardpoint > 0
    (0..copies[y]).each do
      (y+1..y+cardpoint).each do |n|
        copies[n] += 1
      end
    end
  end
  y+=1
  
end
puts copies.sum + input.size