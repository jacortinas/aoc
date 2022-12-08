SAMPLES = {
  "bvwbjplbgvbhsrlpgdmjqwftvncz" => 5,
  "nppdvjthqldpwncqszvftbrmjlhg" => 6,
  "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg" => 10,
  "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw" => 11
}

def marker_index(input, marker_length)
  buffer = []

  input.each_char.with_index do |char, index|
    if buffer.size == marker_length
      if buffer.size == buffer.uniq.size
        return index
      else
        buffer.shift
        buffer.push(char)
      end
    else
      buffer.push(char)
    end
  end
end

SAMPLES.each do |input, expected|
  puts "input: #{input}"
  puts "expected: #{expected}"
  puts "actual: #{marker_index(input, 4)}"
  puts "-----------------"
end

input = File.read("input.in", chomp: true)

puts "Part 1: #{marker_index(input, 4)}"
puts "Part 2: #{marker_index(input, 14)}"
