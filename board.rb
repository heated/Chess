require_relative 'pieces.rb'

class Board
  def initialize
    @grid = Array.new(8) { Array.new(8) }
    p manpawn.moves
  end

  def empty?(pos)
    on_board?(pos) &&
    self[pos].nil?
  end

  def on_board?(pos)
    pos.all? { |coord| coord >= 0 && coord < 8 }
  end

  def enemy?(pos, color)
    unless empty?(pos)
      self[pos].color != color if on_board?(pos)
    end
  end

  def [](pos)
    @grid[pos[0]][pos[1]]
  end

  def []=(pos, piece)
    @grid[pos[0]][pos[1]] = piece
  end

end

funtimes = Board.new