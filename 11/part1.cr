#advent of code day 11 part 1


input2 = File.read_lines("input")

input = Array(Array(Char)).new
(0..input2.size-1).each do |i|
  input << input2[i].chars
end

#double any blank rows
toinsert = [] of Int32
(0..input.size-1).each do |i|
  if !(input[i].index('#'))
    toinsert << i
  end
end

(0..toinsert.size-1).each do |i|
  input.insert(toinsert[i]+i, input[toinsert[i]+i])
end


#transpose and check blank columns (now rows)
input = input.transpose
toinsert = [] of Int32
(0..input.size-1).each do |i|
  #reverse the row
  input[i] = input[i].reverse
  if !(input[i].index('#'))
    toinsert << i
 end
end

(0..toinsert.size-1).each do |i|
  input.insert(toinsert[i]+i, input[toinsert[i]+i])
end

#find all galxies
gal = Array(Tuple(Int32, Int32)).new
input.each_with_index do |arr, i|
  arr.each_with_index do |char, j|
    if char == '#'
      gal << {i, j}
    end
  end
end

#find the closest galaxy
dist = 0
k = 0
gal.each_with_index do |g, i|
  (0..gal.size-1).each do |j|
    if i == j
      next
    elsif
      dist += ((g[0] - gal[j][0]).abs) + ((g[1] - gal[j][1]).abs)
    end
  end
end
dist = dist//2
puts dist