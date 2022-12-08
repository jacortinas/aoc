input = File.read('input.in')

class TreeGrid
  attr_reader :data, :height, :width

  def initialize(input)
    @data = input.lines(chomp: true).map do |line|
      line.chars.map(&:to_i)
    end

    @height = @data.size
    @width  = @data.first.size
  end

  def each_datum(&block)
    @data.each_with_index do |row, y|
      row.each_with_index do |datum, x|
        yield datum, x, y
      end
    end
  end

  def edge_count
    @width * 2  + (@height * 2 - 4)
  end

  def edge?(x, y)
    x == 0 || y == 0 || x == @width - 1 || y == @height - 1
  end

  def column_values(x)
    @data.map { |row| row[x] }
  end

  def row_values(y)
    @data[y]
  end
end

grid = TreeGrid.new(input)
visible_trees = grid.edge_count
most_scenic = 0

grid.each_datum do |cell, x, y|
  next if grid.edge?(x, y)

  row = grid.row_values(y)
  column = grid.column_values(x)

  row_before = row[0...x].reverse
  row_after = row[x+1..-1]
  column_before = column[0...y].reverse
  column_after = column[y+1..-1]

  unless row_before.any? { |c| c >= cell } && row_after.any? { |c| c >= cell } && column_before.any? { |c| c >= cell } && column_after.any? { |c| c >= cell }
    visible_trees += 1
  end

  scenic_counts = [column_before, row_before, column_after, row_after].map do |direction|
    direction.reduce(0) do |count, c|
      count += 1
      break count if c >= cell
      count
    end
  end

  score = scenic_counts.reduce(:*)
  most_scenic = score if score > most_scenic
end

puts "Part 1: #{visible_trees}"
puts "Part 2: #{most_scenic}"
