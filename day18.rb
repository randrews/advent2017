asm = []
File.open('day18.txt').each do |line|
  asm << line
end

def run_asm(asm)
  registers = Hash.new(0)
  sound = nil

  pc = 0
  loop do
    break unless asm[pc]
    if asm[pc] =~ /(\S+) (\S+)\s?(\S*)/
      op, arg1, arg2 = $1, $2, ($3 || '')

      val1 = (arg1 =~ /-?\d+/) ? arg1.to_i : registers[arg1]
      val2 = (arg2 =~ /-?\d+/) ? arg2.to_i : registers[arg2]

      case op
      when 'snd' then sound = val1
      when 'set' then registers[arg1] = val2
      when 'add' then registers[arg1] += val2
      when 'mul' then registers[arg1] *= val2
      when 'mod' then registers[arg1] = val1 % val2
      when 'rcv' then return sound if val1 != 0
      when 'jgz' then
        if val1 > 0
          pc += val2
          next
        end
      end

      pc += 1
    end
  end

  return nil
end

def run_until_rcv(asm, vm, target)
  loop do
    break unless asm[vm[:pc]]
    if asm[vm[:pc]] =~ /(\S+) (\S+)\s?(\S*)/
      op, arg1, arg2 = $1, $2, ($3 || '')

      val1 = (arg1 =~ /-?\d+/) ? arg1.to_i : vm[:registers][arg1]
      val2 = (arg2 =~ /-?\d+/) ? arg2.to_i : vm[:registers][arg2]

      case op
      when 'snd' then
        vm[:sent] += 1
        target[:queue] << val1
      when 'set' then vm[:registers][arg1] = val2
      when 'add' then vm[:registers][arg1] += val2
      when 'mul' then vm[:registers][arg1] *= val2
      when 'mod' then vm[:registers][arg1] = val1 % val2
      when 'rcv' then
        if vm[:queue].any?
          vm[:registers][arg1] = vm[:queue].shift
        else
          return true
        end
      when 'jgz' then
        if val1 > 0
          vm[:pc] += val2
          next
        end
      end

      vm[:pc] += 1
    end
  end

  return false
end

def duet_asm(asm)
  vm1 = {
    sent: 0,
    waiting: true,
    registers: Hash.new(0),
    pc: 0,
    queue: []
  }

  vm2 = {
    sent: 0,
    waiting: true,
    registers: Hash.new(0),
    pc: 0,
    queue: []
  }

  vm2[:registers]['p'] = 1

  loop do
    vm1[:waiting] = run_until_rcv(asm, vm1, vm2) if vm1[:waiting]
    vm2[:waiting] = run_until_rcv(asm, vm2, vm1) if vm2[:waiting]

    break unless vm1[:waiting] || vm2[:waiting]
    break if (vm1[:queue].empty? && vm2[:waiting]) && (vm2[:queue].empty? && vm1[:waiting])
  end
  vm2[:sent]
end

puts("Part 1: #{run_asm(asm)}")
puts("Part 2: #{duet_asm(asm)}")
