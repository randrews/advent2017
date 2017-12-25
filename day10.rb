lengths = [187,254,0,81,169,219,1,190,19,102,255,56,46,32,2,216]
arr = (0..255).to_a
pos = 0

def twist(arr, pos, len, skip)
  arr = arr.dup
  pos.times { arr.push(arr.shift) }
  first, rest = if len > 0
                  [arr[0..len-1], arr[len..arr.size]]
                else
                  [[], arr]
                end
  arr = rest + first.reverse
  skip.times { arr.push(arr.shift) }
  (pos+len+skip).times { arr.unshift(arr.pop) }
  [(pos+len+skip) % arr.length, arr]
end

lengths.each_with_index do |len, skip|
  pos, arr = twist(arr, pos, len, skip)
end

puts("Part 1: #{arr[0]*arr[1]}")

def hash_str(str)
  lengths = str.split(//).map(&:ord) + [17, 31, 73, 47, 23]
  arr = (0..255).to_a
  pos = skip = 0

  64.times do
    lengths.each do |len|
      pos, arr = twist(arr, pos, len, skip)
      skip += 1
    end
  end

  sums = []
  16.times do |n|
    segment, arr = arr[0..15], arr[16..-1]
    sums << segment.reduce { |a,b| a^b }
  end

  sums.map { |s| s.to_s(16) }.join
end

str = lengths.map(&:to_s).join(',')
puts("Part 2: #{hash_str(str)}")
