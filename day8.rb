regs = Hash.new(0)

def check(regs, reg, op, arg)
  val = regs[reg]
  eval "#{val} #{op} #{arg}"
end

all_max = 0

File.open('day8.txt') do |f|
  f.each do |line|
    if line =~ /(\w+) (inc|dec) (\S+) if (\w+) (\S+) (\S+)/
      if check(regs, $4, $5, $6)
        if $2 == 'inc'
          regs[$1] += $3.to_i
        else
          regs[$1] -= $3.to_i
        end
      end
    end

    all_max = [all_max, regs.values.max].compact.max
  end
end

puts("Part 1: #{regs.values.max}")
puts("Part 2: #{all_max}")
