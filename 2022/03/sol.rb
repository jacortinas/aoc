input = File.read('input.in')

def char_to_priority(char)
  case char
  when 'A'..'Z' then char.ord - 38
  when 'a'..'z' then char.ord - 96 
end

p1_output = input.each_line.map do |line|
  chars = line.strip.chars
  len = chars.length

  first_half = chars[0, len / 2]
  second_half = chars[len / 2, len]

  intersections = first_half & second_half
  intersections.map { |c| char_to_priority(c) }.sum
end

puts "Part 1: #{p1_output.sum}"

p2_output = input.each_line.each_slice(3).map do |lines|
  lines.map!(&:strip).map!(&:chars)
  intersections = lines[0] & lines[1] & lines[2]
  char_to_priority(intersections.first)
end

puts "Part 2: #{p2_output.sum}"
