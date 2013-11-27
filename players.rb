class HumanPlayer
  def initialize(name = "John")
    @name = name
  end

  def play_turn(board, color)
    puts "\nPick a piece to move."
    piece_pos = parse_input(gets.chomp)
    raise "That isn't your piece!" if board.enemy?(piece_pos, color)
    raise "There is no piece there!" if board.empty?(piece_pos)
    raise "That is not even a coordinate" unless board.on_board?(piece_pos)
    puts "\nWhere do you want to move to?"
    move_to_pos = parse_input(gets.chomp)
    board.move(piece_pos, move_to_pos)
  end

  # a - h, 1 - 8
  private
  def parse_input(input)
    letters = ("a".."h").to_a

    coords = input.split("").map(&:strip)
    coords[0] = letters.index(coords.first)
    coords[1] = 8 - Integer(coords.last)
    coords
  end
end

class ComputerPlayer
  def initialize(name = "DESTRUCTINATOR")
    @name = name
  end

  def play_turn(board, color)
    piece_pos, move_to_pos = board.pieces(color).inject([]) do |moves, piece|
      moves + piece.valid_moves.map {|move| [piece.pos, move] }
    end.sample
    puts "computer moves from #{piece_pos} to #{move_to_pos}"

    board.move(piece_pos, move_to_pos)
  end

end