def ring_size(n)
  if n == 0
    1
  else
    4 + 4*n
  end
end

def coords(dest)
  x = 0
  y = 0
  n = 1
  k = 1

  loop do
    if n == dest
      return [x, y]
    elsif n > dest
      y -= 1
      k -= 2
      n -= ring_size(k) - 1
      dirs = ['n']*k + ['w']*(k+1) + ['s']*(k+1) + ['e']*k
      dirs.each do |d|
        break if n == dest
        case(d)
        when 'n' then y -= 1
        when 's' then y += 1
        when 'e' then x += 1
        when 'w' then x -= 1
        end
        n += 1
      end
      return [x, y]
    else
      n += ring_size(k)
      k += 2
      x += 1
      y += 1
    end
  end
end

def dist(n)
  coords(n).map(&:abs).inject(&:+)
end

puts("Part 1: #{dist(277678)}")

########################################

def adjacent(x,y)
  [ [x-1, y-1],
    [x, y-1],
    [x+1, y-1],
    [x-1, y],
    [x+1, y],
    [x-1, y+1],
    [x, y+1],
    [x+1, y+1] ]
end

def walk(limit)
  cells = {'0,0' => 1}
  x = 1
  y = 0
  dir = 'e'

  loop do
    sum = 0
    adjacent(x,y).each do |c|
      sum += (cells[c.join(',')] || 0)
    end
    return sum if sum > limit
    cells["#{x},#{y}"] = sum

    case(dir)
    when 'e' then dir = 'n' unless cells["#{x},#{y-1}"]
    when 'n' then dir = 'w' unless cells["#{x-1},#{y}"]
    when 'w' then dir = 's' unless cells["#{x},#{y+1}"]
    when 's' then dir = 'e' unless cells["#{x+1},#{y}"]
    end

    case(dir)
    when 'n' then y -= 1
    when 's' then y += 1
    when 'e' then x += 1
    when 'w' then x -= 1
    end
  end
end

puts("Part 2: #{walk(277678)}")
