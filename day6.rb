memory = File.read('day6.txt').split(/\s+/).map(&:to_i)

states = { memory.join(',') => 0 }
count = 0
move_number = nil

loop do
  hand = memory.max
  idx = memory.index(hand)
  memory[idx] = 0
  idx += 1
  while hand > 0
    memory[idx % memory.size] += 1
    hand -= 1
    idx += 1
  end
  count += 1
  move_number = states[memory.join(',')]
  break if move_number
  states[memory.join(',')] = count
end

puts("Part 1: #{count}")
puts("Part 2: #{count - move_number}")
