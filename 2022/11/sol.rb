require "pry"

SAMPLE = <<~EOS
Monkey 0:
  Starting items: 79, 98
  Operation: new = old * 19
  Test: divisible by 23
    If true: throw to monkey 2
    If false: throw to monkey 3

Monkey 1:
  Starting items: 54, 65, 75, 74
  Operation: new = old + 6
  Test: divisible by 19
    If true: throw to monkey 2
    If false: throw to monkey 0

Monkey 2:
  Starting items: 79, 60, 97
  Operation: new = old * old
  Test: divisible by 13
    If true: throw to monkey 1
    If false: throw to monkey 3

Monkey 3:
  Starting items: 74
  Operation: new = old + 3
  Test: divisible by 17
    If true: throw to monkey 0
    If false: throw to monkey 1
EOS

MONKEY_REGEXP = %r{Monkey (?<monkey_index>\d+):
\s+Starting items: (?<starting_items>.*)
\s+Operation: new = old (?<operation>\+|\-|\*) (?<operend>\d+|old)
\s+Test: divisible by (?<divisor>\d+)
\s+If true: throw to monkey (?<true_index>\d+)
\s+If false: throw to monkey (?<false_index>\d+)}

# input = SAMPLE
input = File.read('input.in')

def parse(input)
  input.split("\n\n").map do |chunk|
    match = chunk.strip.match(MONKEY_REGEXP)

    if match[:operend] == "old"
      operation = "**"
      operend = 2
    else
      operation = match[:operation]
      operend = match[:operend].to_i
    end

    {
      monkey: match[:monkey_index].to_i,
      items: match[:starting_items].split(", ").map(&:to_i),
      operation: operation,
      operend: operend,
      divisor: match[:divisor].to_i,
      true_index: match[:true_index].to_i,
      false_index: match[:false_index].to_i
    }
  end
end

monkeys = parse(input)

(1..20).each do |i|
  monkeys.each do |monkey|
    monkey[:inspections] ||= 0

    monkey[:items].each do |item|
      new_worry = item.send(monkey[:operation], monkey[:operend]).div(3)

      monkey[:inspections] += 1

      if (new_worry % monkey[:divisor]).zero?
        monkeys[monkey[:true_index]][:items] << new_worry
      else
        monkeys[monkey[:false_index]][:items] << new_worry
      end
    end

    monkey[:items] = []
  end

  puts "== After round #{i} =="
  monkeys.each do |monkey|
    puts "Monkey #{monkey[:monkey]} inspected items #{monkey[:inspections]} times."
  end
end

puts "Part 1: #{monkeys.map { |monkey| monkey[:inspections] }.max(2).reduce(&:*)}"

# ---

monkeys = parse(input)

lcm = monkeys.map { |monkey| monkey[:divisor] }.reduce(1, :lcm)

(1..10_000).each do |i|
  monkeys.each do |monkey|
    monkey[:inspections] ||= 0

    monkey[:items].each do |item|
      new_worry = item.send(monkey[:operation], monkey[:operend]) % lcm

      monkey[:inspections] += 1

      if (new_worry % monkey[:divisor]).zero?
        monkeys[monkey[:true_index]][:items] << new_worry
      else
        monkeys[monkey[:false_index]][:items] << new_worry
      end
    end

    monkey[:items] = []
  end

  if i == 1 || i == 20 || (i % 1_000).zero?
    puts "== After round #{i} =="
    monkeys.each do |monkey|
      puts "Monkey #{monkey[:monkey]} inspected items #{monkey[:inspections]} times."
    end
  end
end

puts "Part 2: #{monkeys.map { |monkey| monkey[:inspections] }.max(2).reduce(&:*)}"

