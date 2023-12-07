#advent of code day 5 part 1

struct Info
  property start, finish, offset

  def initialize(@start : Int64, @finish : Int64, @offset : Int64)
  end
end

#function to map the inputs to the hash
def mapnumbers(temp)
  tempinfo = [] of Info
  temp.each do |line|
    #parse the 3 numebrs
    num1 = line.split(" ")[0].to_i64
    num2 = line.split(" ")[1].to_i64
    range = line.split(" ")[2].to_i64

    tempinfo << Info.new num1, num1+range, num1-num2

  end
  tempinfo
end

#search for a match
def search(temp, n : Int64)
  q = 0_i64
  #add the offset to the passed in number and see if it matches any defined ranges
  temp.each do |x|
    if(n + x.offset) >= x.start && (n + x.offset) <= x.finish
      q = n + x.offset
      break
    end
  end
  #if it didnt match any defined ranges, it equals the passed in number
  q = n if q == 0
  return q
end

input = File.read_lines("input")
y = 0
x = 0
start = 0

#get seed numbers
seeds = [] of Int64
seedtemp = input[0].split(":")[1].split(" ").reject { |ele| ele.empty? }
seedtemp.each do |ele|
  seeds << ele.to_i64
end

temp = [] of String
#all the maps
seedsoil = [] of Info
soilfert = [] of Info
fertwater = [] of Info
waterlight = [] of Info
lighttemp = [] of Info
temphumid = [] of Info
humidloc = [] of Info

#parse the input
input.each do |line|
  #every empty line encountered
  if line == ""
    if y == 0
      #start of section
      start = x + 2
    #capture the seed to soil section (and likewise for all others)
    else
      #append each line from the start of the section to before this empty line
      (start..x-1).each do |n|
        temp << input[n]
      end
      seedsoil = mapnumbers(temp) if y == 1
      soilfert = mapnumbers(temp) if y == 2
      fertwater = mapnumbers(temp) if y == 3
      waterlight = mapnumbers(temp) if y == 4
      lighttemp = mapnumbers(temp) if y == 5
      temphumid = mapnumbers(temp) if y == 6
      humidloc = mapnumbers(temp) if y == 7
      start = x + 2
      temp = [] of String
    end

    y += 1
  end
  x += 1
end

#traverse the data
min = [] of Int64
seeds.each do |n|
  #print "finding #{n}"

  q = search(seedsoil, n)
  w = search(soilfert, q)
  e = search(fertwater, w)
  r = search(waterlight, e)
  t = search(lighttemp, r)
  y = search(temphumid, t)
  u = search(humidloc, y)

  min << u
  #print "found #{n}: #{u}"
end

puts min.sort![0]
#File.write("output", "#{min.sort![0]}")