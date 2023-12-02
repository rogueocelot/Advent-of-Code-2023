#advent of code day 2 part 1

redMax = 12
greenMax = 13
blueMax = 14
sum = 0
lastGame = 0
File.each_line("input") do |line|
  #get the game number part of the line
  #game = line.split(':')[0].split(' ')[1]

  #seperate the 'hands'
  hands = line.split(/[,;:]/)

  redPass = true
  bluePass = true
  greenPass = true

  #check the hands
  hands.each do |hand|
    hand = hand.split(' ')
    hand = hand.reject { |ele| ele.empty? }

    #get the most recent game number
    if hand[0] == "Game"
      lastGame = hand[1].to_i
    #if any color is greater than its max add lastGame to the sum
    elsif hand[1] == "red" && hand[0].to_i > redMax
      redPass = false
    elsif hand[1] == "blue" && hand[0].to_i > blueMax
      bluePass = false
    elsif hand[1] == "green" && hand[0].to_i > greenMax
      greenPass = false
    end
  end

  if redPass && bluePass && greenPass
    sum += lastGame
  end

end

puts sum