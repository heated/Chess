require_relative 'pieces.rb'

class Board
  def initialize
    @grid = Array.new(8) { Array.new(8) }
    castleman = Rook.new(:W, [0, 0], self)
    broknight = Knight.new(:B, [4, 0], self)
    p castleman.moves
  end

  def empty?(pos)
    @grid[pos[0]][pos[1]].nil?
  end

  def on_board?(pos)
    pos.all? { |coord| coord >= 0 && coord < 8 }
  end

  def [](pos)
    @grid[pos[0]][pos[1]]
  end

  def []=(pos, piece)
    @grid[pos[0]][pos[1]] = piece
  end

end

funtimes = Board.new
