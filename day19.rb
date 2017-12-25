maze = []
File.open('day19.txt').each { |line| maze << line.split('') }
location = { x: maze.first.index('|'), y: 0, dir: :s }

str = []
steps = 0

loop do
  break if location[:x] < 0 || location[:y] < 0 || maze[location[:y]] == nil || maze[location[:y]][location[:x]] == nil
  curr = maze[location[:y]][location[:x]]
  break if curr == ' '
  steps += 1

  if curr =~ /[A-Z]/
    str << curr
  elsif curr == '+'    
    case location[:dir]
    when :n, :s then
          if maze[location[:y]][location[:x]+1] != ' '
            location[:dir] = :e
          else
            location[:dir] = :w
          end
    when :e, :w then
          if maze[location[:y]-1] && maze[location[:y]-1][location[:x]] != ' '
            location[:dir] = :n
          else
            location[:dir] = :s
          end
    end
  end

  case location[:dir]
  when :n then location[:y] -= 1
  when :s then location[:y] += 1
  when :e then location[:x] += 1
  when :w then location[:x] -= 1
  end
end

puts "Part 1: #{str.join}"
puts "Part 2: #{steps}"
