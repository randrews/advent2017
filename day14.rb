input = 'uugsqrei'

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

  sums.map { |s| s.to_s(16) }.map {|d| d.length < 2 ? "0#{d}" : d.to_s }.join
end

bits = {
  '0' => 0,
  '1' => 1,
  '2' => 1,
  '3' => 2,
  '4' => 1,
  '5' => 2,
  '6' => 2,
  '7' => 3,
  '8' => 1,
  '9' => 2,
  'a' => 2,
  'b' => 3,
  'c' => 2,
  'd' => 3,
  'e' => 3,
  'f' => 4,
}

input = 'uugsqrei'

# rows = (0..127).map do |n|
#   hash = hash_str("#{input}-#{n}")
#   hash.split('').map {|let| bits[let] }.inject(&:+)
# end

# puts(rows.inject(&:+))

squares = {
  '0' => [0, 0, 0, 0],
  '1' => [0, 0, 0, 1],
  '2' => [0, 0, 1, 0],
  '3' => [0, 0, 1, 1],
  '4' => [0, 1, 0, 0],
  '5' => [0, 1, 0, 1],
  '6' => [0, 1, 1, 0],
  '7' => [0, 1, 1, 1],
  '8' => [1, 0, 0, 0],
  '9' => [1, 0, 0, 1],
  'a' => [1, 0, 1, 0],
  'b' => [1, 0, 1, 1],
  'c' => [1, 1, 0, 0],
  'd' => [1, 1, 0, 1],
  'e' => [1, 1, 1, 0],
  'f' => [1, 1, 1, 1],
}

@rows ||= (0..127).map do |n|
  hash = hash_str("#{input}-#{n}")
  hash.split(//).map {|let| squares[let] }.inject(&:+)
end

def search(grid, start)
  open = [start]
  count = open.size
  closed = []
  while open.any?
    node = open.shift
    closed << node
    
    adj = []
    if node[:x]>0 && grid[node[:y]][node[:x]-1] == 1
      adj << {x: node[:x]-1, y: node[:y] }
    end
    if node[:x]<127 && grid[node[:y]][node[:x]+1] == 1
      adj << {x: node[:x]+1, y: node[:y] }
    end
    if node[:y]>0 && grid[node[:y]-1][node[:x]] == 1
      adj << {x: node[:x], y: node[:y]-1 }
    end
    if node[:y]<127 && grid[node[:y]+1][node[:x]] == 1
      adj << {x: node[:x], y: node[:y]+1 }
    end

    adj.each do |n|
      next if closed.index(n)
      next if open.index(n)
      count += 1
      open << n
    end
  end

  closed
end

def find_start(grid)
  (0..127).each do |y|
    (0..127).each do |x|
      if grid[y][x] == 1
        return {x: x, y: y}
      end
    end
  end
  nil
end

def reset(grid)
  (0..127).each do |y|
    (0..127).each do |x|
      grid[y][x] = 1 if grid[y][x] != 0
    end
  end
end

curr_grp = 'a'
group_num = 0

loop do
  st = find_start(@rows)
  break unless st
  group_num += 1
  group = search(@rows, st)

  group.each do |n|
    @rows[n[:y]][n[:x]] = curr_grp
  end

  curr_grp = curr_grp.succ
end

reset(@rows)

puts group_num
