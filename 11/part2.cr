#advent of code day 11 part 2


input2 = File.read_lines("input")

input = Array(Array(Char)).new
(0..input2.size-1).each do |i|
  input << input2[i].chars
end

#double any blank rows
toinsert = [] of Int32
(0..input.size-1).each do |i|
  if !(input[i].index('#'))
    #reverse it so it still works with the transposed one
    toinsert << (input[i].size-1)-i
  end
end

#transpose and check blank columns (now rows)
input = input.transpose
toinsertcol = [] of Int32
(0..input.size-1).each do |i|
  #reverse the row
  input[i] = input[i].reverse
  if !(input[i].index('#'))
    toinsertcol << i
 end
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
dist = 0_i64
k = 0
gal.each_with_index do |g, i|
  (0..gal.size-1).each do |j|
    if i == j
      next
    else
      dist += ((g[0] - gal[j][0]).abs) + ((g[1] - gal[j][1]).abs)
      #cross any empty rows or cols small-large (one gets counted during the initial distance)
      ((g[0]..gal[j][0]).to_a&toinsertcol).each { dist += 999999 }
      ((g[1]..gal[j][1]).to_a&toinsert).each { dist += 999999 }
      #cross any empty rows or cols large-small
      ((g[0]..gal[j][0]).step.to_a&toinsertcol).each { dist += 999999 }
      ((g[1]..gal[j][1]).step.to_a&toinsert).each { dist += 999999 }
    end
  end
end
dist = dist//2
puts dist