SAMPLE = <<~SAMPLE
noop
addx 3
addx -5
SAMPLE

# input = SAMPLE
input = File.read('sample.in')
# input = File.read('input.in')

targets = [20, 60, 100, 140, 180, 220]

x_register = 1
cycle = 1
signal = 0

screen_writes = []

input.lines(chomp: true).each do |line|
  if line == "noop"
    signal += (x_register * cycle) if targets.include?(cycle)

    if x_register - 1 == cycle
      screen_writes << x_register - 1
    elsif x_register == cycle
      screen_writes << x_register
    elsif x_register + 1 == cycle
      screen_writes << x_register + 1
    end

    cycle += 1
    next
  end

  amount = line.split(' ', 2).last.to_i

  2.times do
    signal += (x_register * cycle) if targets.include?(cycle)

    if x_register - 1 == cycle
      screen_writes << x_register - 1
    elsif x_register == cycle
      screen_writes << x_register
    elsif x_register + 1 == cycle
      screen_writes << x_register + 1
    end

    cycle += 1
  end

  x_register += amount
end

puts "Part 1: #{signal}"

puts screen_writes.inspect
