pipes = {}
File.open('day12.txt') do |f|
  f.each do |line|
    if line =~ /(\d+) <-> (.*)/
      prog1 = $1.to_i
      $2.split(', ').map(&:to_i).each do |prog2|
        pipes[prog1] ||= []
        pipes[prog2] ||= []
        pipes[prog1] << prog2
        pipes[prog2] << prog1
      end
    end
  end
end

pipes.values.map(&:uniq!)

pipes.each do |k,v|
  v.delete(k)
end

def search(pipes, open)
  count = open.size
  closed = []
  while open.any?
    node = open.shift
    closed << node
    adj = pipes[node]
    adj.each do |n|
      next if closed.index(n)
      next if open.index(n)
      count += 1
      open << n
    end
  end

  closed
end

puts("Part 1: #{search(pipes, [0]).size}")

groups = {}
group_count = 0

pipes.keys.sort.each do |start|
  next if groups[start]
  group = search(pipes, [start])
  group.each { |g| groups[g] = group_count }
  group_count += 1
end

puts("Part 2: #{groups.values.uniq.size}")
