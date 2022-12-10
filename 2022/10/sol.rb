SAMPLE = <<~SAMPLE
noop
addx 3
addx -5
SAMPLE

class Processor
  MARKERS = [20, 60, 100, 140, 180, 220].freeze

  attr_accessor :xreg, :cycle, :signal, :instructions

  def initialize(input)
    @xreg = 1
    @cycle = 1
    @signal = 0
    @instructions = input.lines(chomp: true)
  end

  def run
    @instructions.each do |instruction|
      if instruction == "noop"
        tick()
      elsif instruction.start_with?("addx")
        amount = instruction.split(' ', 2).last

        tick()
        tick()

        update_register!(amount.to_i)
      end
    end
  end

  def tick
    update_signal!
    update_cycle!
  end

  private

  def update_register!(amount)
    @xreg += amount
  end

  def update_cycle!
    @cycle += 1
  end

  def update_signal!
    @signal += (@xreg * @cycle) if MARKERS.include?(@cycle)
  end
end

# input = SAMPLE
# input = File.read('sample.in')
# input = File.read('input.in')

processor = Processor.new(File.read('input.in'))
processor.run

puts "Part 1: #{processor.signal}"
