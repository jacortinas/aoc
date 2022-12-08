p1_overlaps = 0

input = File.readlines('input.in')

input.each.with_index do |line, index|
  first, second = *line.strip.split(',').map do |r|
    a, z = *r.split('-', 2).map(&:to_i)
    Range.new(a, z)
  end

  p1_overlaps += 1 if first.cover?(second) || second.cover?(first)
end

puts "Part 1: #{p1_overlaps}"

p2_overlaps = 0

input.each.with_index do |line, index|
  first, second = *line.strip.split(',').map do |r|
    a, z = *r.split('-', 2).map(&:to_i)
    Range.new(a, z).to_a
  end

  p2_overlaps += 1 unless (first & second).size.zero?
end

puts "Part 2: #{p2_overlaps}"
