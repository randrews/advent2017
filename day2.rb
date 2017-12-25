File.open('day2.txt') do |f|
  line_sums = f.map do |line|
    a = line.split(/\s/).map(&:to_i)
    a.max - a.min
  end
  puts('Part 1: ' + line_sums.inject(&:+).to_s)
end

def divisible(row)
  row.each_with_index do |n, idx|
    ((idx+1) .. (row.size-1)).each do |k|
      n2 = row[k]
      if (n > n2 && n%n2 == 0) || (n2 > n && n2%n == 0)
        return [n, n2].sort.reverse
      end
    end
  end
end

File.open('day2.txt') do |f|
  line_sums = f.map do |line|
    a = line.split(/\s/).map(&:to_i)
    vals = divisible(a)
    vals[0] / vals[1]
  end
  puts('Part 2: ' + line_sums.inject(&:+).to_s)
end
