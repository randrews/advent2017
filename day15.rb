def gen(prev, factor)
  (prev * factor) % 2147483647
end

genA, genB = 512, 191
count = 0

40_000_000.times do
  genA = gen(genA, 16807)
  genB = gen(genB, 48271)

  count += 1 if (genA & 0xffff) == (genB & 0xffff)
end

puts("Part 1: #{count}")
