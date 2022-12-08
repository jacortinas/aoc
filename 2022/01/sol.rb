input = File.read(File.join(File.dirname(__FILE__), 'input.in'))
output = input.split("\n\n").map do |elf_lines|
  elf_lines.split("\n").map(&:to_i).sum
end
puts "Part 1: #{output.max}"
puts "Part 2: #{output.max(3).sum}"
