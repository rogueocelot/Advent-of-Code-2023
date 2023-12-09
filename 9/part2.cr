#advent of code day 9 part 2

def finddiff(arr)
  diff = [] of Int32
  #start at second index
  (1..arr.size-1).each do |i|
    temp = arr[i] - arr[i-1]
    diff << temp
  end
  return diff
end

def findsum(ans)
  sum = 0
  (ans.size-1).step(to: 0).each do |i|
    #print "loop: #{i}, sum: #{ans[i].last} + #{ans[i-1].last} \n"
    ans[i-1] << (ans[i].last + ans[i-1].last)
  end
  sum = ans[0].last
  sum
end

def findleft(ans)
  (0..ans.size-1).each do |i|
    ans[i].insert(0, 0)
  end
  sum = 0
  (ans.size-1).step(to: 0).each do |i|
    #print "loop: #{i}, sum: #{ans[i].last} + #{ans[i-1].last} \n"
    ans[i-1][0] = (ans[i-1][1] - ans[i][0])
  end
  sum = ans[0][0]
  sum
end

input = File.read_lines("input")

arr = Array(Array(Int32)).new()
sum = 0
input.each do |line|
  arr << line.split(" ").map { |i| i.to_i }
end

(0..arr.size-1).each do |i|
  ans = Array(Array(Int32)).new()
  ans << arr[i]
  run = true
  #check if the largest element is 0
  while run
    run = true
    #if the element isnt 0, pass it the last array
    ans << finddiff(ans[ans.size-1])
    run = false if ans[ans.size-1].last == 0 && ans[ans.size-1][0] == 0

    #puts ans
  end
  sum += findleft(ans)
end

puts sum