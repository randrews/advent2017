components = []
File.open('day24.txt').each do |line|
  components << line.split('/').map(&:to_i)
end

class Array
  def sum
    inject(&:+)
  end
end

def search(components, best, start = 0, bridge = [])
  possible_next = components.select { |a,b| a == start || b == start }

  if possible_next.any?
    possible = possible_next.map do |next_conn|
      comp = components.dup
      comp.delete next_conn
      other_end = (start == next_conn[0] ? next_conn[1] : next_conn[0])
      search(comp, best, other_end, bridge + [next_conn])
    end

    possible.max(&best)
  else
    bridge
  end
end

strongest = lambda { |a,b| a.flatten.sum <=> b.flatten.sum }
longest = lambda { |a,b| a.size == b.size ? strongest[a,b] : a.size <=> b.size }

puts('Part 1: ' + search(components, strongest, 0, []).flatten.sum.to_s)
puts('Part 2: ' + search(components, longest, 0, []).flatten.sum.to_s)
