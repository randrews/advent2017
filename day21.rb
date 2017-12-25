def rotate(arr)
  arr2 = []
  arr.size.times { arr2 << [] }

  arr.each do |row|
    row.each_with_index do |cell, x|
      arr2[x].unshift(cell)
    end
  end

  arr2
end

def flipx(arr)
  arr.map(&:dup).reverse
end

def flipy(arr)
  arr.map(&:reverse)
end

def str_to_arr(str)
  arr = [[]]
  str.each_char { |c| c == '/' ? arr << [] : arr.last << c }
  arr
end

def arr_to_str(arr)
  arr.map(&:join).join('/') 
end

def slice(arr, x0, y0, size)
  str = []
  size.times do |y|
    size.times do |x|
      str << arr[y0+y][x0+x]
    end
    str << '/'
  end

  str.join.chop
end

def blit(arr, x0, y0, pattern)
  pattern.each_with_index do |row, y|
    row.each_with_index do |cell, x|
      arr[y0+y][x0+x] = cell
    end
  end
end

def enhance(arr, rulebook)
  size = (arr.size.even? ? 2 : 3)
  out_size = (size == 2 ? arr.size / 2 * 3 : arr.size / 3 * 4)
  out = []
  out_size.times { out << [] }

  (arr.size / size).times do |by|
    (arr.size / size).times do |bx|
      pattern = slice(arr, bx*size, by*size, size)
      output = rulebook[pattern]
      blit(out, output.size * bx, output.size * by, output)
    end
  end

  out
end

def count(arr)
  c = 0
  arr.each do |row|
    row.each do |cell|
      c += 1 if cell == '#'
    end
  end
  c
end

rulebook = {}

File.open('day21.txt').each do |line|
  pattern, output = line.strip.split(' => ')

  pattern = str_to_arr(pattern)
  output = str_to_arr(output)

  4.times do
    rulebook[arr_to_str(pattern)] = output
    rulebook[arr_to_str(flipx(pattern))] = output
    rulebook[arr_to_str(flipy(pattern))] = output
    pattern = rotate(pattern)
  end
end

image = str_to_arr('.#./..#/###')
5.times { image = enhance(image, rulebook) }
puts("Part 1: #{count(image)}")
13.times { image = enhance(image, rulebook) }
puts("Part 2: #{count(image)}")
