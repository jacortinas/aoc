require "set"

SAMPLE_INPUT = <<~SAMPLE
R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2
SAMPLE

# class Point
#   attr_reader :x, :y

#   def initialize(x, y)
#     @x, @y = x, y
#   end

#   def up
#     Point.new(x, y + 1)
#   end

#   def down
#     Point.new(x, y - 1)
#   end

#   def left
#     Point.new(x - 1, y)
#   end

#   def right
#     Point.new(x + 1, y)
#   end
# end

class Snake
  attr_reader :hx, :hy, :tx, :ty

  def initialize(hx: 0, hy: 0, tx: 0, ty: 0)
    @hx, @hy = hx, hy
    @tx, @ty = tx, ty

    @tail_positions = Set.new
    @tail_positions << [@tx, @ty]
  end

  def move(dir, amount)
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

  private

  def update_head(xd: nil, yd: nil)
    @hx += xd if xd
    @hy += yd if yd
    update_tail(xd: xd, yd: yd)
  end

  def update_tail(xd: nil, yd: nil)
    return if @hx == @tx && @hy == @ty

    if (@hx - @tx).abs > 0
      if @hy != @ty
        j
      else

      end
    elsif (@hy - @ty).abs > 0
      if @hx != @tx
        
      else

      end
    end
  end
end

input = SAMPLE_INPUT

snake = Snake.new

input.lines(chomp: true).each do |line|
  dir, amount = *line.split(' ', 2)
  snake.move(dir, amount.to_i)
  puts "[#{snake.hx} #{snake.hy}] [#{snake.tx} #{snake.ty}]"
end
