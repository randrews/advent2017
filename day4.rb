File.open('day4.txt') do |f|
  valid = 0
  f.each do |line|
    words = line.split(/\s+/)
    valid += 1 if words.size == words.uniq.size
  end

  puts("Part 1: #{valid}")
end

def normalize(word)
  word.split(//).sort.join
end

File.open('day4.txt') do |f|
  valid = 0
  f.each do |line|
    words = line.split(/\s+/).map{|w| normalize(w) }
    valid += 1 if words.size == words.uniq.size
  end

  puts("Part 2: #{valid}")
end
