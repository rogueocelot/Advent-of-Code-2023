#advent of code day 4 part 1

points = 0
File.each_line("input") do |line|
  #get my numbers and the winning numbers
  winnum = line.split("|")[0].split(":")[1].split(" ").reject { |ele| ele.empty? }
  mynum = line.split("|")[1].split(" ").reject { |ele| ele.empty? }
  cardpoint = 0
  #check if each of my number is in the winning array
  mynum.each do |num|
    if winnum.includes?(num)
      #tally points by card
      if cardpoint == 0
        cardpoint += 1
      else
        cardpoint *= 2
      end
    end
  end
  points += cardpoint
end
puts points