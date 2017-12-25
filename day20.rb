class Particle
  attr_reader :num

  def initialize(line, num)
    @num = num

    if line =~ /p=<(.*?),(.*?),(.*?)>, v=<(.*?),(.*?),(.*?)>, a=<(.*?),(.*?),(.*?)>/
      @px=$1.to_i
      @py=$2.to_i
      @pz=$3.to_i

      @vx=$4.to_i
      @vy=$5.to_i
      @vz=$6.to_i

      @ax=$7.to_i
      @ay=$8.to_i
      @az=$9.to_i
    end
  end

  def tick
    @vx += @ax
    @vy += @ay
    @vz += @az

    @px += @vx
    @py += @vy
    @pz += @vz
  end

  def dist
    @px.abs + @py.abs + @pz.abs
  end

  def loc
    [@px, @py, @pz]
  end
end

lines = []
File.open('day20.txt').each do |line|
  lines << line
end

particles = []
lines.each_with_index { |line, num| particles << Particle.new(line, num) }
1000.times { particles.map(&:tick) }
closest = particles.min { |a,b| a.dist <=> b.dist }

puts "Part 1: #{closest.num}"

def collide(particles)
  locs = {}
  to_delete = []

  particles.each do |p|
    loc = p.loc.join(',')
    if locs[loc]
      to_delete << p
      to_delete << locs[loc]
    end
    locs[loc] = p
  end

  particles - to_delete.uniq
end

particles = []
lines.each_with_index { |line, num| particles << Particle.new(line, num) }
1000.times { particles.map(&:tick); particles = collide(particles) }
puts "Part 2: #{particles.count}"
