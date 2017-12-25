@states = {
  a: {
    0 => [1, :r, :b],
    1 => [0, :l, :f]
  },

  b: {
    0 => [0, :r, :c],
    1 => [0, :r, :d]
  },

  c: {
    0 => [1, :l, :d],
    1 => [1, :r, :e]
  },

  d: {
    0 => [0, :l, :e],
    1 => [0, :l, :d]
  },

  e: {
    0 => [0, :r, :a],
    1 => [1, :r, :c]
  },

  f: {
    0 => [1, :l, :a],
    1 => [1, :r, :a]
  },
}

@state = :a
@tape = Hash.new(0)
@position = 0
@clock = 0

loop do
  cell = @tape[@position]
  write, dir, newstate = @states[@state][cell]

  @tape[@position] = write
  @position += (dir == :r ? 1 : -1)
  @state = newstate

  @clock += 1
  break if @clock == 12794428
end

checksum = @tape.values.select { |v| v == 1 }.count
puts("Part 1: #{checksum}")
