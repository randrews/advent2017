class Array
  def sum
    inject(&:+)
  end
end

@turn_right = {
  n: :e,
  e: :s,
  s: :w,
  w: :n
}

@turn_left = {
  n: :w,
  e: :n,
  s: :e,
  w: :s
}

@reverse = {
  n: :s,
  s: :n,
  e: :w,
  w: :e
}

@dirs = {
  n: [0, -1],
  s: [0, 1],
  e: [1, 0],
  w: [-1, 0]
}

def tick(map, pos, dir)
  infected = false

  k = pos.join(',')
  dir = if map[k] == '#'
          @turn_right[dir]
        else
          @turn_left[dir]
        end

  if map[k] == '#'
    map.delete k
  else
    map[k] = '#'
    infected = true
  end

  pos = pos.zip(@dirs[dir]).map(&:sum)

  [pos, dir, infected]
end

def weaken_tick(map, pos, dir)
  infected = false

  k = pos.join(',')
  dir = case map[k]
        when '.' then @turn_left[dir]
        when 'w' then dir
        when '#' then @turn_right[dir]
        when 'f' then @reverse[dir]
        end

  case map[k]
  when '.' then map[k] = 'w'
  when 'w' then map[k] = '#'; infected = true
  when '#' then map[k] = 'f'
  when 'f' then map.delete k
  end

  pos = pos.zip(@dirs[dir]).map(&:sum)

  [pos, dir, infected]
end

def read_map
  map = Hash.new('.')
  lines = []
  File.open('day22.txt').each { |line| lines << line.strip.split('') }
  lines.each_with_index { |line, y| line.each_with_index { |ch, x| map["#{x},#{y}"] = '#' if ch == '#' } }
  [map, lines.size]
end

map, size = read_map
pos = [size / 2, size / 2]
dir = :n

count = 0
10000.times do
  pos, dir, inf = tick(map, pos, dir)
  count += 1 if inf
end

puts "Part 1: #{count}"

map, size = read_map
pos = [size / 2, size / 2]
dir = :n

count = 0
10000000.times do
  pos, dir, inf = weaken_tick(map, pos, dir)
  count += 1 if inf
end

puts "Part 2: #{count}"
