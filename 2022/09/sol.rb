require "set"

SAMPLE_INPUT = <<~SAMPLE
R 5
U 8
L 8
D 3
R 17
D 10
L 25
U 20
SAMPLE

class Rope 
  attr_reader :segments, :head_positions, :tail_positions

  def initialize(hx: 0, hy: 0, length: 1)
    @hx, @hy = hx, hy

    @segments = []  
    length.times { @segments << [hx, hy] }

    @head_positions = Set.new(@segments)
    @tail_positions = Set.new(@segments)
  end

  def move(dir, amount = 1)
    case dir
    when "U"
      amount.times { update_head(yd: 1) }
    when "R"
      amount.times { update_head(xd: 1) }
    when "D"
      amount.times { update_head(yd: -1) }
    when "L"
      amount.times { update_head(xd: -1) }
    end
  end

  def head_pos
    [@hx, @hy]
  end

  def tail_pos
    @segments.last
  end

  private

  def update_head(xd: nil, yd: nil)
    @hx += xd if xd
    @hy += yd if yd

    @head_positions << [@hx, @hy]

    update_segments()
  end

  def update_segments
    @segments.each_with_index do |segment, index|
      sx, sy = segment[0], segment[1]

      if index == 0
        lx, ly = @hx, @hy
      else
        lx = @segments[index - 1][0]
        ly = @segments[index - 1][1]
      end

      if (lx - sx).abs == 2 || (ly - sy).abs == 2
        lx > sx ? sx += 1 : sx -= 1 if lx != sx
        ly > sy ? sy += 1 : sy -= 1 if ly != sy
      end

      @segments[index] = [sx, sy]
    end

    @tail_positions << tail_pos
  end
end

input = SAMPLE_INPUT

rope = Rope.new(length: 9)

input.lines(chomp: true).each do |line|
  dir, amount = *line.split(' ', 2)
  rope.move(dir, amount.to_i)
end

# Grid rendering
min_x, max_x = [*rope.head_positions, *rope.tail_positions].map(&:first).minmax
min_y, max_y = [*rope.head_positions, *rope.tail_positions].map(&:last).minmax

grid = Array.new(max_y - min_y + 1) do
  Array.new(max_x - min_x + 1, '.')
end

puts "-- Sample Grid --"

grid.zip(max_y.downto(min_y)).each do |row, y|
  output = []

  row.zip(min_x.upto(max_x)).each do |cell, x|
    cell = '#' if rope.tail_positions.include?([x, y])
    cell = 'S' if x == 0 && y == 0

    if (num = rope.segments.index([x, y]))
      cell = (num + 1).to_s
    end

    cell = 'H' if rope.head_pos[0] == x && rope.head_pos[1] == y
    output << cell
  end

  puts output.join(' ')
end

puts "Head: [#{rope.head_pos[0]} #{rope.head_pos[1]}]"
puts "Tail positions: #{rope.tail_positions.size}"

# ---

input = File.read('input.in')

short_rope = Rope.new(length: 1)
long_rope = Rope.new(length: 9)

input.lines(chomp: true).each do |line|
  dir, amount = *line.split(' ', 2)
  short_rope.move(dir, amount.to_i)
  long_rope.move(dir, amount.to_i)
end

puts "---"

puts "Part 1: #{short_rope.tail_positions.size}"
puts "Part 2: #{long_rope.tail_positions.size}"
