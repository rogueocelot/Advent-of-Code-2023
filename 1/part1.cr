#advent of code day 1 part 1

#outputNum = [] of String
sum = 0
File.each_line("input") do |line|
  numCount = 0
  num1 = "0"
  num2 = "0"
  line.each_char do |char|
    #if char =~ /[0-9]/
    if char.number?
      num1 = char if numCount == 0
      num2 = char if numCount == 0
      num2 = char if numCount > 0
      numCount += 1
    end
  end
   outputNum = "%s%s" % [num1, num2]
   sum += outputNum.to_i
end

puts sum
