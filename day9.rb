stream = File.read('day9.txt')
level = 0
total = 0
mode = :normal
oldmode = nil
garbage = 0

stream.each_char do |char|
  case mode
  when :normal then
    if char == '{'
      level += 1
      total += level
    elsif char == '}'
      level -= 1
    elsif char == '!'
      oldmode = mode
      mode = :cancel
    elsif char == '<'
      mode = :garbage
    end
  when :garbage then
    if char == '!'
      oldmode = mode
      mode = :cancel
    elsif char == '>'
      mode = :normal
    else
      garbage += 1
    end
  when :cancel then
    mode = oldmode
  end
end

puts("Part 1: #{total}")
puts("Part 2: #{garbage}")
