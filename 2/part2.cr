#advent of code day 2 part 2

sum = 0
File.each_line("input") do |line|
  #get the game number part of the line
  #game = line.split(':')[0].split(' ')[1]

  #seperate the 'hands'
  hands = line.split(/[,;:]/)

  redMax = 0
  greenMax = 0
  blueMax = 0

  #check the hands
  hands.each do |hand|
    hand = hand.split(' ')
    hand = hand.reject { |ele| ele.empty? }

    #find the greatest number for each color
    if hand[1] == "red" && hand[0].to_i > redMax
      redMax = hand[0].to_i if redMax < hand[0].to_i
    elsif hand[1] == "blue" && hand[0].to_i > blueMax
      blueMax = hand[0].to_i if blueMax < hand[0].to_i
    elsif hand[1] == "green" && hand[0].to_i > greenMax
      greenMax = hand[0].to_i if greenMax < hand[0].to_i
    end
  end
  sum = sum + (redMax * blueMax * greenMax)

end
puts sum