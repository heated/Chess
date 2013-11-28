require 'io/console'

class HumanPlayer
  attr_reader :name
  def initialize(name = "John")
    @name = name
  end

  def play_turn(board, color)

    # puts "\nPick a piece to move."
    piece_pos = cursor_input(board)


    raise "That isn't your piece!" if board.enemy?(piece_pos, color)
    raise "There is no piece there!" if board.empty?(piece_pos)
    raise "That is not even a coordinate" unless board.on_board?(piece_pos)

    board.show_moves(piece_pos)
    p board

    # puts "\nWhere do you want to move to?"
    move_to_pos = cursor_input(board)

    board.hide_moves

    board.move(piece_pos, move_to_pos)
  end

  # a - h, 1 - 8
  private
  def cursor_input(board)
    press = ""
    until press == "\r"
      press = STDIN.getch
      x, y = board.cursor
      case press
      when "w"
        board.cursor = [x, y - 1]
      when "a"
        board.cursor = [x - 1, y]
      when "s"
        board.cursor = [x, y + 1]
      when "d"
        board.cursor = [x + 1, y]
      when "\u0003"
        exit
      end
      puts board
    end

    board.cursor
  end

  def parse_input(input)
    letters = ("a".."h").to_a

    coords = input.split("").map(&:strip)
    coords[0] = letters.index(coords.first)
    coords[1] = 8 - Integer(coords.last)
    coords
  end
end

class ComputerPlayer
  attr_reader :name
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