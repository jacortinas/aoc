input = File.read('input.in')

output = input.lines(chomp: true).map(&:to_i).each_cons(2).reduce(0) do |incs, pair|
  if pair[0] < pair[1]
    incs + 1
  else
    incs
  end
end

puts "Part 1: #{output}"

output = input.lines(chomp: true).each_cons(3).map { |t| t.map(&:to_i).sum }.each_cons(2).reduce(0) do |incs, pair|
  if pair[0] < pair[1]
    incs + 1
  else
    incs
  end
end

puts "Part 2: #{output}"

