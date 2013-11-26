require_relative 'board.rb'

class Game
  attr_accessor :board
  def initialize(player_1, player_2)
    @board = Board.new
    setup_pieces
  end

  def setup_pieces
    positioning = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    8.times do |i|
      positioning[i].new(:b, [i, 0], @board)
      positioning[i].new(:w, [i, 7], @board)
      Pawn.new(:b, [i, 1], @board)
      Pawn.new(:w, [i, 6], @board)
    end
  end


  def play
    until @board.over?

    end
  end

  def get_move

  end
end

funtimes = Game.new(nil, nil)

p funtimes.board