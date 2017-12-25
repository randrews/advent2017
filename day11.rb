dirs = {
  'n' => [0, 1, -1],
  's' => [0, -1, 1],

  'ne' => [1, 0, -1],
  'sw' => [-1, 0, 1],

  'nw' => [-1, 1, 0],
  'se' => [1, -1, 0]
}

steps = Hash.new(0)
File.read('day11.txt').strip.split(',').each do |step|
  steps[step] += 1
end

[['n', 's'], ['ne', 'sw'], ['nw', 'se']].each do |a, b|
  b, a = a, b if steps[a] > steps[b]
  steps[a] -= steps[b]
  steps.delete(b)
end

x, y, z = 0, 0, 0
steps.each do |dir, dist|
  delta = dirs[dir]
  x += delta[0] * dist
  y += delta[1] * dist
  z += delta[2] * dist
end

dist = [x, y, z].map(&:abs).inject(&:+) / 2
puts("Part 1: #{dist}")

x, y, z = 0, 0, 0
max_dist = 0
File.read('day11.txt').strip.split(',').each do |step|
  delta = dirs[step]
  x += delta[0]
  y += delta[1]
  z += delta[2]
  dist = [x, y, z].map(&:abs).inject(&:+) / 2
  max_dist = [max_dist, dist].max
end

puts("Part 2: #{max_dist}")
