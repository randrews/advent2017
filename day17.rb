def spin(num, dist)
  node = [0, nil]
  node[1] = node

  (1..num).each do |n|
    print('.') if n%100000 == 0
    dist.times { node = node[1] }
    new_node = [n, node[1]]
    node[1] = new_node
    node = new_node
  end

  node
end

node = spin(2017, 316)
puts("Part 1: #{node[1][0]}")

node = spin(50_000_000, 316)
node = node[1] while node[0] != 0
puts("Part 2: #{node[1][0]}")

# steps = 316
# pos = 0
# value = nil
# (1..50000000).each do |i|
#   pos = (pos + steps) % i
#   pos += 1
#   value = i if pos == 1
# end
# puts value
