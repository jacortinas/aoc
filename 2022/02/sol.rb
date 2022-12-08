input = File.read('input.in')

def run_moves(opp_move, my_move)
  return 0 if opp_move == my_move # draw
  {AX: 3, AY: 6, AZ: 0, BX: 0, BY: 3, BZ: 6, CX: 6, CY: 0, CZ: 3}[:"#{opp_move}#{my_move}"]
end

def move_to_score(move)
  { A: 1, B: 2, C: 3, X: 1, Y: 2, Z: 3 }[move.to_sym]
end

output = input.lines.map do |turn|
  opp_move, my_move = turn.strip.split(' ', 2)
  run_moves(opp_move, my_move) + move_to_score(my_move)
end


puts "Part 1: #{output.sum}"

def move_for_outcome(opp_move, expected_outcome)
  {AX: 'Z', AY: 'X', AZ: 'Y', BX: 'X', BY: 'Y', BZ: 'Z', CX: 'Y', CY: 'Z', CZ: 'X'}[:"#{opp_move}#{expected_outcome}"]
end

output = input.lines.map do |turn|
  opp_move, expected_outcome = turn.strip.split(' ', 2)
  my_move = move_for_outcome(opp_move, expected_outcome)
  run_moves(opp_move, my_move) + move_to_score(my_move)
end

puts "Part 2: #{output.sum}"
