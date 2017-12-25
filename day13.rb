layers = {}

File.open('day13.txt') do |f|
  f.each do |line|
    if line =~ /(\d+): (\d+)/
      depth, range = $1.to_i, $2.to_i
      layers[depth] = range
    end
  end
end

def walk(layers, delay = 0)
  if delay > 0
    (0 .. (layers.keys.max)).each do |loc|
      next unless layers[loc]
      pos = (delay + loc) % ((layers[loc]-1)*2)
      return false if pos == 0
    end
    return true
  else
    severity = 0

    (0 .. (layers.keys.max)).each do |loc|
      next unless layers[loc]
      if (delay + loc) % ((layers[loc]-1)*2) == 0
        severity += loc * layers[loc]
      end
    end
    severity
  end
end

puts("Part 1: #{walk(layers)}")

n = 0
sev = false
until sev
  n += 1
  sev = walk(layers, n)
end

puts("Part 2: #{n}")
  
