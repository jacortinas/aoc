require "set"

input = File.read('input.in')

start_pos = end_pos = nil

heights = input.lines(chomp: true).each_with_index.map do |line, y|
  line.chars.each_with_index.map do |char, x|
    if char == "S"
      start_pos = [x, y]
      1
    elsif char == "E"
      end_pos = [x, y]
      26
    else
      char.ord - 96
    end
  end
end

puts "#{heights.first.size}x#{heights.size} - #{heights.first.size * heights.size}"
puts "Start: #{start_pos.inspect} - End: #{end_pos.inspect}"

queue = [start_pos]
seen = Set.new
dists = { start_pos => 0 }

until queue.empty?
  cx, cy = *queue.shift

  seen << [cx, cy]

  if cx == end_pos[0] && cy == end_pos[1]
    puts "Part 1: #{dists[[cx, cy]]}"
    break
  end

  [[cx + 1, cy], [cx, cy + 1], [cx - 1, cy], [cx, cy - 1]].each do |nx, ny|
    next if nx.negative? || ny.negative?
    next if nx >= heights.first.size
    next if ny >= heights.size
    next if seen.include?([nx, ny])
    next if heights[ny][nx] - heights[cy][cx] > 1

    queue << [nx, ny] unless queue.include?([nx, ny])

    dists[[nx, ny]] = dists[[cx, cy]] + 1
  end
end

# ---

start_pos = nil

heights = input.lines(chomp: true).each_with_index.map do |line, y|
  line.chars.each_with_index.map do |char, x|
    if char == "S"
      1
    elsif char == "E"
      start_pos = [x, y]
      26
    else
      char.ord - 96
    end
  end
end

puts "#{heights.first.size}x#{heights.size} - #{heights.first.size * heights.size}"
puts "Start: #{start_pos.inspect}"

queue = [start_pos]
seen = Set.new
dists = { start_pos => 0 }

until queue.empty?
  cx, cy = *queue.shift

  seen << [cx, cy]

  if heights[cy][cx] == 1
    puts "Part 2: #{dists[[cx, cy]]}"
    break
  end

  [[cx + 1, cy], [cx, cy + 1], [cx - 1, cy], [cx, cy - 1]].each do |nx, ny|
    next if nx.negative? || ny.negative?
    next if nx >= heights.first.size
    next if ny >= heights.size
    next if seen.include?([nx, ny])
    next if heights[cy][cx] - heights[ny][nx] > 1

    queue << [nx, ny] unless queue.include?([nx, ny])

    dists[[nx, ny]] = dists[[cx, cy]] + 1
  end
end
