#advent of code day 3 part 1

def getfullnum(line : String)
  startpos = 8000
  n = 0
  coords = Array(Array(Int32)).new()
  line.each_char do |char|
    #start of new number
    if char.number? && startpos == 8000
      startpos = n
    #finding end of number and reseting
    elsif !char.number? && startpos != 8000
      coords << (startpos..n-1).to_a
      startpos = 8000
    end
    n += 1
  end
  if startpos != 8000
    coords << (startpos..n-1).to_a
    startpos = 8000
  end
  #get array of just the numbers
  line = line.split(/[^0-9]/)
  line = line.reject { |ele| ele.empty? }
  return line, coords
end

def check(linenum, linepos, x, sum)
  #see if the position overlaps with number
  n = linepos.index { |arr| arr.includes?(x) }
  n2 = linepos.index { |arr| arr.includes?(x + 1) }
  n3 = linepos.index { |arr| arr.includes?(x - 1) }
  #n is nil if there are no matches
  add1 = 0
  add2 = 0
  add3 = 0
  if n
    add1 = linenum[n].to_i
  end
  if n2
    add2 = linenum[n2].to_i
  end
  if n3
    add3 = linenum[n3].to_i
  end
  #remove duplicates (where symbol is adjacent to multiple digits of the same number)
  if add1 == add2
    add2 = 0
  end
  if add1 == add3
    add3 = 0
  end
  if add2 == add3
    add3 = 0
  end
  #add and return sum
  sum += (add1 + add2 + add3)
  return sum
end

input = File.read_lines("input")
sum = 0
y = 0
input.each do |line|
  x = 0
  #linenum, linepos = getfullnum(line)
  line.each_char do |char|
    #if the char is a symbol
    if !char.number? && char != '.'
      #check current line
      linenum, linepos = getfullnum(input[y])
      sum = check(linenum, linepos, x, sum)

      #check previous line
      if y > 0
        linenum, linepos = getfullnum(input[y-1])
        sum = check(linenum, linepos, x, sum)
      end

      #check next line
      if y < input.size + 1
        linenum, linepos = getfullnum(input[y+1])
        sum = check(linenum, linepos, x, sum)
      end

    end
    x += 1
  end
  y += 1
end
puts sum