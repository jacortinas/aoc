SAMPLE_INPUT = <<~STRING
    [D]    
[N] [C]    
[Z] [M] [P]
 1   2   3 

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
STRING

# input = SAMPLE_INPUT
input = File.read('input.in')

supplies = Hash.new { |h, k| h[k] = [] }

supply_lines, instruction_lines = input.split("\n\n")

supply_lines.lines(chomp: true).reverse[1..-1].each do |line|
  row = line.chars.each_slice(4).to_a
  row.map! { |slice| slice.uniq.reject { |c| ["[", "]", " "].include?(c) }.first }

  row.each_with_index do |supply, index|
    supplies[index + 1] << supply if supply
  end
end

# ---

# p1_supplies = supplies.dup

# instruction_lines.lines(chomp: true).each do |line|
#   amount, from, to = line.scan(/\d+/).map(&:to_i)

#   amount.times do
#     if p1_supplies[from].any?
#       p1_supplies[to].append(p1_supplies[from].pop)
#     end
#   end
# end

# puts "Part 1: #{p1_supplies.values.map(&:last).join}"

# ---

p2_supplies = supplies.dup

puts p2_supplies.inspect

instruction_lines.lines(chomp: true).each do |line|
  amount, from, to = line.scan(/\d+/).map(&:to_i)
  supplies[to].append(*p2_supplies[from].pop(amount))
end

puts p2_supplies.inspect

puts "Part 2: #{p2_supplies.values.map(&:last).join}"
