depends = {}

Node = Struct.new(:children, :weight, :total)

File.open('day7.txt') do |f|
  f.each do |line|
    if line =~ /(\w+)\s+\((\d+)\)\s*(.*)/
      name = $1
      weight = $2
      children = if $3 =~ /-> (.*)/
                   $1.split(/, /)
                 else
                   []
                 end

      depends[name] = Node.new(children, weight.to_i, nil)
    end
  end
end

leftover = depends.keys - depends.values.map(&:children).inject(&:+)

puts("Part 1: #{leftover}")

def find_total(program, depends)
  child_weights = depends[program].children.map do |child|
    depends[child].total ||= find_total(child, depends)
  end

  (child_weights.inject(&:+) || 0) + depends[program].weight
end

depends.each do |k, v|
  v.total ||= find_total(k, depends)
end

def next_node(program, depends)
  return nil if depends[program].children == []
  children = depends[program].children
  avg = children.map { |c| depends[c].total }.inject(&:+) / children.size.to_f
  children.find { |c| depends[c].total > avg }
end

def normal_weight(program, depends)
  return nil if depends[program].children == []
  children = depends[program].children
  children.map { |c| depends[c].total }.min
end

def extra_weight(program, depends)
  return nil if depends[program].children == []
  children = depends[program].children
  children.map { |c| depends[c].total }.max
end

def balanced(program, depends)
  depends[program].children.map { |c| depends[c].total }.uniq.size < 2
end

current = leftover.first

loop do
  n = next_node(current, depends)
  if n
    if balanced(n, depends)
      desired = depends[n].weight - (extra_weight(current, depends) - normal_weight(current, depends))
      puts("Part 2: #{desired}")
      break
    else
      current = n
    end
  else
    puts("Part 2: #{normal_weight(current, depends)}")
    break
  end
end
