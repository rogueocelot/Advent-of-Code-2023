#advent of code day 1 part 2

#outputNum = [] of String
sum = 0
File.each_line("input") do |line|
  numCount = 0
  num1 = "0"
  num2 = "0"
  #replace the words with numbers before parsing
  line = line.gsub("one") {"o1e"}
  line = line.gsub("two", "t2o")
  line = line.gsub("three", "t3e")
  line = line.gsub("four", "f4r")
  line = line.gsub("five", "f5e")
  line = line.gsub("six", "s6x")
  line = line.gsub("seven", "s7n")
  line = line.gsub("eight", "e8t")
  line = line.gsub("nine", "n9e")
  line = line.gsub("zero", "z0o")
  #puts line
  line.each_char do |char|
    if char.number?
      num1 = char if numCount == 0
      num2 = char if numCount == 0
      num2 = char if numCount > 0
      numCount += 1
    end
  end
   outputNum = "%s%s" % [num1, num2]
   #puts outputNum
   sum += outputNum.to_i
end

puts sum
