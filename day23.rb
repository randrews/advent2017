asm = []
File.open('day23.txt').each do |line|
  asm << line
end

def count_mul(asm)
  registers = Hash.new(0)
  count = 0
  pc = 0

  loop do
    break unless asm[pc]
    if asm[pc] =~ /(\S+) (\S+)\s?(\S*)/
      op, arg1, arg2 = $1, $2, ($3 || '')

      val1 = (arg1 =~ /-?\d+/) ? arg1.to_i : registers[arg1]
      val2 = (arg2 =~ /-?\d+/) ? arg2.to_i : registers[arg2]

      case op
      when 'set' then registers[arg1] = val2
      when 'sub' then registers[arg1] -= val2
      when 'mul' then registers[arg1] *= val2; count += 1
      when 'jnz' then
        if val1 != 0
          pc += val2
          next
        end
      end

      pc += 1
    end
  end

  return count
end

puts("Part 1: #{count_mul(asm)}")

class Fixnum
  def prime?
    (2 .. self-1).each do |n|
      return false if self % n == 0
    end
    return true
  end
end

n = 109900
primes = []
1001.times { primes << n unless n.prime?; n += 17; }
puts("Part 2: #{primes.size}")
