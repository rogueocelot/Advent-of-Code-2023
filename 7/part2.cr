#advent of code day 7 part 1

class Hand
  def initialize(@cards : Array(Int32), @rank : Int32, @score : Int32)
  end
  getter cards, rank, score
  setter rank
end

#points for the bucket:
#five of a kind : 6 points
#four of a kind : 5 points
#full house: 4 total : 3 for triple, 1 for pair
#three of a kind : 3 points
#two paint: 2 total, 1 per pair
#one pair: 1 point
#high card: 0 points
def handPoints(hand)
  j = 0
  j = hand.tally[1] if hand.tally.has_key?(1)
  #remove jacks and reverse sort so the jacks get paired with the highest combo
  temp = hand.tally.to_a.sort_by { |k, v| v}.reverse.to_h
  temp.delete(1)
  score = 0
  temp.each_value do |n|
    if (n + j) == 5
      score += 6
      j = 0
    elsif (n + j) == 4
      score += 5
      j = 0
    elsif (n + j) == 3
      score += 3
      j = 0
    elsif (n + j) == 2
      score += 1
      j = 0
    end
  end
  #if all are jacks
  score = 6 if j == 5
  score
end

hands = Array(Array(Hand)).new(7) { Array(Hand).new() }
File.each_line("input") do |line|
  tempstring = line.split(" ")[0].split("").join("")
  tempscore = line.split(" ")[1].to_i
  temphand = [] of Int32
  score = 0

  tempstring.each_char do |c|
    if c.number?
      temphand << c.to_i
    elsif c == 'T'
      temphand << 10
    elsif c == 'J'
      temphand << 1
    elsif c == 'Q'
      temphand << 12
    elsif c == 'K'
      temphand << 13
    elsif c == 'A'
      temphand << 14
    end
  end

  score = handPoints(temphand)
  temp = Hand.new(temphand, 0, tempscore)
  hands[score] << temp

end

#bubble sort each bucket
(0..6).each do |i|
  swap = true
  #each hand per bucket
  while swap
    swap = false
    break if hands[i].size() <= 1
    (0..hands[i].size()-2).each do |j|
      #each card in each hand
      (0..4).each do |k|
        #i want least to greatest so i can just count rank when i iterate
        if hands[i][j].cards[k] > hands[i][j+1].cards[k]
          hands[i][j], hands[i][j+1] = hands[i][j+1], hands[i][j] 
          swap = true
          break
        #right order
        elsif hands[i][j].cards[k] < hands[i][j+1].cards[k]
          #swap = false
          break
        #equal, proceed to next loop
        else
          
        end
      end
    end
  end
end

#get total based on rank
sum = 0
counter = 1
(0..hands.size()-1).each do |i|
  (0..hands[i].size()-1).each do |j|
    sum += (hands[i][j].score * counter)
    counter += 1
  end
end

puts sum