jumps = []
File.open('day5.txt') do |f|
  f.each { |line| jumps << line.to_i }
end

pc = 0
clk = 0
while pc >= 0 && pc < jumps.length
  old = pc
  pc += jumps[pc]
  jumps[old] += 1
  clk += 1
end

puts("Part 1: #{clk}")

jumps = []
File.open('day5.txt') do |f|
  f.each { |line| jumps << line.to_i }
end

pc = 0
clk = 0
while pc >= 0 && pc < jumps.length
  old = pc
  pc += jumps[pc]
  if jumps[old] >= 3
    jumps[old] -= 1
  else
    jumps[old] += 1
  end
  clk += 1
end

puts("Part 2: #{clk}")
