def dance(programs)
  programs = programs.dup
  
  dance = File.read('day16.txt').split(',')
  swaps = []
  dance.each do |move|
    if move =~ /s(\d+)/
      len = $1.to_i
      programs = programs[-len .. -1] + programs[0 .. (programs.size-len-1)]
    elsif move =~ /x(\d+)\/(\d+)/
      a, b = $1.to_i, $2.to_i
      programs[a], programs[b] = programs[b], programs[a]
    elsif move =~ /p(.)\/(.)/
      a, b = programs.index($1), programs.index($2)
      programs[a], programs[b] = programs[b], programs[a]
    end
  end

  programs
end

programs = dance(('a'..'p').to_a)
puts("Part 1: #{programs.join}")

seen = []
programs = ('a'..'p').to_a
1_000_000_000.times do |n|
  if seen.include?(programs)
    puts("Part 2: #{seen[1_000_000_000 % n].join}")
    break
  end

  seen << programs.dup
  programs = dance(programs)
end



