require "pry"

SAMPLE = <<~EOS
  Sabqponm
  abcryxxl
  accszExk
  acctuvwj
  abdefghi
EOS

class Grid
  attr_reader :start_pos, :end_pos, :map

  def initialize(input)
    @start_pos = @end_pos = nil

    @map = input.lines(chomp: true).each_with_index.map do |line, y|
      line.chars.each_with_index.map do |char, x|
        if char == "S"
          @start_pos = [x, y]
          1
        elsif char == "E"
          @end_pos = [x, y]
          26
        else
          char.ord - 96
        end
      end
    end
  end

  def neighbors(x, y)
    [[x - 1, y], [x + 1, y], [x, y - 1], [x, y + 1]].select do |x, y|
      x >= 0 && y >= 0 && x < @map.first.size && y < @map.size
    end
  end

  def to_s
    output = []

    divider_line = "+#{'-' * ((@map[0].size * 3) + 7)}+"

    output << divider_line

    @map.each do |line|
      output << "|#{line.map { |v| v.to_s.rjust(3) }.join('|')}|"
      output << divider_line
    end

    output.join("\n")
  end
end

input = SAMPLE
grid = Grid.new(input)

puts grid.to_s
